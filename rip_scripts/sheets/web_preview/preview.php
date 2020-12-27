<?php

// Error handling for if a file is missing or there is an invalid replace code (or a control code I am disinclined to support).

function error_image($syntaxerror=false) {
	header('Content-Type: image/png');
	if($syntaxerror) {
		echo hex2bin(
			'89504E470D0A1A0A0000000D4948445200000038000000280103000000919EAB'.
			'C60000000373424954080808DBE14FE000000006504C5445FFFFFFFF0000EB5A'.
			'E793000000097048597300000AF000000AF00142AC3498000000257445587453'.
			'6F667477617265004D6163726F6D656469612046697265776F726B73204D5820'.
			'323030348776ACCF0000007F49444154789C63F80F010CB8E80F3CFCCC1F3ED8'.
			'C3E9CF7F3EDB9C373E8F93FE60C3CF7CDEC01E4E1354CFF3D9E6C367048D6EFF'.
			'C7ECB447F640FAB776D4B7FB20DA1B4A673B4169283F17427FCCBBA5648FC51F'.
			'3F775D9CBD1F487FDB159D0DA2BFEF9A9D5B0F12BF769B0F24FFEFDD6D30FFDB'.
			'BBDB60F99F509A40F80000B5FFDC8F80369C1E0000000049454E44AE426082'
		);
	} else {
		echo hex2bin(
			'89504E470D0A1A0A0000000D49484452000000380000002808030000009C8EC9'.
			'B700000006504C5445FF0000FFFFFF411D3411000000904944415478DAE59101'.
			'0AC420100367FEFFE98372B239AA5A102887014A940D66A79C22BF6A0ED2C1FD'.
			'6E3FF8EB74EEFE327869EC0012DD46F038AAE3A1C2B41B7C4F2A44D7CB805847'.
			'EF0DDB50B9FE8745906EC669D56C59551BD8E98B800F5FDCDF31A966E9A4FABE'.
			'A410C61FAFA623696E4459DB6920731A4C62B8AC4A01AD8BC7419048ADAAF646'.
			'D7C1355539531F1EB302027BFB74D20000000049454E44AE426082'
		);
	}
	exit();
}

// Check that the resource directory exists.

$resourcedir=dirname(__FILE__).'/res';
if(!file_exists($resourcedir)) {
	error_image();
}

// Load charmap.

if(file_exists($resourcedir.'/charmap.txt')) {
	$charmap=file_get_contents($resourcedir.'/charmap.txt');
} else {
	error_image();
}
$charmap=explode('&',$charmap);

// Clean up linebreaks.

$text='';
if(isset($_REQUEST['text'])) {
	$text=$_REQUEST['text'];
}
$text=str_replace(array("\r\n","\r"),"\n",$text);
$text=str_replace("\n",'<0xE2>',$text);

// Replace all mapped non-ascii characters.

$i=0;
$c=count($charmap);
while($i<$c) {
	$charmapline=explode('=',$charmap[$i],2);
	$text=str_replace(rawurldecode($charmapline[0]),rawurldecode($charmapline[1]),$text);
	$i++;
}

// Replace double angled brackets with single ones.

$text=str_replace(chr(0xC2).chr(0xAB),'<',$text);
$text=str_replace(chr(0xC2).chr(0xBB),'>',$text);

// Replace ascii control characters and tabs with ?.

$linetext=preg_replace('/[\x00-\x1F\x7F]/','?',$text);

// Basic specials.

/*
0=1 byte argument (decimal by default)
1=1 byte argument
2=2 byte argument
3=2 byte argument with keywords
*/

$specials=array(
	'&' => array('<0xE5>',3),
	'S' => array('<0xE3>',1),
	'*' => array('<0xE1>',1),
	'O' => array('<0xEC>',2),
	'D' => array('<0xE9>',0),
	'P' => array('<0xED>',0)
);

$matches=array();
foreach($specials as $specialkey => $specialinfo) {
	list($prefix,$type)=$specialinfo;
	while(preg_match('/\<'.preg_quote($specialkey,'/').'([0-9A-Za-z]+)\>/',$text,$matches)) {
		$argvalue=strtolower($matches[1]);
		$hexforce=false;
		if(substr($argvalue,0,2)=='0x') {
			$hexforce=true;
			$argvalue=substr($argvalue,2);
		}
		$isword=false;
		$usekeywords=false;
		$hexdefault=false;
		switch($type) {
			case 3:
				$isword=true;
				$usekeywords=true;
				$hexdefault=true;
				break;
			case 2:
				$isword=true;
				$hexdefault=true;
				break;
			case 1:
				$hexdefault=true;
				break;
		}
		$val=0;
		if($usekeywords&&!$hexforce&&$argvalue=='name') {
			$val=0xc92c;
		} else if($usekeywords&&!$hexforce&&$argvalue=='num') {
			$val=0xd448;
		} else {
			$argvalueold=$argvalue;
			if($hexdefault||$hexforce) {
				$argvalue=preg_replace('/[^0-9a-f]/','',$argvalue);
				if($argvalueold!=$argvalue) {
					error_image(true);
				}
				$val=hexdec($argvalue);
			} else {
				$argvalue=preg_replace('/[^0-9]/','',$argvalue);
				if($argvalueold!=$argvalue) {
					error_image(true);
				}
				$val=intval($argvalue);
			}
			if($isword) {
				if($val>0x10000) {
					error_image(true);
				}
			} else {
				if($val>0x100) {
					error_image(true);
				}
			}
		}
		$replace=$prefix;
		if($isword) {
			$lowerbyte=$val%0x100;
			$replace.='<0x'.str_pad(strtoupper(dechex($lowerbyte)),2,'0',STR_PAD_LEFT).'>';
			$upperbyte=round(($val-$lowerbyte)/0x100)%0x100;
			$replace.='<0x'.str_pad(strtoupper(dechex($upperbyte)),2,'0',STR_PAD_LEFT).'>';
		} else {
			$replace.='<0x'.str_pad(strtoupper(dechex($val)),2,'0',STR_PAD_LEFT).'>';
		}
		$text=str_replace($matches[0],$replace,$text);
	}
}

// Font replace codes.

$text=str_ireplace('<bold>','<0xF2>',$text);
$text=str_ireplace('<normal>','<0xF3>',$text);

// Convert any remaining UTF8 characters to ?.

$text=mb_convert_encoding($text,'ASCII','UTF8');
	
// Make damn sure there are no stragglers in the $80 to $FF range.

$text=preg_replace('/[\x80-\xFF]/','?',$text);

// Convert character code replace codes to binary.
// We will start with a simple str_replace pass to get the most common cases.

$i=0;
while($i<256) {
	$chr=chr($i);
	$text=str_replace('<'.$i.'>',$chr,$text);
	$text=str_replace('<'.str_pad($i,3,'0',STR_PAD_LEFT).'>',$chr,$text);
	$hex=strtoupper(dechex($i));
	$text=str_ireplace('<0x'.$hex.'>',$chr,$text);
	$text=str_ireplace('<0x'.str_pad($hex,2,'0',STR_PAD_LEFT).'>',$chr,$text);
	$i++;
}

// And now regex for the rest.

while(preg_match('/\<([0-9]+)\>/',$text,$matches)) {
	$val=intval($matches[1],10)%0x100;
	$text=str_replace($matches[0],chr($val),$text);
}
while(preg_match('/\<0[xX]([0-9A-Fa-f]+)\>/',$text,$matches)) {
	$val=hexdec($matches[1])%0x100;
	$text=str_replace($matches[0],chr($val),$text);
}

// Everything except questions should now be rendered as binary.
// We are doing this before processing control codes so that we can parse stuff like "<0xE9>6" as the game would parse it (<D54>).
// Not that such scenarios are likely, but it never hurts to be thorough.

// Load character width tables.

$charwidthtable=array();
$fonts=array();
$fontstoload=array();

$numberoffonts=4;
$i=0;
while($i<$numberoffonts) {
	$fonts[$i]=false;
	$fontstoload[$i]=false;
	if(file_exists($resourcedir.'/'.$i.'.txt')) {
		$charwidthtable[$i]=explode(',',file_get_contents($resourcedir.'/'.$i.'.txt'));
		foreach($charwidthtable[$i] as $k => $v) {
			$charwidthtable[$i][$k]=intval($v,10);
		}
	} else {
		error_image();
	}
	$i++;
}

// Set initial font.

$initialfont=0;
$fontqsv='';
if(isset($_REQUEST['font'])) {
	$fontqsv=trim(strtolower($_REQUEST['font']));
}
if(!empty($fontqsv)) {
	if($fontqsv=='bold') {
		$initialfont=2;
	} else if($fontqsv=='narrow') {
		$initialfont=1;
	} else if($fontqsv=='entry') {
		$initialfont=3;
	} else {
		$initialfont=intval($fontqsv,10);
		if($initialfont<0||$initialfont>3) {
			$initialfont=0;
		}
	}
}
$currentfont=$initialfont;
$fontstoload[$currentfont]=true;

// Get minimum lines.

$minlines=0;
if(isset($_REQUEST['minimum-lines'])) {
	$minlines=trim($_REQUEST['minimum-lines'].'');
	$minlines=intval($minlines,10);
}
if($minlines<1) {
	$minlines=1;
}
$perprompt=0;
if(isset($_REQUEST['lines-per-prompt'])) {
	$perprompt=trim($_REQUEST['lines-per-prompt'].'');
	$perprompt=intval($perprompt,10);
}
if($perprompt>18) {
	$perprompt=18;
}
$perpage=0;
if(isset($_REQUEST['lines-per-page'])) {
	$perpage=trim($_REQUEST['lines-per-page'].'');
	$perpage=intval($perpage,10);
}
if($perpage>18) {
	$perpage=18;
}
if($perprompt>$minlines) {
	$minlines=$perprompt;
}
if($perpage>$minlines) {
	$minlines=$perpage;
}

$textlines=array();

$i=0;
while($i<$minlines) {
	$textlines[$i]='';
	$i++;
}

// Get width.

$textwidth=0;
if(isset($_REQUEST['width'])) {
	$textwidth=trim($_REQUEST['width'].'');
	$textwidth=intval($textwidth,10);
}
if($textwidth<=0) {
	$textwidth=128;
} else {
	$textwidthrem=$textwidth%8;
	if($textwidthrem>0) {
		$textwidth=$textwidth-$textwidthrem+8;
	}
}
if($textwidth>160) {
	$textwidth=160;
}
$textwidthintiles=round($textwidth/8);
$padding=0;
if(isset($_REQUEST['padding'])) {
	$padding=trim($_REQUEST['padding'].'');
	$padding=intval($padding,10);
}
if($padding<0) {
	$padding=0;
}
if($padding>128) {
	$padding=128;
}
$overallwidth=($padding*2)+$textwidth;

// Parse text into lines and remove/render certain control codes.

$currentline=0;
$currentlinelength=0;
$verticalselectionmode=false;
$arrowmode=false;
$secondarrowpos=0;
$secondarrowset=false;
$relativeoffsetset=false;
$relativeoffset=0;
$relativeoffsetline=0;
$vwfon=true;

$i=0;
$c=strlen($text);

$shorttextmemorylocations=array(0xCCC3,0xCCC5,0xCCC7,0xCCC9,0xCCCB,0xCCCD,0xCCCF,0xCCD1,0xCCD9);

while($i<$c) {
	$chr=$text[$i];
	$ord=ord($chr);
	if($ord>=0xE0) {
		
		// Fetch potential arguments and bounds-check them.
		
		$argaoob=false;
		$argboob=false;
		if($i+1<$c) {
			$arga=ord($text[$i+1]);
			if($i+2<$c) {
				$argb=ord($text[$i+2]);
			} else {
				$argb=0;
				$argboob=true;
			}
		} else {
			$arga=0;
			$argb=0;
			$argaoob=true;
			$argboob=true;
		}
		$argword=$arga+($argb*0x100);
		
		// Parse control code.
		
		switch($ord) {
			case 0xE0:
				// This should only be used in substrings, it would cause unpredictable results if called at this level.
				error_image(true);
				break;
			case 0xE1:
				// Disregard all text after this replace code.
				if($argaoob) {
					error_image(true);
				} else if($arga>0x0A) {
					error_image(true);
				} else {
					$i=$c;
					if($arga==0x0A) {
						$arrowmode=true;
					}
				}
				break;
			case 0xE2:
				// Linebreak.
				$currentline++;
				$textlines[$currentline]='';
				$currentlinelength=0;
				$i++;
				break;
			case 0xE3:
				// Changing speed is irrelevant to the previewing of text.
				if($argaoob) {
					error_image(true);
				} else {
					$i+=2;
				}
				break;
			case 0xF1:
			case 0xE4:
				// Conditional linebreak.
				$islinebreak=false;
				if($currentlinelength>=8) {
					$islinebreak=true;
				} else if($perprompt>0) {
					if($currentline%$perprompt>0) {
						$islinebreak=true;
					}
				} else if($perpage>0) {
					if($currentline%$perpage>0) {
						$islinebreak=true;
					}
				} else {
					if($currentline>0) {
						$islinebreak=true;
					}
				}
				if($islinebreak) {
					$currentline++;
					$textlines[$currentline]='';
					$currentlinelength=0;
				}
				if($ord==0xF1) {
					$verticalselectionmode=true;
				}
				$i++;
				break;
			case 0xE5:
				// This is not something that should ever be in the spreadsheet. Throw an error.
				error_image(true);
				break;
			case 0xE7:
				// This control code is unused and undocumented. Throw an error.
				error_image(true);
				break;
			case 0xE9:
				// This control code does nothing. Probably used for debugging. Discard.
				$i+=2;
				break;
			case 0xEA:
				// Disable vwf.
				$vwfon=false;
				$textlines[$currentline].=$chr;
				$i++;
				break;
			case 0xEB:
				// Enable vwf.
				$vwfon=true;
				$textlines[$currentline].=$chr;
				$i++;
				break;
			case 0xEC:
				// Subtext. We will insert note characters for most addresses to a given length, because they are the longest character in every font.
				if($argaoob) {
					error_image(true);
				} else if($argboob) {
					error_image(true);
				} else {
					$note=chr(0x0D);
					if($vwfon) {
						$notelength=$charwidthtable[$currentfont][0x0D]+1;
					} else {
						$notelength=8;
					}
					if($argword==0xD448) {
						$textlines[$currentline].='9999';
						if($vwfon) {
							$currentlinelength+=($charwidthtable[$currentfont][0x39]+1)*4;
						} else {
							$currentlinelength+=8*4;
						}
					} else if($argword==0xCCC1) {
						$textlines[$currentline].=$note.$note;
						$currentlinelength+=$notelength*2;
					} else if(in_array($argword,$shorttextmemorylocations)) {
						$textlines[$currentline].=$note;
						$currentlinelength+=$notelength;
					} else {
						$textlines[$currentline].=$note.$note.$note.$note.$note.$note.$note.$note;
						$currentlinelength+=$notelength*8;
					}
					$i+=3;
				}
				break;
			case 0xED:
				// Conditional offset related.
				if(!$relativeoffsetset) {
					error_image(true);
				} else if($relativeoffsetline!=$currentline) {
					error_image(true);
				} else if($argaoob) {
					error_image(true);
				} else {
					// I need to check that $arga+$relativeoffset doesn't exceed the alotted width.
					$newpos=($relativeoffset+$arga)*8;
					if($newpos>$textwidth) {
						error_image(true);
					} else {
						$currentlinelength=$newpos;
						$textlines[$currentline].=$chr;
						$textlines[$currentline].=chr($arga);
						$i++;
					}
				}
				break;
			case 0xEE:
				// Set conditional offset related.
				$relativeoffsetset=true;
				$relativeoffsetline=$currentline;
				$relativeoffset=round(($currentlinelength-($currentlinelength%8))/8);
				$textlines[$currentline].=$chr;
				$i++;
				break;
			case 0xEF:
				// Reset conditional offset. I'll just throw an error since there is no practical use for it and it is difficult to support.
				error_image(true);
				break;
			case 0xF0:
				// To do with the space and second arrow for horizontally positioned answers.
				$textlines[$currentline].=$chr;
				$currentlinelength=(floor($currentlinelength/8)*8)+16;
				$i++;
				break;
			case 0xF2:
				// Switch font to bold.
				$currentfont=2;
				$fontstoload[$currentfont]=true;
				$textlines[$currentline].=$chr;
				$i++;
				break;
			case 0xF3:
			case 0xF4:
				// Switch font to normal.
				$currentfont=0;
				$fontstoload[$currentfont]=true;
				$textlines[$currentline].=chr(0xF3);
				$i++;
				break;
			case 0xF5:
				// Switch font to entry.
				$currentfont=3;
				$fontstoload[$currentfont]=true;
				$textlines[$currentline].=$chr;
				$i++;
				break;
			default:
				// Remove all the placeholder control codes.
				$i++;
		}
	} else {
		// Process questions.
		$questionfound=false;
		if($chr=='<') {
			if($i+2<$c) {
				if($chr.$text[$i+1].$text[$i+2]=='<Q>') {
					$pos=strpos($text,'</Q>',$i+3);
					if(is_bool($pos)) {
						error_image(true);
					}
					$answers=substr($text,$i+3,$pos-($i+3));
					$answers=explode('<|>',$answers);
					if(count($answers)!=2) {
						error_image(true);
					}
					$answerlengths=array(0,0);
					$u=0;
					while($u<2) {
						$o=0;
						$answernumchars=strlen($answers[$u]);
						while($o<$answernumchars) {
							$answerchr=$answers[$u][$o];
							$answerord=ord($answerchr);
							if($answerord>=0xE0) {
								// Allowing control codes in questions would make this more complicated than it needs to be. Throw an error.
								error_image(true);
							} else {
								$answerlengths[$u]+=$charwidthtable[$currentfont][$answerord]+1;
							}
							$o++;
						}
						$u++;
					}
					$horizontalwidth=((floor($answerlengths[0]/8)*8)+$answerlengths[1]+24);
					if($horizontalwidth>$textwidth) {
						$islinebreak=false;
						if($currentlinelength>=8) {
							$islinebreak=true;
						} else if($perprompt>0) {
							if($currentline%$perprompt>0) {
								$islinebreak=true;
							}
						} else {
							if($currentline>0) {
								$islinebreak=true;
							}
						}
						if($islinebreak) {
							$currentline++;
							$textlines[$currentline]='';
							$currentlinelength=0;
						}
						$verticalselectionmode=true;
						$textlines[$currentline].=chr(0).$answers[0];
						
						$currentline++;
						$textlines[$currentline]=chr(0).$answers[1];
						$currentlinelength=$charwidthtable[$currentfont][0]+1+$answerlengths[1];
					} else {
						$textlines[$currentline].=chr(0).$answers[0].chr(0xF0).$answers[1];
						$currentlinelength+=$horizontalwidth;
						
					}
					$i=$pos+4;
					$questionfound=true;
				}
			}
		}
		// Process literal character.
		if(!$questionfound) {
			if($ord>=0xB8) {
				if($currentfont>1) {
					if(!$fontstoload[1]) {
						$fontstoload[1]=true;
					}
				}
			}
			$textlines[$currentline].=$chr;
			if($vwfon) {
				$currentlinelength+=$charwidthtable[$currentfont][$ord]+1;
			} else {
				$currentlinelength+=8;
			}
			$i++;
		}
	}
}

// Get height.

$spacing=0;
if(isset($_REQUEST['spacing'])) {
	$spacing=trim($_REQUEST['spacing'].'');
	$spacing=intval($spacing,10);
}
if($spacing<0) {
	$spacing=0;
}
if($spacing>16) {
	$spacing=16;
}

$lineheight=($spacing*8)+8;

$numlines=count($textlines);

$numpages=1;
if($perpage>0) {
	while($numlines%$perpage!=0) {
		$textlines[$numlines]='';
		$numlines++;
	}
	$numpages=round($numlines/$perpage);
	if($numpages<1) {
		$numpages=1;
	}
} else {
	$perpage=$numlines;
}

$pagespacing=8;

$pageheight=(($perpage-1)*$lineheight)+($padding*2)+8;

$overallheight=(($numpages-1)*$pagespacing)+($numpages*$pageheight);

// Note the vertical offset of each line.

$linepositions=array();
$i=0;
while($i<$numpages) {
	$u=0;
	while($u<$perpage) {
		$y=(($pageheight+$pagespacing)*$i)+$padding+($u*$lineheight);
		$linepositions[$u+($i*$perpage)]=$y;
		$u++;
	}
	$i++;
}

// Load required fonts into memory.

foreach($fontstoload as $fontnum => $fontstoloadtest) {
	if($fontstoloadtest) {
		if(file_exists($resourcedir.'/'.$fontnum.'.png')) {
			$fonts[$fontnum]=imagecreatefrompng($resourcedir.'/'.$fontnum.'.png');
		} else {
			error_image();
		}
	}
}

// Create canvas with white background.

$im=imagecreatetruecolor($overallwidth,$overallheight);
$white=imagecolorallocate($im,255,255,255);
imagefill($im,0,0,$white);

// Draw each page's background.

$yellow=imagecolorallocate($im,249,214,83);
$i=0;
while($i<$numpages) {
	$y=($pageheight+$pagespacing)*$i;
	imagefilledrectangle($im,0,$y,$overallwidth-1,$y+$pageheight-1,$yellow);
	$i++;
}

// Draw text.

$currentfont=$initialfont;
$relativeoffset=0;
$vwfon=true;

foreach($textlines as $currentline => $textline) {
	$y=$linepositions[$currentline];
	$c=strlen($textline);
	$i=0;
	$currentlinelength=0;
	while($i<$c) {
		if($currentlinelength<$textwidth) {
			$chr=$textline[$i];
			$ord=ord($chr);
			if($ord>=0xE0) {
				
				// Parse control code.
				
				switch($ord) {
					case 0xEA:
						$vwfon=false;
						break;
					case 0xEB:
						$vwfon=true;
						break;
					case 0xED:
						$i++;
						$arg=ord($textline[$i]);
						$currentlinelength=($relativeoffset+$arga)*8;
						break;
					case 0xEE:
						$relativeoffset=round(($currentlinelength-($currentlinelength%8))/8);
						break;
					case 0xF0:
						$currentlinelength=(floor($currentlinelength/8)*8)+16;
						$secondarrowpos=$currentlinelength-8;
						$secondarrowset=true;
						break;
					case 0xF2:
						$currentfont=2;
						break;
					case 0xF3:
						$currentfont=0;
						break;
					case 0xF5:
						$currentfont=3;
						break;
				}
			} else {
				// Get character width.
				
				if($vwfon) {
					$charwidth=$charwidthtable[$currentfont][$ord]+1;
				} else {
					$charwidth=8;
				}
				
				if($currentlinelength+$charwidth>$textwidth) {
					$charwidth=$textwidth-$currentlinelength;
				}
				
				// Calculate font character x and y positions divided by 8. 
				
				$charxindex=$ord%0x10;
				$charyindex=round(($ord-$charxindex)/0x10);
				
				// Draw font character to canvas image.
				
				$fontfordrawing=$currentfont;
				if($ord>=0xB8&&$fontfordrawing>1) {
					$fontfordrawing=1;
				}
				imagecopy($im,$fonts[$fontfordrawing],$currentlinelength+$padding,$y,$charxindex*8,$charyindex*8,$charwidth,8);
				
				$currentlinelength+=$charwidth;
			}
		}
		$i++;
	}
}

// Remove fonts from memory.

foreach($fontstoload as $fontnum => $fontstoloadtest) {
	if($fontstoloadtest) {
		imagedestroy($fonts[$fontnum]);
	}
}

// Draw prompts.

if(file_exists($resourcedir.'/prompt.gif')) {
	$promptim=imagecreatefromgif($resourcedir.'/prompt.gif');
} else {
	error_image();
}

if($perprompt>0) {
	// Next page prompts.
	$i=$perprompt-1;
	while($i<$numlines) {
		$y=$linepositions[$i];
		imagecopy($im,$promptim,$textwidth+$padding-8,$y,8,0,8,8);
		$i+=$perprompt;
	}
	// Last page prompt.
	$i=$numlines-1;
	$y=$linepositions[$i];
	imagecopy($im,$promptim,$textwidth+$padding-8,$y,0,0,8,8);
}

// Draw arrows.

if($arrowmode) {
	if($verticalselectionmode) {
		if($numlines<2) {
			error_image(true);
		} else {
			$i=$numlines-2;
			$y=$linepositions[$i];
			imagecopy($im,$promptim,$padding,$y,16,0,8,8);
			$y=$linepositions[$i+1];
			imagecopy($im,$promptim,$padding,$y,16,0,8,8);
		}
	} else if(!$secondarrowset) {
		error_image(true);
	} else {
		$i=$numlines-1;
		$y=$linepositions[$i];
		imagecopy($im,$promptim,$padding,$y,16,0,8,8);
		imagecopy($im,$promptim,$padding+$secondarrowpos,$y,16,0,8,8);
	}
}
imagedestroy($promptim);

// Image scaling.

$scaling=1;
if(isset($_REQUEST['scale'])) {
	$scaling=trim($_REQUEST['scale'].'');
	$scaling=intval($scaling,10);
}
if($scaling>4) {
	$scaling=4;
}
if($scaling>1) {
	$oldim=$im;
	$im=imagecreatetruecolor($overallwidth*$scaling,$overallheight*$scaling);
	imagecopyresized($im,$oldim,0,0,0,0,$overallwidth*$scaling,$overallheight*$scaling,$overallwidth,$overallheight);
	imagedestroy($oldim);
}

// Output final image.

header('Content-Type: image/png');
imagepng($im);
imagedestroy($im);
?>