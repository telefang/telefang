"use strict";

var FONTS = getFontMetrics();
var CHARS = getChars();
var CHARSET = {};
for (var i = 0; i < CHARS.length; i++) {
  CHARSET[CHARS[i]] = true;
}
var DESCENDING_CHAR_LENGTHS = [];
for (var i = 0; i < CHARS.length; i++) {
  var length = CHARS[i].length;
  if (CHARS.indexOf(length) === -1) {DESCENDING_CHAR_LENGTHS.push(length);}
}
DESCENDING_CHAR_LENGTHS.sort(function(x, y) {return y - x;});

var WHITESPACE_CHARS = [" ", "　"];
var BREAK_CHARS_ARR = [
  '？', '！', '。', '▷', '▶', '×', '・', '『', '』', '╱', '▼', '–', 'ー',
  '<', '>', ':', ';', '~', '…', '‼', '🎵', '♫', '♪', '⚡', '!', '#',
  '$', '%', '&', ')', '*', '+', ',', '-', '.', '/', '▷', ':', ';',
  '<', '=', '>', '?', '@', '\\', ']', '^', '_', '`', '|', '}', '~'
];
var BREAK_CHARS = {};
for (var i = 0; i < BREAK_CHARS_ARR.length; i++) {
  BREAK_CHARS[BREAK_CHARS_ARR[i]] = true;
}

// Currently only works for the SMS and Field Guide sheet.
// Formatting parameters only lightly configurable at the moment.
// Would need extension to support more complex formatting (e.g. questions).
var SHEET_PARAMS = {
  "script/denjuu/sms.messages.csv": {
    width: 6 * 8,
    prelude: '',
    envoi: '<*4>'
  },
  "script/denjuu/descriptions.messages.csv": {
    width: 14 * 8,
    prelude: '<S0>',
    envoi: '<*4>'
  }
}
function formatSelectedRows() {
  var sheet = SpreadsheetApp.getActiveSheet();
  var sheetName = sheet.getName();
  if (!SHEET_PARAMS.hasOwnProperty(sheetName)) {throw "Only the SMS and Field Guide sheets are supported at the moment.";}
  var params = SHEET_PARAMS[sheetName];
  
  var ranges = sheet.getActiveRangeList().getRanges();
  var rows = [];
  for (var i = 0; i < ranges.length; i++) {
    var range = ranges[i];
    var start = range.getRow();
    var end = range.getLastRow();
    for (var row = start; row <= end; row++) {
      if (rows.indexOf(row) === -1) {rows.push(row);}
    }
  }
  rows.sort(function(x, y) {return x - y;});
  
  for (var i = 0; i < rows.length; i++) {
    Logger.log("rowy");
    var row = rows[i];
    var pointerVal = sheet.getRange(row, 1).getValue();
    if (pointerVal[0] === '#') {continue;}
    
    var draftText = sheet.getRange(row, 4).getValue();
    if (params.prelude && draftText.slice(0, params.prelude.length) === params.prelude) {
      draftText = draftText.slice(params.prelude.length);
    }
    if (params.envoi && draftText.slice(draftText.length - params.envoi.length) === params.envoi) {
      draftText = draftText.slice(0, draftText.length - params.envoi.length);
    }
    
    var formatted = wrap(draftText, params.width);
    formatted = (params.prelude || '') + formatted + (params.envoi || '');
    
    sheet.getRange(row, 3).setValue(formatted);
  }
}

var CharType = {
  WORD:       0,
  BREAK_CHAR: 1,
  WHITESPACE: 2,
  NEWLINE:    3
};

function wrap(text, width, font) {
  // To support changing fonts in the middle of text,
  // control code support will have to be added.
  // Perhaps an object-oriented restructuring could help
  // with that (so control code functions can do things
  // like set font state and add to the word width)?
  font = typeof font !== 'undefined' ? font : "normal";
  font = FONTS[font];
  
  var lines = [];
  
  // "Word" here being an unbreakable unit.
  // For example, "big-time" is two words: "big-" and "time".
  var curLineWidth = 0;
  var curLineStart = 0;
  var curWordWidth = 0;
  var prevWordWidth = 0;
  var lastWordStart = 0;
  var lastWordEnd = 0;
  var prevCharType = CharType.WORD;
  var curCharType = CharType.WORD;
  var i = 0;
  // Run an iteration when the text has been exhausted too, so a
  // "to EOF" transition happens and the last line gets pushed.
  while (i <= text.length) {
    prevCharType = curCharType;
    
    // Get the next character.
    var char = '';
    var charLength;
    var charWidth;
    
    if (i === text.length) {
      charLength = 1; // To make the while loop end.
      curCharType = CharType.EOF;
    } else {
      var curTestChar;
      for (var j = 0; j < DESCENDING_CHAR_LENGTHS.length; j++) {
        charLength = DESCENDING_CHAR_LENGTHS[j];
        curTestChar = text.slice(i, i + charLength);
        if (CHARSET[curTestChar]) {
          char = curTestChar;
          // Since the slice might grab something shorter at the end of the string.
          charLength = curTestChar.length;
          break;
        }
      }
      if (!char) {throw "Character not in charset: \"" + curTestChar + "\"";}
      
      charWidth = font[char];
      curLineWidth += charWidth;
      
      if (WHITESPACE_CHARS.indexOf(char) !== -1) {curCharType = CharType.WHITESPACE;}
      else if (BREAK_CHARS[char]) {curCharType = CharType.BREAK_CHAR;}
      else if (char === '\n') {curCharType = CharType.NEWLINE; charWidth = 0;}
      else {curCharType = CharType.WORD;}
    }
    
    // Transitions that trigger a word end.
    if ((prevCharType === CharType.WORD       && curCharType === CharType.WHITESPACE) ||
        (prevCharType === CharType.BREAK_CHAR && curCharType !== CharType.BREAK_CHAR) ||
        (prevCharType !== CharType.WHITESPACE && curCharType === CharType.NEWLINE) ||
        (prevCharType !== CharType.WHITESPACE && curCharType === CharType.EOF))
    {
      lastWordEnd = i;
      // -1 to strip off the last post-letter 1px space.
      prevWordWidth = curWordWidth - 1;
    }
    // Transitions that trigger a word start.
    if ((
           (prevCharType === CharType.WHITESPACE || prevCharType === CharType.NEWLINE) &&
           (curCharType === CharType.WORD || curCharType === CharType.BREAK_CHAR)
        ) ||
        (prevCharType === CharType.BREAK_CHAR && curCharType === CharType.WORD))
    {
      lastWordStart = i;
      curWordWidth = 0;
    }
    
    // Width is added even on non-word characters, but it shouldn't matter,
    // since curWordWidth is reset on word starts and newlines, and thus
    // never used when curWordWidth includes whitespace characters.
    curWordWidth += charWidth + 1;
    
    // Add a line if:
    // * a word that needs to be put on the next line has been started,
    // * a newline character has been encountered, or
    // * we've reached the end of the text.
    if ((curLineWidth > width && lastWordStart >= lastWordEnd && lastWordStart !== curLineStart) ||
        (curCharType === CharType.NEWLINE) ||
        (curCharType === CharType.EOF))
    {
      lines.push(text.slice(curLineStart, lastWordEnd));
      if (prevWordWidth > width) {lines[lines.length - 1] += " // Word too wide";}
      
      if (curCharType === CharType.NEWLINE) {
        // So lastWordStart doesn't trigger another line break on the next character.
        lastWordStart = i + charLength;
        // So word widths from previous lines don't carry over to the next.
        // (When a newline is encountered, a word start/end isn't necessarily triggered.)
        prevWordWidth = curWordWidth = 0;
      }
      
      curLineStart = lastWordStart;
      curLineWidth = curWordWidth;
    } else {
      // Post-letter 1px space.
      curLineWidth += 1;
    }

    i += charLength;
  }
  
  return lines.join('\n');
}
