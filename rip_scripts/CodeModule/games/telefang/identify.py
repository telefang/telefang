from CodeModule.games.identify import identifier
from CodeModule.systems import gb

@identifier
def identify_telefang(fileobj, filename = None):
    results = []
    
    gameboy_results = gb.identify_file(fileobj, filename)
    valid_result = None
    for result in gameboy_results:
        if result["score"] > 0:
            valid_result = result
            break
    else:
        return [] #If image isn't a valid Gameboy ROM it sure as hell isn't a valid Telefang ROM
    
    #TODO: Do some tests on the ROM to check if it looks like a Telefang ROM.
    
    return [{"class_bases":(),
        "score":valid_result["score"],
        "name":"Telefang (GBC, Nov 2000, Japanese) ROM Image",
        "stream":valid_result["stream"],
        "see_also":[valid_result]}]
