from CodeModule.cmd import command, argument, logged
import os

@argument("cmpfiles", nargs = '+', type=str, metavar='foo.o')
@argument("-w", type=int, default=80, dest="conwid", help="Maximum width of verbose detail lines.")
@argument("-f", action="append", nargs=2, dest="filtered", help="Specify [x,y) ranges of bytes to avoid reporting on.")
@argument("-v", action="store_const", const=True, default=False, dest="verbose", help="Enable difference detail lines.")
@argument("-p", action="store_const", const=True, default=False, dest="pretty", help="Pretty-print option. Merges diffs close together and makes all diffs print as wide as the console (see -w)")
@command
@logged("cmp")
def bincmp(logger, cmpfiles, conwid, filtered, verbose, pretty, **kwargs):
    curdiff = None #list of [0,1) set ranges on the whole list of files
    difflist = []
    files = []
    maxsize = 0
    
    #manually parse filtered list
    if filtered is not None:
        for filterchunk in filtered:
            filterchunk[0] = int(filterchunk[0], 0)
            filterchunk[1] = int(filterchunk[1], 0)
    
    #determine the size of each file
    for filename in cmpfiles:
        fileobj = open(filename, 'rb')
        fileobj.seek(0, os.SEEK_END)
        filesize = fileobj.tell()
        fileobj.seek(0)
        files.append((fileobj, filesize))
        
        if filesize > maxsize:
            maxsize = filesize
    
    #sanitify the filtered list
    if filtered is not None:
        filtered.sort()
        storpos = 0
        frompos = 1
        topos = 0
        
        while frompos < len(filtered):
            newfilter = filtered[frompos]
            oldfilter = filtered[topos]
            
            if newfilter[0] <= oldfilter[1]:
                filtered[topos] = [oldfilter[0], max(newfilter[1], oldfilter[1])]
                frompos += 1
            else:
                filtered[storpos] = filtered[topos]
                
                topos = frompos
                frompos += 1
                storpos += 1
        else:
            filtered[storpos] = filtered[topos]
            filtered = filtered[0:storpos+1]
    else:
        filtered = []
    
    filterpos = 0
    
    #scan through each file in-order and find differences
    for bytepos in range(0, maxsize):
        curfilter = [-5, -1]
        if filterpos < len(filtered):
            curfilter = filtered[filterpos]
        
        if bytepos >= curfilter[0]:
            if bytepos < curfilter[1]:
                if curdiff is not None:
                    curdiff[1] = bytepos
                    difflist.append(curdiff)
                    curdiff = None
                
                continue
            elif bytepos >= curfilter[1]:
                filterpos += 1
        
        bytes = []
        for fileobj, filesize in files:
            if bytepos <= filesize:
                fileobj.seek(bytepos)
                bytes.append(fileobj.read(1))
            else:
                bytes.append(None)
        
        if bytes.count(bytes[0]) < len(bytes):
            if curdiff is not None:
                curdiff[1] = bytepos
            else:
                curdiff = [bytepos, bytepos+1]
        else:
            if curdiff is not None:
                difflist.append(curdiff)
                curdiff = None
    
    if curdiff is not None:
        difflist.append(curdiff)
    
    #Determine the optimal size for a particular console width
    maxchars = conwid // 4
    
    #merge similar segments together
    if pretty:
        olddifflist = difflist
        difflist = []
        
        for olddiff in olddifflist:
            if len(difflist) == 0:
                difflist.append(olddiff)
                continue
            
            targetdiff = difflist[-1]
            
            #if the space between two diffs is less than one console line,
            #merge the two diffs together
            if abs(targetdiff[1] - olddiff[0]) < maxchars:
                targetdiff[1] = olddiff[1]
            else:
                difflist.append(olddiff)
    
    output = []
    
    for diffrange in difflist:
        output.append("Difference from 0x%(begin)X to 0x%(end)X" % {"begin":diffrange[0], "end":diffrange[1]})
        
        if verbose:
            output.append(":\n")
            tpos = diffrange[0]
            while tpos < diffrange[1]:
                for fileobj, filesize in files:
                    eol = min(maxchars, tpos - diffrange[1])
                    if pretty:
                        eol = maxchars
                    
                    psdat = []
                    for pos in range(tpos, tpos+eol):
                        if pos < filesize:
                            fileobj.seek(pos)
                            by = fileobj.read(1)
                            output.append("%02X " % ord(by))
                            if ord(by) > 0x20 and ord(by) < 0x7F:
                                psdat.append(chr(ord(by)))
                            else:
                                psdat.append(" ")
                        else:
                            output.append("-- ")
                            psdat.append(" ")
                    
                    output.append("%s\n" % "".join(psdat))
                output.append("\n")
                tpos += eol
        else:
            output.append("\n")
    
    print("".join(output))
