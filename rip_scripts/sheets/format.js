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
  // Break chars right before a word shouldn't be broken after.
  // For example, "...Hey!" shouldn't be split up into "..." and "Hey!".
  LEADING_BREAK_CHAR: 1,
  BREAK_CHAR: 2,
  WHITESPACE: 3,
  NEWLINE:    4
};

function wrap(text, width, promptPageLines, font) {
  var prompts = typeof promptPageLines !== 'undefined';
  
  var lines = _wrap(text, width, promptPageLines, font);
  Logger.log(lines);
  
  // The last line in dialogue always has a prompt on it.
  // The last line returned by _wrap may exceed the "with prompt" width,
  // so if that's the case, rewrapping the last line is necessary.
  // This could be done within the wrapping algorithm, but it'd require keeping
  // track of a whole lot of extra data and just bungle up the code structure in general.
  // Note that it shouldn't be rewrapped if it's wider than the normal line width,
  // since that means it's a word that couldn't be wrapped, and rewrapping it
  // would thus wrap the "word too wide" disclaimer too.
  var lastLineWidth = lines[lines.length - 1][1];
  if (prompts && lines.length % promptPageLines !== 0 && lines.length > promptPageLines &&
      lastLineWidth > width - 8 && lastLineWidth <= width) {
    var lastLine = lines.pop();
    var lastLineStartingFont = lastLine[0];
    var lastLineText = lastLine[2];
    lines.push.apply(lines, _wrap(lastLineText, width, 1, lastLineStartingFont));
  }
  
  return lines.map(function(line) {return line[2];}).join('\n');
}

function _wrap(text, width, promptPageLines, font) {
  var prompts = typeof promptPageLines !== 'undefined';
  // To support changing fonts in the middle of text,
  // control code support will have to be added.
  // Perhaps an object-oriented restructuring could help
  // with that (so control code functions can do things
  // like set font state and add to the word width)?
  var fontName = typeof font !== 'undefined' ? font : "normal";
  font = FONTS[fontName];
  
  var lines = [];
  
  // "Word" here being an unbreakable unit.
  // For example, "big-time" is two words: "big-" and "time".
  var curLineNum = 0;
  var curLineMaxWidth = promptPageLines === 1 ? width - 8 : width;
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
      else if (BREAK_CHARS[char]) {
        if (prevCharType === CharType.WORD || prevCharType === CharType.BREAK_CHAR) {curCharType = CharType.BREAK_CHAR}
        else {curCharType = CharType.LEADING_BREAK_CHAR}
      }
      else if (char === '\n') {curCharType = CharType.NEWLINE; charWidth = 0;}
      else {curCharType = CharType.WORD;}
    }
    
    // Transitions that trigger a word end.
    if ((prevCharType === CharType.WORD               && curCharType === CharType.WHITESPACE) ||
        (prevCharType === CharType.LEADING_BREAK_CHAR && curCharType === CharType.WHITESPACE) ||
        (prevCharType === CharType.BREAK_CHAR         && curCharType !== CharType.BREAK_CHAR) ||
        (prevCharType !== CharType.WHITESPACE         && curCharType === CharType.NEWLINE) ||
        (prevCharType !== CharType.WHITESPACE         && curCharType === CharType.EOF))
    {
      lastWordEnd = i;
      // -1 to strip off the last post-letter 1px space.
      prevWordWidth = curWordWidth - 1;
    }
    // Transitions that trigger a word start.
    if ((
           (prevCharType === CharType.WHITESPACE || prevCharType === CharType.NEWLINE) &&
           // Add BREAK_CHAR here if they're ever made to be able to come at the start of a word.
           (curCharType === CharType.WORD || curCharType === CharType.LEADING_BREAK_CHAR)
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
    if ((curLineWidth > curLineMaxWidth && lastWordStart >= lastWordEnd && lastWordStart !== curLineStart) ||
        (curCharType === CharType.NEWLINE) ||
        (curCharType === CharType.EOF))
    {
      // The line width value stored here is incorrect for any line not ending in a newline or
      // an EOF, but since wrap() only checks it for the last line (which is guaranteed to end
      // in an EOF), it's totes fine.
      lines.push([fontName, curLineWidth === 0 ? 0 : curLineWidth - 1, text.slice(curLineStart, lastWordEnd)]);
      if (prevWordWidth > curLineMaxWidth) {lines[lines.length - 1][2] += " // Word too wide";}
      curLineNum++;
      // End-of-line prompts only appear on the last line of a page, and are 8 pixels wide.
      curLineMaxWidth = prompts && (curLineNum + 1) % promptPageLines === 0 ? width - 8 : width;
      
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
  return lines;
}
