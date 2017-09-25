from CodeModule.cmd import command, argument, logged
from CodeModule.games import identify
import os, json

@argument("-id", nargs = 1, type=str, metavar='2:34', default=None, help="ID or name string of resource being extracted. If unspecified, attempts to extract everything. Format of string depends on game.")
@argument("restype", nargs = 1, type=str, metavar='text', help="Type of resource being extracted.")
@argument("srcfiles", nargs = '+', type=str, metavar='foo.gbc', help="One or more of the game's source files in a compatible image format.")
@argument("-o", nargs = 1, type=str, metavar='foo.hack', dest="dstdir", default=".", help="Path to directory to store extracted data.")
@command
@logged("extract")
def extract(logger, srcfiles, restype, **kwargs):
    """Extract a resource from a game's ROM image."""
    dstdir = kwargs.get("dstdir", ".")
    resid = kwargs.get("resid", None)
    if type(restype) is list:
        restype = restype[0]
    
    if not os.path.exists(dstdir):
        logger.critical("Destination path does not exist")
        return 1
    
    robject = identify.instantiate_resource_streams(srcfiles)
    
    typeinfo = robject.resource_information(restype)
    
    if typeinfo["storage_pattern"] == "singleton":
        #Singleton objects exist once in the game ROM and have no ID to extract.
        data = robject.extract_resource(restype, None)
        
        filename = typeinfo["singleton_name"]
        if "file_extension" in typeinfo.keys():
            filename += "."
            filename += typeinfo["file_extension"]
        elif type(typeinfo["extracted_as"]) is type:
            filename += ".json"
        
        filepath = os.path.join(dstdir, filename)

        #Extracted data is encoded to json if the extract type is a Python type
        if type(typeinfo["extracted_as"]) is type:
            fileobj = open(filepath, "wt", encoding="utf-8")
            json.dump(data, fileobj)
        elif type(data) is bytes: #otherwise the returned data type is text or binary data
            fileobj = open(filepath, "wb")
            fileobj.write(data)
        elif type(data) is str:
            fileobj = open(filepath, "wt", encoding="utf-8")
            fileobj.write(data)
        
    elif typeinfo["storage_pattern"] == "array": #Arrays of fixed-size items
        pass #TODO: Support the "array" storage pattern
    elif typeinfo["storage_pattern"] == "table": #Array of pointers to variable-size data
        pass #TODO: Support the "table" storage pattern
