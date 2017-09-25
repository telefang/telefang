from CodeModule.cmd import command, logged, argument, group
from CodeModule.asm import asmotor, linker, writeout, rgbds
from CodeModule.systems.helper import lookup_system_bases
from CodeModule.exc import PEBKAC

@argument('infiles', nargs = '+', type=str, metavar='foo.o', help = "Assembled input object files to link")
@argument('-f', type=str, metavar="asmotor", default = "rgbds", dest = "infmt", help = "Name of input object format")
@argument('-o', type=str, action="append", metavar='fubarmon.gb', dest = "outfiles", help = "ROM image output file")
@argument('--baserom', type=str, nargs=1, metavar='fubarmon-j.gb', dest = "baserom", help = "Optional base ROM to apply patches over when linking.")
@argument('-p', type=str, action="append", metavar='gb', dest = "platform", help = "Target hardware being linked to")
@command
@logged("linker")
def link(logger, infiles, infmt, outfiles, baserom, platform, **kwargs):
    """Link object code into a final format."""
    
    platforms = []
    
    for platformcnk in platform:
        platforms.extend(platformcnk.split(","))
    
    logdata = {"infmt":infmt, "platform":platforms}
    
    logger.info("Begin %(infmt)s linking operation with %(platform)r..." % logdata)
    
    platcls = type("platcls", lookup_system_bases(platforms), {})
    plat = platcls()
    
    lnk = None
    
    if infmt == 'asmotor':
        lnk = asmotor.ASMotorLinker(plat)
        return
    elif infmt == 'rgbds':
        lnk = rgbds.RGBDSLinker(plat)
    else:
        logger.fatal("Unknown object code format.")
        return

    #Create writeout object
    wotgt = None
    
    if baserom is not None and baserom != "":
        wotgt = writeout.OverlayWriteout(bases = {"ROM":baserom[0]},
            streams = {"ROM":outfiles[0]}, platform = plat)
    else:
        wotgt = writeout.ROMWriteout(streams = {"ROM":outfiles[0]}, platform = plat)
    
    logdata["lenfname"] = len(infiles)
    
    logger.info("Loading %(lenfname)d files..." % logdata)
    for fname in infiles:
        lnk.loadTranslationUnit(fname)
    
    logger.info("Fixating (assigning concrete values to) sections...")
    lnk.fixate()
    
    logger.info("Resolving symbols...")
    lnk.resolve()
    
    logger.info("Patching data values to match linker decisions...")
    lnk.patchup()
    
    logger.info("Writing your data out to disk.")
    lnk.writeout(wotgt)
    
    logger.info("Thank you for flying with CodeModule airlines.")
