from CodeModule.cmd import command, logged, argument, group
from CodeModule.systems import gb
from CodeModule.exc import InvalidFileCombination

IDENTIFY_LIST = []

@argument("files", nargs = "+", type=str, metavar='foo.rom', help="List of files to identify")
@command
@logged("identify")
def identify(logger, files, **kwargs):
    """Extract a resource from a game's ROM image."""
    
    for filename in files:
        fileobj = open(filename, "rb")
        if fileobj is None:
            print("File " + filename + " does not exist or could not be opened")
            continue
        
        result = identify_stream(fileobj, filename)
        
        if result is None:
            print("File " + filename + " could not be identified")
        else:
            print("File " + filename + " is " + result["name"] + " with score " + str(result["score"]))

def identifier(func):
    """Wrapper which adds a callable to the list of file identifiers."""
    IDENTIFY_LIST.append(func)
    return func

def identify_stream(fileobj, filename = None):
    """Given a file object and optional name, returns a list of scores and results.
    
    The result objects can be turned into classes that have the proper APIs for
    data extraction and injection. Consult construct_result_object for more info."""
    results = []
    
    for func in IDENTIFY_LIST:
        results.extend(func(fileobj, filename))
    
    sorted_results = []
    for result in results:
        if result["score"] > 0:
            return_results.append(result["score"], result)
    
    return sorted_results

def construct_result_object(result):
    klass = None
    if "class_bases" in result.keys():
        name = ""
        for classbase in result["class_bases"]:
            name += classbase.__name__
        
        klass = type(name, result["class_bases"], {})
    elif "class" in result.keys():
        klass = result["class"]
    
    return klass()

def instantiate_resource_streams(files):
    """Given a set of files, construct an object for them which can read and write resource data."""
    file_results = {}
    file_streams = {}
    
    for filename in files:
        file_streams[filename] = open(filename, "rb")
        file_results[filename] = identify_stream(file_streams[filename], filename)
        
        if file_results[filename] == None:
            print("File " + filename + " could not be identified")
    
    #Merge file results into single list of potentially compatible bases
    base_index = {}
    for filename, resultlist in file_results.items():
        for result in resultlist:
            classlist = None
            if "class_bases" in result.keys():
                classlist = result["class_bases"]
            elif "class" in result.keys():
                classlist = [result["class"]]
            else:
                continue
            
            if classlist not in base_compatibility_index:
                base_index[classlist] = {"result": result, "compatible": 0, "score": 0, "streammap":{}}
            
            base_index[classlist]["compatible"] += 1
            base_index[classlist]["score"] += result["score"]
            base_index[classlist]["streammap"][filename] = result["stream"]
    
    compatible_bases = []
    for base_list, base_data in base_index.items():
        if base_index["compatible"] < len(files):
            continue
        else:
            compatible_bases.append((base_data["score"], base_list))
    
    if len(compatible_bases) == 0:
        raise InvalidFileCombination
    
    winning_base = None
    winning_score = -1
    for score, base_list in compatible_bases:
        if score > winning_score:
            winning_score = score
            winning_base = base_list
    
    robject = construct_result_object(base_index[winning_base]["result"])
    
    for filename, streamname in base_index[winning_base]["streammap"].items():
        robject.install_stream(file_streams[filename], streamname)
    
    return robject
