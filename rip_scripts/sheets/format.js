 "use strict";

var CharType = {
  WORD:               0,
  // Break chars right before a word shouldn't be broken after.
  // For example, "...Hey!" shouldn't be split up into "..." and "Hey!".
  LEADING_BREAK_CHAR: 1,
  BREAK_CHAR:         2,
  WHITESPACE:         3,
  NEWLINE:            4,
  EOF:                5
};

var QuestionState = {
  NOT_IN_QUESTION:     0,
  ENTERING_QUESTION:   1,
  IN_QUESTION:         2
};

var FONTS = getFontMetrics();
var CHARS = getChars();
var CONTROL_CODES = {
  // This isn't particularly pretty, but refactoring this to be state-based would require
  // an object-oriented rewrite of the whole script, which would be a pain and a half.
  "<normal>": {font: "normal"},
  "<bold>": {font: "bold"},

  // Ditto!
  "<Q>": {questionStart: true},
  "\n<Q>": {questionStart: true},
  "<|>": {endFirstAnswer: true},
  "</Q>": {questionEnd: true},
  "</Q>\n": {questionEnd: true},

  // This "width" approach doesn't take the font into account, but since this is the widest
  // possible for 8 tiles anyway, it doesn't matter for <&name>. The general way to handle
  // this would be to get the widest character in every font and assign a separate width
  // for each font. This is good enough for this case, though!
  "<&name>": {charType: CharType.WORD, width: 8 * 8 - 1}
};
for (var code in CONTROL_CODES) {
  if (!CONTROL_CODES.hasOwnProperty(code)) {continue;}
  CHARS.push(code);
}
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

var SPECIAL_PRELUDES = {
  EXP_ITEM_DENJUU_NUMBER: function(text, params, sheet, row, column) {
    return '<D' + (row - 1) + '>';
  }
};

var SPECIAL_ENVOIS = {
  PHONE_LINE_TERMINATOR: function(text, params, sheet, row, column) {
    return _getNumInConvo(sheet, row) <= 3 ? '<*A>' : '<*2>';
  }
};

function prepareForPreview(text, params, sheet, row, column) {
  // Trim prelude.
  if (params.prelude) {
    var prelude;
    if (SPECIAL_PRELUDES.hasOwnProperty(params.prelude)) {
      prelude = SPECIAL_PRELUDES[params.prelude](text, params, sheet, row, column)
    } else {
      prelude = params.prelude;
    }
    
    if (text.slice(0, prelude.length) === prelude) {
      text = text.slice(prelude.length);
    }
  }

  // Trim envoi.
  if (params.envoi) {
    var envoi;
    if (SPECIAL_ENVOIS.hasOwnProperty(params.envoi)) {
      envoi = SPECIAL_ENVOIS[params.envoi](text, params, sheet, row, column)
    } else {
      envoi = params.envoi;
    }
    
    if (text.slice(text.length - envoi.length) === envoi) {
      text = text.slice(0, text.length - envoi.length);
    }
  }

  // Format question draft syntax.
  if (params.questions) {
    if (column === 4) { // Draft column
      var numInConvo = _getNumInConvo(sheet, row);
      // The first three lines in a conversation should contain questions.
      if (numInConvo <= 3) {
        // There are a couple of ways someone's formatted the draft questions,
        // so let's just handle all of those, hahah.
        var lines = text.split("\n");
        var lastLine = lines.pop();
        if (lastLine.substr(0, 3) === "<0>") {
          lines.push("<Q>" + lastLine.substr(3).split("<0>", 2).join("<|>") + "</Q>");
        } else if (lastLine.indexOf("/") !== -1) {
          lines.push("<Q>" + lastLine.split(/\s*\/\s*/, 2).join("<|>") + "</Q>");
        } else {
          lines.push(lastLine);
        }
        text = lines.join("\n");
      }
    }
  }

  return text;
}

function _getNumInConvo(sheet, row) {
  var numInConvo = 0;
  // 9 is the max distance a line can be from its number header row.
  for (y = row - 1; y >= row - 9; y--) {
    numInConvo++;
    var cells = sheet.getRange(y, 1, 1, 2);
    var contents = cells.getValues()[0];
    if (contents[0] === "#######" && contents[1][0] === "#") {break;}
  }
  return numInConvo;
}

function addPreludeAndEnvoi(text, params, sheet, row, column) {
  if (params.prelude) {
    if (SPECIAL_PRELUDES.hasOwnProperty(params.prelude)) {
      text = SPECIAL_PRELUDES[params.prelude](text, params, sheet, row, column) + text;
    } else {
      text = params.prelude + text;
    }
  }

  if (params.envoi) {
    if (SPECIAL_ENVOIS.hasOwnProperty(params.envoi)) {
      text += SPECIAL_ENVOIS[params.envoi](text, params, sheet, row, column);
    } else {
      text += params.envoi;
    }
  }
  
  return text;
}

function formatSelectedRows() {
  var sheet = SpreadsheetApp.getActiveSheet();
  var sheetName = sheet.getName();
  if (!SHEET_PARAMS.hasOwnProperty(sheetName)) {throw "This sheet isn't supported at the moment.";}
  var params = SHEET_PARAMS[sheetName];
  var hasFormattedCol = sheet.getRange(1, 5).getValue() === "Formatted?";
  
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
    draftText = prepareForPreview(draftText, params, sheet, row, 4);
    
    var formatted = wrap(draftText, params.width, params.lines_per_prompt, params.font);
    formatted = addPreludeAndEnvoi(formatted, params, sheet, row, 4);
    formatted = formatted[0] === "'" ? "'" + formatted : formatted; // A leading single quote needs to be escaped.
    
    sheet.getRange(row, 3).setValue(formatted);
    if (hasFormattedCol) {sheet.getRange(row, 5).setValue("1");}
  }
}

function wrap(text, width, promptPageLines, font) {
  var lines = _wrap(text, width, promptPageLines, font);
  
  // The last line in dialogue always has a prompt on it.
  // The last line returned by _wrap may exceed the "with prompt" width,
  // so if that's the case, rewrapping the last line is necessary.
  _rewrap_last_line(lines, width, promptPageLines);
  
  return lines.map(function(line) {return line[2];}).join('\n');
}

function _rewrap_last_line(lines, width, promptPageLines) {
  var prompts = typeof promptPageLines !== 'undefined';

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
}

function _push_question_lines(lines, text, width, promptPageLines, i, curLineStart, curLineWidth, curLineStartFont, curFirstAnswer) {
  curFirstAnswer = curFirstAnswer || [curLineStartFont, 0, ""];
  var curSecondAnswer = [curLineStartFont, curLineWidth === 0 ? 0 : curLineWidth - 1, text.slice(curLineStart, i)];
  // Horizontally oriented answers can be max 7 tiles wide.
  if (Math.max(curFirstAnswer[1], curSecondAnswer[1]) <= 7 * 8) {
    // Horizontally oriented answers.
    // The line width of this shouldn't matter for anything as long as it's set to 0.
    lines.push([curFirstAnswer[0], 0, "<Q>" + curFirstAnswer[2] + "<|>" + curSecondAnswer[2] + "</Q>"]);
    return 1; // 1 line added.
  } else {
    // Vertically oriented answers.
    // Takes up an entire text box and makes any line end in a continuation symbol, necessitating a rewrap.
    _rewrap_last_line(lines, width, promptPageLines);
    var s = "<Q>\n";
    s += curFirstAnswer[2];
    if (curFirstAnswer[1] > 15 * 8) {s += " // Answer too wide";}
    s += "\n<|>\n";
    s += curSecondAnswer[2];
    if (curSecondAnswer[1] > 15 * 8) {s += " // Answer too wide";}
    s += "\n</Q>";
    lines.push([curFirstAnswer[0], 0, s]);
    return 2; // 2 lines added.
  }
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
  var curLineStartFont = fontName;
  var curWordWidth = 0;
  var prevWordWidth = 0;
  var lastWordStart = 0;
  var lastWordEnd = 0;
  var prevCharType = CharType.LEADING_BREAK_CHAR;
  var curCharType = CharType.LEADING_BREAK_CHAR;
  var questionState = QuestionState.NOT_IN_QUESTION;
  var curFirstAnswer = null;
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
      
      if (typeof CONTROL_CODES[char] !== 'undefined') {
        var codeEffects = CONTROL_CODES[char];
        fontName = codeEffects.font || fontName;
        font = FONTS[fontName];

        if (codeEffects.questionStart && questionState === QuestionState.NOT_IN_QUESTION) {
          questionState = QuestionState.ENTERING_QUESTION;
          codeEffects = {charType: CharType.NEWLINE, width: 0};
        } else if (codeEffects.endFirstAnswer && curFirstAnswer === null) {
          curFirstAnswer = [fontName, curLineWidth === 0 ? 0 : curLineWidth - 1, text.slice(curLineStart, i)];

          lastWordStart = i + charLength;
          curLineStart = lastWordStart;
          curLineWidth = 0;
          curLineStartFont = fontName;
        } else if (codeEffects.questionEnd && questionState === QuestionState.IN_QUESTION) {
          curLineNum += _push_question_lines(lines, text, width, promptPageLines, i, curLineStart, curLineWidth, curLineStartFont, curFirstAnswer);
          questionState = QuestionState.NOT_IN_QUESTION;
          curFirstAnswer = null;

          lastWordStart = i + charLength;
          curLineStart = lastWordStart;
          curLineWidth = 0;
          curLineStartFont = fontName;

          // So that an EOF after a question doesn't get processed as an extra empty line.
          if (curLineStart === text.length) {break;}
        }

        if (typeof codeEffects.charType === 'undefined' || typeof codeEffects.width === 'undefined') {
          // If control codes take on the CharType of the character before (unless it's whitespace),
          // they should be wrapped more or less satisfactorily, and still allow things like "leading break char"
          // to pass through even if a control code is placed in the middle of a run of leading break chars.
          // It'd be even nicer if control codes took on the CharType of the *next* character, since for example
          // "blah-<bold>blah" would wrap to "blah-\n<bold>blah" instead of "blah-<bold>\nblah", but the current
          // code structure doesn't very well allow peeking the next character. That's a rare edge case anyway!
          if (prevCharType === CharType.WORD || prevCharType === CharType.BREAK_CHAR) {curCharType = prevCharType;}
          else {curCharType = CharType.LEADING_BREAK_CHAR;}
          charWidth = 0;
        } else {
          curCharType = codeEffects.charType;
          charWidth = codeEffects.width;
          curLineWidth += charWidth;
        }
      } else {
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
    if (charWidth !== 0) {
      curWordWidth += charWidth + 1;
    }
    
    // Add a line if:
    // * a word that needs to be put on the next line has been started,
    // * a newline character has been encountered, or
    // * we've reached the end of the text.
    if ((questionState === QuestionState.NOT_IN_QUESTION || questionState === QuestionState.ENTERING_QUESTION) &&
        ((curLineWidth > curLineMaxWidth && lastWordStart >= lastWordEnd && lastWordStart !== curLineStart) ||
         (curCharType === CharType.NEWLINE) ||
         (curCharType === CharType.EOF)))
    {
      // The line width value stored here is incorrect for any line not ending in a newline or
      // an EOF, but since wrap() only checks it for the last line (which is guaranteed to end
      // in an EOF), it's totes fine.
      lines.push([curLineStartFont, curLineWidth === 0 ? 0 : curLineWidth - 1, text.slice(curLineStart, lastWordEnd)]);
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
      curLineStartFont = fontName;
    } else {
      // Post-letter 1px space.
      curLineWidth += 1;
    }

    if (questionState === QuestionState.ENTERING_QUESTION) {questionState = QuestionState.IN_QUESTION;}

    i += charLength;
  }

  if (questionState === QuestionState.IN_QUESTION) {
    curLineNum += _push_question_lines(lines, text, width, promptPageLines, i, curLineStart, curLineWidth, curLineStartFont, curFirstAnswer);
  }

  return lines;
}

// Leavin' this here for convenience.
// function testWrap() {
//   Logger.log(wrap(
//     "This should be... yeah, liiiiiine 1 BUT this HERE should BE 2, while <bold>this line<normal> is # three; <bold>this one<normal> is soooo four! Special chars are bound-aries, so this line's 6. Toolongwordgetsanerroryo!!!!!\n<Q>Hori\nzontal<|>Fit, baby!</Q>",
//     16 * 8,
//     2,
//     'normal'
//   ));
//   Logger.log(wrap(
//     "One line,\ntwo line.\nThis line should be broken up.\n<Q>Answers <Q> long<|>Gotta be ver<|>tical   </Q>",
//     16 * 8,
//     2,
//     'normal'
//   ));
// }
