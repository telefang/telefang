function previewSelectedCells() {
  var sheet = SpreadsheetApp.getActiveSheet();
  var sheetName = sheet.getName();
  if (!SHEET_PARAMS.hasOwnProperty(sheetName)) {throw "This sheet isn't supported at the moment.";}
  var params = SHEET_PARAMS[sheetName];
  
  var ranges = sheet.getActiveRangeList().getRanges();
  for (var i = 0; i < ranges.length; i++) {
    var range = ranges[i];
    for (var y = range.getLastRow(); y >= range.getRow(); y--) {
      for (var x = range.getLastColumn(); x >= range.getColumn(); x--) {
        var cell = sheet.getRange(y, x, 1, 1);
        var text = cell.getValue();
        
        text = text.length > 0 ? text : " "; // REMOVE ONCE WEB PREVIEW HAS BEEN UPDATED
  
        if (params.prelude && text.slice(0, params.prelude.length) === params.prelude) {
          text = text.slice(params.prelude.length);
        }
        if (params.envoi && text.slice(text.length - params.envoi.length) === params.envoi) {
          text = text.slice(0, text.length - params.envoi.length);
        }
        
        if (cell.getColumn() == 4) { // Draft column (in the currently supported sheets, at least).
          text = wrap(text, params.width, params.lines_per_prompt);
        }
        
        var image = fetchImagePreview(text, params.width, params.line_spacing, params.lines_per_page, params.lines_per_prompt, params.min_lines);
        sheet.insertImage(image, cell.getColumn(), cell.getRow(), sheet.getColumnWidth(cell.getColumn()) + 1, 0);
      }
    }
  }
}
