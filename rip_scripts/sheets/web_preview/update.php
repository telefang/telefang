<?php
// Create a directory for storing fonts.

$resourcedir=dirname(__FILE__).'/res';
if(!file_exists($resourcedir)) {
	mkdir($resourcedir);
}

// Ensure that this directory is not accessible via http for security.

if(!file_exists($resourcedir.'/.htaccess')) {
	file_put_contents($resourcedir.'/.htaccess','Deny from all');
}

// Update character lengths.

$dayinseconds=24*3600;

$numberoffonts=4;

$fontlengthurls=array(
	'https://raw.githubusercontent.com/telefang/telefang/patch/components/mainscript/font.tffont.csv',
	'https://raw.githubusercontent.com/telefang/telefang/patch/components/mainscript/font_narrow.tffont.csv',
	'https://raw.githubusercontent.com/telefang/telefang/patch/components/mainscript/font_bold.tffont.csv',
	''
);

$i=0;
while($i<$numberoffonts) {
	
	$destinationfontpath=$resourcedir.'/'.$i.'.txt';
	
	if(empty($fontlengthurls[$i])) {
		
		// The entry font doesn't need to be updated because the character length is hardcoded to 5 for all characters, so we will just create it if it doesn't exist.
		
		if(!file_exists($destinationfontpath)) {
			$u=0;
			$charlengths=array();
			while($u<256) {
				$charlengths[$u]=5;
				$u++;
			}
			file_put_contents($destinationfontpath,implode(',',$charlengths));
		}
		
	} else {
		
		// Clear old character length file.
		
		if(file_exists($destinationfontpath)) {
			unlink($destinationfontpath);
		}
		
		// Load new character length file.
		
		$csv=file_get_contents($fontlengthurls[$i]);
		
		// Convert it to a more parsable format. The way I do this makes assumptions about the format.
		
		$charlengths=array();
		$csv=trim($csv.'');
		$csv=str_replace('$00','0',$csv);
		$csv=str_replace('$0','',$csv);
		$csv=str_replace('$','',$csv);
		$csv=str_replace(array("\r\n","\r"),"\n",$csv);
		$csv=explode("\n",$csv);
		$y=1;
		while($y<17) {
			$line=explode(',',$csv[$y]);
			$x=1;
			while($x<17) {
				$length=trim($line[$x].'');
				$length=intval($length,10);
				$charlengths[]=$length;
				$x++;
			}
			$y++;
		}
		file_put_contents($destinationfontpath,implode(',',$charlengths));
	}
	$i++;
}

// Update fonts.

$fonturls=array(
	'https://raw.githubusercontent.com/telefang/telefang/patch/gfx/font.png',
	'https://raw.githubusercontent.com/telefang/telefang/patch/gfx/narrow_font.png',
	'https://raw.githubusercontent.com/telefang/telefang/patch/gfx/bold_font.png',
	'https://raw.githubusercontent.com/telefang/telefang/patch/gfx/entry_font.png'
);

$i=0;
while($i<$numberoffonts) {
	
	// Clear old font file.
	
	$destinationfontpath=$resourcedir.'/'.$i.'.png';
	if(file_exists($destinationfontpath)) {
		unlink($destinationfontpath);
	}
	
	// Load new font file.
	
	$im=imagecreatefrompng($fonturls[$i]);
	
	// Change background to yellow.
	
	$yellow=imagecolorallocate($im,249,214,83);
	$width=imagesx($im);
	$height=imagesy($im);
	imagealphablending($im,false);
	$x=0;
	while($x<$width) {
		$y=0;
		while($y<$height) {
			$rgb = imagecolorat($im,$x,$y);
			$r = ($rgb >> 16) & 0xFF;
			$g = ($rgb >> 8) & 0xFF;
			$b = $rgb & 0xFF;
			if($r==255&&$g==255&&$b==255) {
				imagesetpixel($im,$x,$y,$yellow);
			}
			$y++;
		}
		$x++;
	}
	imagealphablending($im,true);
	
	// Save modified font.
	
	imagepng($im,$destinationfontpath);
	imagedestroy($im);
	$i++;
}

// Process charmap.

$charmap=file_get_contents('https://raw.githubusercontent.com/telefang/telefang/patch/charmap.asm');
$charmap=str_replace(array("\r\n","\r"),"\n",$charmap);
$charmap=explode("\n",$charmap);
$mappingsbystring=array();
foreach($charmap as $charmapline) {
	$charmapline=trim($charmapline.'');
	if(strtolower(substr($charmapline,0,7))=='charmap') {
		$pos=strpos($charmapline,'"');
		if(!is_bool($pos)) {
			$charmapline=substr($charmapline,$pos+1);
			$pos=strrpos($charmapline,'"');
			if(!is_bool($pos)) {
				$string=substr($charmapline,0,$pos);
				$charmapline=substr($charmapline,$pos+1);
				$pos=strrpos($charmapline,'$');
				if(!is_bool($pos)) {
					$hex=trim(strtoupper(substr($charmapline,$pos+1)));
					$hex=substr(preg_replace('/[^0-9A-F]/','',$hex),0,2);
					
					$dec=hexdec($hex);
					$comp=chr($dec);
					
					// If the character is within the ascii range and is representative of its ascii counterpart then it should be noted for exclusion.
					
					$toexclude=($comp!=$string||$dec<32||$dec>126?false:true);
					
					// Prepare conversion information for our more machine-readable charmap format. An empty string signifies exclusion.
					
					if($toexclude) {
						$mapping='';
					} else {
						$hex=str_pad($hex,2,'0',STR_PAD_LEFT);
						$mapping=rawurlencode($string).'='.rawurlencode('<0x'.$hex.'>');
					}
					
					// Only the last conversion of a given string should be regarded.
					
					$mappingsbystring[$string]=$mapping;
				}
			}
		}
	}
}

// Strip out excluded conversions and save new charmap file.

$mappings=array();

foreach($mappingsbystring as $mapping) {
	if(!empty($mapping)) {
		$mappings[]=$mapping;
	}
}
unset($mappingsbystring);

$destinationcharmappath=$resourcedir.'/charmap.txt';

if(file_exists($destinationcharmappath)) {
	unlink($destinationcharmappath);
}

file_put_contents($destinationcharmappath,implode('&',$mappings));

// Store prompt gfx only if it doesn't exist.

$destinationpromptpath=$resourcedir.'/prompt.gif';
if(!file_exists($destinationpromptpath)) {
	$promptbin=hex2bin('47494638396118000800800000000000F9D65321F904041400FF002C000000001800080000021E8C8FA9CB080DDD5BA04E8B8355D3DCAC6DCEE85587487A69C86168D22105003B');
	file_put_contents($destinationpromptpath,$promptbin);
}

echo 'Done.';
?>