class BasePlatform(object):
    def banked2flat(self, bank, addr):
        return (0, None)
    
    def flat2banked(self, addr, src):
        return (0, 0)

from CodeModule.systems.gb import VARIANTLIST as GBVariantList
from CodeModule.cmd import logged
from CodeModule.asm import asmotor, linker
from CodeModule.exc import PEBKAC

#The variant list is structured as a tree of dictionaries.
#Each dictionary has platform names as keys and tuples of (Base, ChildNode) as values.
#The Base is a class base object, ChildNode is another dictionary or None.
#If ChildNode isn't None, then it is another variant dictionary which must be indexed
#to get another base.
VARIANTLIST = {}
VARIANTLIST.update(GBVariantList)

@logged("pfrm")
def lookup_system_bases(logger, exbn):
    """Given a list of platform attributes, return tuple of bases to construct a class with."""
    
    #shallow copy the basename list
    basenames = []
    for bn in exbn:
        basenames.append(bn)
    
    bases = []
    next_vlist = VARIANTLIST
    
    while next_vlist != None:
        cur_bn = None
        
        for basename in basenames:
            if basename in next_vlist.keys():
                bases.append(next_vlist[basename][0])
                next_vlist = next_vlist[basename][1]
                cur_bn = basename
        
        if cur_bn is None:
            logger.error("No matching platform base in %(basenames)s" % {"basenames":basenames})
            raise PEBKAC
        
        basenames.remove(cur_bn)
    
    logger.debug(repr(bases))
    return tuple(bases)
