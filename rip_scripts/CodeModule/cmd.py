import argparse, sys, logging

parser = argparse.ArgumentParser(description="Low-level programming/hacking framework")
parser.add_argument("--loglv", default="INFO")
subparser = parser.add_subparsers()

def global_options(loglv="NOTSET", **kwargs):
    logging.getLogger("").setLevel(loglv)

class commandcls(object):
    def __init__(self, wrapped):
        self.__func = wrapped
        self.__name__ = self.__func.__name__.replace("_", "-")
        self.__doc__ = ""
        try:
            self.__doc__ = self.__func.__doc__
        except:
            pass
        
        self.__parser = subparser.add_parser(self.__name__, help=self.__doc__)
        self.__parser.set_defaults(func=self)
        self.__curgroup = None
    
    def __call__(self, resp, *args, **kwargs):
        rkwargs = vars(resp)
        
        global_options(**rkwargs)
        kwargs.update(rkwargs)
        
        return self.__func(*args, **kwargs)

def command(func):
    return commandcls(func)
    
def argument(*args, **kwargs):
    def decorum(self):
        if self._commandcls__curgroup is not None:
            self._commandcls__parser.add_argument(*args, group=self.__curgroup, **kwargs)
        else:
            self._commandcls__parser.add_argument(*args, **kwargs)
        
        return self
    return decorum

def group(*args, **kwargs):
    def decorum(self):
        self._commandcls__curgroup = self._commandcls__parser.add_group(*args, **kwargs)
        return self
    return decorum

logging.basicConfig(format = "[%(name)-8.8s|%(levelname)-1.1s|%(filename)s:%(lineno)d] %(message)s")

def logged(loggername = None, logcalls = False, calllvl = logging.DEBUG, logexcept = True, exceptlvl = logging.FATAL, catchexcept = False, logsuccess = False, successlvl = logging.DEBUG):
    def loggedifier(innerfunc):
        ologger = logging.getLogger(loggername)
        
        def outerfunc(*args, **kwargs):
            logdata = {"ifname": innerfunc.__name__,
                     "args": args,
                     "kwargs": kwargs}
            
            if logcalls:
                ologger.log(calllvl,
                    "%(ifname)s called with args: %(args)r and keyword args: %(kwargs)r" % logdata)
            
            try:
                retval = innerfunc(ologger, *args, **kwargs)
            except Exception as e:
                if logexcept:
                    ologger.log(exceptlvl, "%(ifname)s raised an exception!" % logdata)
                    ologger.log(exceptlvl, "Called with args %(args)r and kwargs %(kwargs)r." % logdata, exc_info = True)
                
                if not catchexcept:
                    raise e
            else:
                logdata["retval"] = retval
                
                if logsuccess:
                    ologger.log(successlvl, "%(ifname)s returned: %(retval)r" % logdata)
                
                return retval
        
        outerfunc.__name__ = innerfunc.__name__
        return outerfunc
    return loggedifier

def main(argv = sys.argv):
    #for right now, just import everything we know has commands
    #in the future, add some import machinery magic to import everything named "commands"
    import CodeModule.asm.commands
    import CodeModule.fileops.cmp
    import CodeModule.games.identify
    import CodeModule.games.extract
    
    try:
        resp = parser.parse_args(argv[1:])
        rcode = resp.func(resp)
        
        if type(rcode) is not int:
            rcode = 0
        
        sys.exit(rcode)
    except:
        sys.exit(1)
