<?php
// This is meant to be the path to the file containing the bank we are dumping from. Just the bank mind you. Nothing else.
// This script fully expects that the first byte of this file to be the first byte of the event script pointer table.

define('EVENTDUMP_DATA_FILE','./power54.bin');

// The length of the pointer table in bytes. Yes, this is set manually instead of being autocalculated.

define('EVENTDUMP_POINTER_TABLE_LENGTH',656);

// The length of all the event script data, including the pointer table.

define('EVENTDUMP_DATA_LENGTH',16109);

// You don't need to configure anything below here.

ini_set('display_errors',1);

$scriptsblob=file_get_contents(EVENTDUMP_DATA_FILE);
$i=0;
$addresspool=array();
while($i<EVENTDUMP_POINTER_TABLE_LENGTH) {
	$lower=ord($scriptsblob[$i]);
	$i++;
	$upper=ord($scriptsblob[$i]);
	$i++;
	$address=($upper*256)+$lower;
	if($address>16383) {
		$address-=16384;
		if($address<16384) {
			if(!in_array($address,$addresspool)) {
				$addresspool[]=$address;
			}
		}
	}
}
$addressmatches=array();
$jumpmatches=array();
$labelpoints=array();
sort($addresspool,SORT_NUMERIC);
$i=0;
$c=count($addresspool);
while($i<$c) {
	$beginaddress=$addresspool[$i];
	if(isset($addresspool[$i+1])) {
		$oobaddress=$addresspool[$i+1];
	} else {
		$oobaddress=EVENTDUMP_DATA_LENGTH;
	}
	parse_actions($addressmatches,$jumpmatches,$labelpoints,$scriptsblob,$beginaddress,$oobaddress);
	$i++;
}
$nl='
';
$i=EVENTDUMP_POINTER_TABLE_LENGTH;
$c=EVENTDUMP_DATA_LENGTH;
while($i<$c) {
	if(empty($addressmatches[$i])) {
		$addressmatches[$i]='    db '.format_byte($scriptsblob[$i]).$nl;
	}
	$i++;
}
$labelused=array();
foreach($addresspool as $addressindex => $address) {
	$jumplabel=get_address_pool_label($addressindex);
	$addressmatches[$address]=$nl.$jumplabel.'::'.$nl.$addressmatches[$address];
	$labelused[$address]=$jumplabel;
}
$jumpno=1;
foreach($jumpmatches as $jumpargumentindex => $jumplocation) {
	if(isset($labelused[$jumplocation]) && $labelused[$jumplocation]) {
		$jumplabel=$labelused[$jumplocation];
	} else {
		if($labelpoints[$jumplocation]) {
			$addressindex=get_address_pool_index($addresspool,$jumplocation);
			if($addressindex>=0) {
				$partialjumplabel='.jp'.strtoupper(dechex($jumpno)).'AG';
				$addressmatches[$jumplocation]=$nl.$partialjumplabel.$nl.$addressmatches[$jumplocation];
				$jumplabel=get_address_pool_label($addressindex).$partialjumplabel;
				$labelused[$jumplocation]=$jumplabel;
				$jumpno++;
			} else {
				$jumplabel=format_byte($jumplocation+16384);
			}
		} else {
			$jumplabel=format_byte($jumplocation+16384);
		}
	}
	$addressmatches[$jumpargumentindex]=str_replace('[[JUMPP]]',$jumplabel,$addressmatches[$jumpargumentindex]);
}
$i=0;
$c=EVENTDUMP_POINTER_TABLE_LENGTH;
while($i<$c) {
	$vala=$scriptsblob[$i];
	$addressmatches[$i]='    dw ';
	$pointerindex=strtoupper(dechex($i/2));
	$i++;
	$valb=$scriptsblob[$i];
	$val=(ord($valb)*256)+ord($vala);
	$jumplocation=$val-16384;
	if($jumplocation>=0) {
		if($labelused[$jumplocation]) {
			$jumplabel=$labelused[$jumplocation];
		} else {
			$jumplabel=format_byte($jumplocation+16384);
		}
	} else {
		$jumplabel=format_byte($jumplocation+16384);
	}
	$addressmatches[$i]=$jumplabel.' ; '.$pointerindex.$nl;
	$i++;
}
ksort($addressmatches);
echo implode($addressmatches);
function get_address_pool_label($index) {
	return 'EventSystem_EventScript_'.strtoupper(dechex($index));
}
function get_address_pool_index(&$addresspool,$address) {
	if($address<$addresspool[0]) {
		return 0;
	}
	$c=count($addresspool);
	if($address>=EVENTDUMP_DATA_LENGTH) {
		return $c-1;
	}
	$i=0;
	while($i<$c) {
		if(isset($addresspool[$i+1])) {
			$oobaddress=$addresspool[$i+1];
		} else {
			$oobaddress=EVENTDUMP_DATA_LENGTH;
		}
		if($address<$oobaddress) {
			return $i;
		}
		$i++;
	}
	return -1;
}
function get_length($index) {
	static $lengths;
	if(empty($lengths)) {
		$lengths=array(
			1,3,3,1,2,1,1,4,
			4,4,4,4,2,2,1,2,
			3,3,3,3,1,1,3,2,
			1,3,1,1,2,1,2,4,
			4,4,3,4,2,2,3,2,
			2,0,1,0,2,0,3,0,
			3,4,4,4,3,3,3,3,
			4,4,3,3,3,2,2,2,
			3,3,3,3,2,2,3,3,
			3,3,3,2,2,2,2,2,
			3,1,1,2,3,3,3,2,
			1,6,4,1,2,1,2,2,
			2,3,3,4,2,2,2,1,
			4,3,1,2,3,2,2,1,
			1,1,1,1,1,1,1,1,
			1
		);
	}
	if(isset($lengths[$index])) {
		return $lengths[$index];
	}
	return 0;
}
function parse_actions(&$addressmatches,&$jumpmatches,&$labelpoints,&$scriptsblob,$beginaddress,$oobaddress,$baseoffset=0,$killcount=0) {
	$currentaddress=$beginaddress+$baseoffset;
	if($currentaddress<$oobaddress&&$baseoffset>=0) {
		if(empty($addressmatches[$currentaddress])) {
			$index=ord($scriptsblob[$currentaddress]);
			$length=get_length($index);
			if($length>0) {
				if($currentaddress+$length<=$oobaddress) {
					$i=$currentaddress+1;
					$c=$currentaddress+$length;
					$unreserved=true;
					while($i<$c) {
						if(!empty($addressmatches[$i])) {
							$unreserved=false;
						}
						$i++;
					}
					if($unreserved) {
						$isend=($index==0||$index==6||$index>112?true:false);
						if(!$isend&&$index!=48) {
							parse_actions($addressmatches,$jumpmatches,$labelpoints,$scriptsblob,$beginaddress,$oobaddress,$baseoffset+$length,$killcount+1);
						}
						$jlength=get_jump_length($scriptsblob,$index,$currentaddress);
						dump_action($addressmatches,$jumpmatches,$labelpoints,$scriptsblob,$index,$currentaddress,$jlength);
						if($jlength!=0) {
							if($currentaddress+$jlength<=$oobaddress) {
								if($currentaddress+$jlength>$beginaddress) {
									if(!$isend) {
										parse_actions($addressmatches,$jumpmatches,$labelpoints,$scriptsblob,$beginaddress,$oobaddress,$baseoffset+$jlength,$killcount+1);
									}
								}
							}
						}
					}
				}
			}
		}
	}
}
function format_word($vala,$valb) {
	$val=(ord($vala)*256)+ord($valb);
	if($val<10) {
		return $val;
	}
	return '$'.strtoupper(dechex($val));
}
function format_byte($val) {
	$val=ord($val);
	if($val<10) {
		return $val;
	}
	return '$'.strtoupper(dechex($val));
}
function format_nibble_pair($val) {
	$val=ord($val);
	$vala=floor($val/16);
	$valb=$val%16;
	
	$valastr=$vala.'';
	if($vala>9) {
		$valastr='$'.strtoupper(dechex($vala));
	}
	$valbstr=$valb.'';
	if($valb>9) {
		$valbstr='$'.strtoupper(dechex($valb));
	}
	
	return $valastr.', '.$valbstr;
}
function dump_action(&$addressmatches,&$jumpmatches,&$labelpoints,&$scriptsblob,$index,$currentaddress,$jlength=0) {
	$currentramaddress=$currentaddress+16384;
	$labelpoints[$currentaddress]=true;
	
	$nl='
';
	switch($index) {
		case 0:
			$addressmatches[$currentaddress]='    M_ES_StandardEnd_A'.$nl;
			break;
		case 1:
			$addressmatches[$currentaddress]='    M_ES_OutputMessage_A ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).$nl;
			break;
		case 2:
			$addressmatches[$currentaddress]='    M_ES_OutputMessage_B ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).$nl;
			break;
		case 3:
			$addressmatches[$currentaddress]='    M_ES_ClearMessageWindow'.$nl;
			break;
		case 4:
			$addressmatches[$currentaddress]='    M_ES_WaitXFrames ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 5:
			$addressmatches[$currentaddress]='    M_ES_WaitForButtonPress'.$nl;
			break;
		case 6:
			$addressmatches[$currentaddress]='    M_ES_StandardEnd_B'.$nl;
			break;
		case 7:
			$addressmatches[$currentaddress]='    M_ES_WarpPlayer_A ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).', ';
			$addressmatches[$currentaddress+3]=format_byte($scriptsblob[$currentaddress+3]).$nl;
			break;
		case 8:
			$addressmatches[$currentaddress]='    M_ES_WarpPlayer_B ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).', ';
			$addressmatches[$currentaddress+3]=format_byte($scriptsblob[$currentaddress+3]).$nl;
			break;
		case 9:
			$addressmatches[$currentaddress]='    M_ES_WarpPlayer_C ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).', ';
			$addressmatches[$currentaddress+3]=format_byte($scriptsblob[$currentaddress+3]).$nl;
			break;
		case 10:
			$addressmatches[$currentaddress]='    M_ES_WarpPlayer_D ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).', ';
			$addressmatches[$currentaddress+3]=format_byte($scriptsblob[$currentaddress+3]).$nl;
			break;
		case 11:
			$addressmatches[$currentaddress]='    M_ES_WarpPlayer_E ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).', ';
			$addressmatches[$currentaddress+3]=format_byte($scriptsblob[$currentaddress+3]).$nl;
			break;
		case 12:
			$addressmatches[$currentaddress]='    M_ES_PlayerFaceDirection_A ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 13:
			$addressmatches[$currentaddress]='    M_ES_PlayerFaceDirection_B ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 14:
			$addressmatches[$currentaddress]='    M_ES_PlayerScheduleHop'.$nl;
			break;
		case 15:
			$addressmatches[$currentaddress]='    M_ES_PlayerScheduleHopInDirection ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 16:
			$addressmatches[$currentaddress]='    M_ES_PlayerScheduleWalk ';
			$addressmatches[$currentaddress+1]=format_nibble_pair($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).$nl;
			break;
		case 17:
			$addressmatches[$currentaddress]='    M_ES_EventFlag800S_A ';
			$addressmatches[$currentaddress+1]=format_word($scriptsblob[$currentaddress+1],$scriptsblob[$currentaddress+2]);
			$addressmatches[$currentaddress+2]=$nl;
			break;
		case 18:
			$addressmatches[$currentaddress]='    M_ES_EventFlag800S_B ';
			$addressmatches[$currentaddress+1]=format_word($scriptsblob[$currentaddress+1],$scriptsblob[$currentaddress+2]);
			$addressmatches[$currentaddress+2]=$nl;
			break;
		case 19:
			$addressmatches[$currentaddress]='    M_ES_EventFlag400S800R ';
			$addressmatches[$currentaddress+1]=format_word($scriptsblob[$currentaddress+1],$scriptsblob[$currentaddress+2]);
			$addressmatches[$currentaddress+2]=$nl;
			break;
		case 20:
			$addressmatches[$currentaddress]='    M_ES_CurrentEventFlag400S800R'.$nl;
			break;
		case 21:
			$addressmatches[$currentaddress]='    M_ES_CurrentEventFlag800R'.$nl;
			break;
		case 22:
			$addressmatches[$currentaddress]='    M_ES_EffectiveEventFlag400S800R ';
			$addressmatches[$currentaddress+1]=format_word($scriptsblob[$currentaddress+1],$scriptsblob[$currentaddress+2]);
			$addressmatches[$currentaddress+2]=$nl;
			break;
		case 23:
			$addressmatches[$currentaddress]='    M_ES_SetMultiJumpConditional ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 24:
			$addressmatches[$currentaddress]='    M_ES_IncrementMultiJumpConditional'.$nl;
			break;
		case 25:
			$addressmatches[$currentaddress]='    M_ES_FuckingWeirdSequenceJump ';
			$addressmatches[$currentaddress+1]=format_word($scriptsblob[$currentaddress+1],$scriptsblob[$currentaddress+2]);
			$addressmatches[$currentaddress+2]=$nl;
			break;
		case 26:
			$addressmatches[$currentaddress]='    M_ES_PartnerFacePlayer_A'.$nl;
			break;
		case 27:
			$addressmatches[$currentaddress]='    M_ES_PartnerFacePlayer_B'.$nl;
			break;
		case 28:
			$addressmatches[$currentaddress]='    M_ES_PartnerFaceDirection ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 29:
			$addressmatches[$currentaddress]='    M_ES_PartnerScheduleHop'.$nl;
			break;
		case 30:
			$addressmatches[$currentaddress]='    M_ES_FlickerPartner ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 31:
			$addressmatches[$currentaddress]='    M_ES_InitiateNPC_A ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).', ';
			$addressmatches[$currentaddress+3]=format_nibble_pair($scriptsblob[$currentaddress+3]).$nl;
			break;
		case 32:
			$addressmatches[$currentaddress]='    M_ES_InitiateNPC_B ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).', ';
			$addressmatches[$currentaddress+3]=format_nibble_pair($scriptsblob[$currentaddress+3]).$nl;
			break;
		case 33:
			$addressmatches[$currentaddress]='    M_ES_InitiateNPC_C ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).', ';
			$addressmatches[$currentaddress+3]=format_nibble_pair($scriptsblob[$currentaddress+3]).$nl;
			break;
		case 34:
			$addressmatches[$currentaddress]='    M_ES_NPCFaceDirection ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).$nl;
			break;
		case 35:
			$addressmatches[$currentaddress]='    M_ES_NPCScheduleWalk ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_nibble_pair($scriptsblob[$currentaddress+2]).', ';
			$addressmatches[$currentaddress+3]=format_byte($scriptsblob[$currentaddress+3]).$nl;
			break;
		case 36:
			$addressmatches[$currentaddress]='    M_ES_NPCRemoveSprite_A ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 37:
			$addressmatches[$currentaddress]='    M_ES_NPCRemoveSprite_B ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 38:
			$addressmatches[$currentaddress]='    M_ES_FlickerNPC ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).$nl;
			break;
		case 39:
			$addressmatches[$currentaddress]='    M_ES_NPCScheduleHop_A ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 40:
			$addressmatches[$currentaddress]='    M_ES_NPCScheduleHop_B ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 41:
			break;
		case 42:
			$addressmatches[$currentaddress]='    M_ES_PlayerWaitUntilDoneWalking'.$nl;
			break;
		case 43:
			break;
		case 44:
			$addressmatches[$currentaddress]='    M_ES_PartnerScheduleHopInDirection ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 45:
			break;
		case 46:
			$addressmatches[$currentaddress]='    M_ES_NPCScheduleHopInDirection ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).$nl;
			break;
		case 47:
			break;
		case 48:
			$addressmatches[$currentaddress]='    M_ES_RelativeLongJump ';
			$addressmatches[$currentaddress+1]='[[JUMPP]]';
			$addressmatches[$currentaddress+2]=$nl;
			$jumpmatches[$currentaddress+1]=$currentaddress+$jlength;
			break;
		case 49:
			$addressmatches[$currentaddress]='    M_ES_InitiateBattle_A ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).', ';
			$addressmatches[$currentaddress+3]=format_byte($scriptsblob[$currentaddress+3]).$nl;
			break;
		case 50:
			$addressmatches[$currentaddress]='    M_ES_InitiateBattle_B ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).', ';
			$addressmatches[$currentaddress+3]=format_byte($scriptsblob[$currentaddress+3]).$nl;
			break;
		case 51:
			$addressmatches[$currentaddress]='    M_ES_InitiateBattle_C ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).', ';
			$addressmatches[$currentaddress+3]=format_byte($scriptsblob[$currentaddress+3]).$nl;
			break;
		case 52:
			$addressmatches[$currentaddress]='    M_ES_SetFlag ';
			$addressmatches[$currentaddress+1]=format_word($scriptsblob[$currentaddress+1],$scriptsblob[$currentaddress+2]);
			$addressmatches[$currentaddress+2]=$nl;
			break;
		case 53:
			$addressmatches[$currentaddress]='    M_ES_ResetFlag ';
			$addressmatches[$currentaddress+1]=format_word($scriptsblob[$currentaddress+1],$scriptsblob[$currentaddress+2]);
			$addressmatches[$currentaddress+2]=$nl;
			break;
		case 54:
			$addressmatches[$currentaddress]='    M_ES_IncreaseInventory ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).$nl;
			break;
		case 55:
			$addressmatches[$currentaddress]='    M_ES_DecreaseInventory ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).$nl;
			break;
		case 56:
			$addressmatches[$currentaddress]='    M_ES_JumpIfFlagSet ';
			$addressmatches[$currentaddress+1]=format_word($scriptsblob[$currentaddress+1],$scriptsblob[$currentaddress+2]);
			$addressmatches[$currentaddress+2]=', ';
			$addressmatches[$currentaddress+3]='[[JUMPP]]'.$nl;
			$jumpmatches[$currentaddress+3]=$currentaddress+$jlength;
			break;
		case 57:
			$addressmatches[$currentaddress]='    M_ES_JumpIfFlagUnset ';
			$addressmatches[$currentaddress+1]=format_word($scriptsblob[$currentaddress+1],$scriptsblob[$currentaddress+2]);
			$addressmatches[$currentaddress+2]=', ';
			$addressmatches[$currentaddress+3]='[[JUMPP]]'.$nl;
			$jumpmatches[$currentaddress+3]=$currentaddress+$jlength;
			break;
		case 58:
			$addressmatches[$currentaddress]='    M_ES_AddChiru ';
			$addressmatches[$currentaddress+1]=format_word($scriptsblob[$currentaddress+2],$scriptsblob[$currentaddress+1]);
			$addressmatches[$currentaddress+2]=$nl;
			break;
		case 59:
			$addressmatches[$currentaddress]='    M_ES_SubtractChiru ';
			$addressmatches[$currentaddress+1]=format_word($scriptsblob[$currentaddress+2],$scriptsblob[$currentaddress+1]);
			$addressmatches[$currentaddress+2]=$nl;
			break;
		case 60:
			$addressmatches[$currentaddress]='    M_ES_PartnerScheduleWalk ';
			$addressmatches[$currentaddress+1]=format_nibble_pair($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).$nl;
			break;
		case 61:
			$addressmatches[$currentaddress]='    M_ES_NPCFacePlayer ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 62:
			$addressmatches[$currentaddress]='    M_ES_PositionPlayer ';
			$addressmatches[$currentaddress+1]=format_nibble_pair($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 63:
			$addressmatches[$currentaddress]='    M_ES_PositionPartner ';
			$addressmatches[$currentaddress+1]=format_nibble_pair($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 64:
			$addressmatches[$currentaddress]='    M_ES_BeginEarthquake_A ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).$nl;
			break;
		case 65:
			$addressmatches[$currentaddress]='    M_ES_BeginEarthquake_B ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).$nl;
			break;
		case 66:
			$addressmatches[$currentaddress]='    M_ES_BeginEarthquake_C ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).$nl;
			break;
		case 67:
			$addressmatches[$currentaddress]='    M_ES_BeginEarthquake_D ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).$nl;
			break;
		case 68:
			$addressmatches[$currentaddress]='    M_ES_ScheduleSFX ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 69:
			$addressmatches[$currentaddress]='    M_ES_SetMusic ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 70:
			$addressmatches[$currentaddress]='    M_ES_JumpOnPlayerDirection_A ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]='[[JUMPP]]'.$nl;
			$jumpmatches[$currentaddress+2]=$currentaddress+$jlength;
			break;
		case 71:
			$addressmatches[$currentaddress]='    M_ES_JumpOnPlayerDirection_B ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]='[[JUMPP]]'.$nl;
			$jumpmatches[$currentaddress+2]=$currentaddress+$jlength;
			break;
		case 72:
			$addressmatches[$currentaddress]='    M_ES_JumpOnPlayerDirection_C ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]='[[JUMPP]]'.$nl;
			$jumpmatches[$currentaddress+2]=$currentaddress+$jlength;
			break;
		case 73:
			$addressmatches[$currentaddress]='    M_ES_JumpOnPlayerDirection_D ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]='[[JUMPP]]'.$nl;
			$jumpmatches[$currentaddress+2]=$currentaddress+$jlength;
			break;
		case 74:
			$addressmatches[$currentaddress]='    M_ES_JumpOnPlayerDirection_E ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]='[[JUMPP]]'.$nl;
			$jumpmatches[$currentaddress+2]=$currentaddress+$jlength;
			break;
		case 75:
			$addressmatches[$currentaddress]='    M_ES_JumpOnPlayerWin_A ';
			$addressmatches[$currentaddress+1]='[[JUMPP]]'.$nl;
			$jumpmatches[$currentaddress+1]=$currentaddress+$jlength;
			break;
		case 76:
			$addressmatches[$currentaddress]='    M_ES_NPCRemoveGeneralSprite ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 77:
			$addressmatches[$currentaddress]='    M_ES_ExecuteCutsceneBehaviour ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 78:
			$addressmatches[$currentaddress]='    M_ES_JumpOnPlayerWin_B ';
			$addressmatches[$currentaddress+1]='[[JUMPP]]'.$nl;
			$jumpmatches[$currentaddress+1]=$currentaddress+$jlength;
			break;
		case 79:
			$addressmatches[$currentaddress]='    M_ES_JumpOnPlayerWin_C ';
			$addressmatches[$currentaddress+1]='[[JUMPP]]'.$nl;
			$jumpmatches[$currentaddress+1]=$currentaddress+$jlength;
			break;
		case 80:
			$addressmatches[$currentaddress]='    M_ES_ShopPriceMessage_A ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).$nl;
			break;
		case 81:
			$addressmatches[$currentaddress]='    M_ES_IncrementComparative'.$nl;
			break;
		case 82:
			$addressmatches[$currentaddress]='    M_ES_DecrementComparative'.$nl;
			break;
		case 83:
			$addressmatches[$currentaddress]='    M_ES_SetComparative ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 84:
			$addressmatches[$currentaddress]='    M_ES_JumpIfMatchComparative ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]='[[JUMPP]]'.$nl;
			$jumpmatches[$currentaddress+2]=$currentaddress+$jlength;
			break;
		case 85:
			$addressmatches[$currentaddress]='    M_ES_JumpIfNotMatchComparative ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]='[[JUMPP]]'.$nl;
			$jumpmatches[$currentaddress+2]=$currentaddress+$jlength;
			break;
		case 86:
			$addressmatches[$currentaddress]='    M_ES_ShopPriceMessage_B ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).$nl;
			break;
		case 87:
			$addressmatches[$currentaddress]='    M_ES_NPCWaitUntilDoneWalking ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 88:
			$addressmatches[$currentaddress]='    M_ES_PartnerWaitUntilDoneWalking'.$nl;
			break;
		case 89:
			$addressmatches[$currentaddress]='    M_ES_GetEventDenjuu ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).', ';
			$addressmatches[$currentaddress+3]=format_byte($scriptsblob[$currentaddress+3]).', ';
			$addressmatches[$currentaddress+4]=format_byte($scriptsblob[$currentaddress+4]).', ';
			$addressmatches[$currentaddress+5]=format_byte($scriptsblob[$currentaddress+5]).$nl;
			break;
		case 90:
			$addressmatches[$currentaddress]='    M_ES_JumpIfLTEInventory ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).', ';
			$addressmatches[$currentaddress+3]='[[JUMPP]]'.$nl;
			$jumpmatches[$currentaddress+3]=$currentaddress+$jlength;
			break;
		case 91:
			$addressmatches[$currentaddress]='    M_ES_DisplayMapLocation'.$nl;
			break;
		case 92:
			$addressmatches[$currentaddress]='    M_ES_RingRing ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 93:
			$addressmatches[$currentaddress]='    M_ES_StopRinging'.$nl;
			break;
		case 94:
			$addressmatches[$currentaddress]='    M_ES_SetReception ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 95:
			$addressmatches[$currentaddress]='    M_ES_EventNPCSetPaletteRangeA ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 96:
			$addressmatches[$currentaddress]='    M_ES_EventNPCSetPaletteRangeB ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 97:
			$addressmatches[$currentaddress]='    M_ES_JumpOnOverworldPartnerSpecies ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]='[[JUMPP]]'.$nl;
			$jumpmatches[$currentaddress+2]=$currentaddress+$jlength;
			break;
		case 98:
			$addressmatches[$currentaddress]='    M_ES_PlayerScheduleWalkBackwards ';
			$addressmatches[$currentaddress+1]=format_nibble_pair($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).$nl;
			break;
		case 99:
			$addressmatches[$currentaddress]='    M_ES_NPCScheduleWalkBackwards ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_nibble_pair($scriptsblob[$currentaddress+2]).', ';
			$addressmatches[$currentaddress+3]=format_byte($scriptsblob[$currentaddress+3]).$nl;
			break;
		case 100:
			$addressmatches[$currentaddress]='    M_ES_NPCFaceAwayFromPlayer ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 101:
			$addressmatches[$currentaddress]='    M_ES_EventNPCSetPaletteRangeBAndDontUseItWTFSmilesoftB ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 102:
			$addressmatches[$currentaddress]='    M_ES_EventNPCSetPaletteRangeBAndDontUseItWTFSmilesoftA ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 103:
			$addressmatches[$currentaddress]='    M_ES_ResetOverworldInteration'.$nl;
			break;
		case 104:
			$addressmatches[$currentaddress]='    M_ES_Mode7WarpPlayer ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]=format_byte($scriptsblob[$currentaddress+2]).', ';
			$addressmatches[$currentaddress+3]=format_byte($scriptsblob[$currentaddress+3]).$nl;
			break;
		case 105:
			$addressmatches[$currentaddress]='    M_ES_JumpOnSpeciesInContacts ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).', ';
			$addressmatches[$currentaddress+2]='[[JUMPP]]'.$nl;
			$jumpmatches[$currentaddress+2]=$currentaddress+$jlength;
			break;
		case 106:
			$addressmatches[$currentaddress]='    M_ES_PlayCredits'.$nl;
			break;
		case 107:
			$addressmatches[$currentaddress]='    M_ES_ChangePhoneState ';
			$addressmatches[$currentaddress+1]=format_byte($scriptsblob[$currentaddress+1]).$nl;
			break;
		case 108:
			$addressmatches[$currentaddress]='    M_ES_EventFlag400R800R ';
			$addressmatches[$currentaddress+1]=format_word($scriptsblob[$currentaddress+1],$scriptsblob[$currentaddress+2]);
			$addressmatches[$currentaddress+2]=$nl;
			break;
		case 109:
			$addressmatches[$currentaddress]='    M_ES_JumpOnSilentMode ';
			$addressmatches[$currentaddress+1]='[[JUMPP]]'.$nl;
			$jumpmatches[$currentaddress+1]=$currentaddress+$jlength;
			break;
		case 110:
			$addressmatches[$currentaddress]='    M_ES_JumpIfZukanComplete ';
			$addressmatches[$currentaddress+1]='[[JUMPP]]'.$nl;
			$jumpmatches[$currentaddress+1]=$currentaddress+$jlength;
			break;
		case 111:
			$addressmatches[$currentaddress]='    M_ES_BasicEnd_A'.$nl;
			break;
		case 112:
			$addressmatches[$currentaddress]='    M_ES_BasicEnd_B'.$nl;
			break;
		case 113:
			$addressmatches[$currentaddress]='    M_ES_BasicEnd_C'.$nl;
			break;
		case 114:
			$addressmatches[$currentaddress]='    M_ES_BasicEnd_D'.$nl;
			break;
		case 115:
			$addressmatches[$currentaddress]='    M_ES_BasicEnd_E'.$nl;
			break;
		case 116:
			$addressmatches[$currentaddress]='    M_ES_BasicEnd_F'.$nl;
			break;
		case 117:
			$addressmatches[$currentaddress]='    M_ES_BasicEnd_G'.$nl;
			break;
		case 118:
			$addressmatches[$currentaddress]='    M_ES_BasicEnd_H'.$nl;
			break;
		case 119:
			$addressmatches[$currentaddress]='    M_ES_BasicEnd_I'.$nl;
			break;
		case 120:
			$addressmatches[$currentaddress]='    M_ES_BasicEnd_J'.$nl;
			break;
	}
}
function get_jump_length(&$scriptsblob,$index,$currentaddress) {
	switch($index) {
		case 48:
			$offseta=ord($scriptsblob[$currentaddress+1]);
			$offsetb=ord($scriptsblob[$currentaddress+2]);
			$offset=($offseta*256)+$offsetb+1;
			if($offset+$currentaddress+16384>65535) {
				return 0-(($currentaddress+16384)-(($offset+$currentaddress+16384)%65536));
			}
			return $offset;
		case 56:
		case 57:
		case 90:
			$offset=ord($scriptsblob[$currentaddress+3])+1;
			if($offset>127) {
				return 0-(256-$offset);
			}
			return $offset;
		case 70:
		case 71:
		case 72:
		case 73:
		case 74:
		case 84:
		case 85:
		case 97:
		case 105:
			$offset=ord($scriptsblob[$currentaddress+2])+1;
			if($offset>127) {
				return 0-(256-$offset);
			}
			return $offset;
		case 75:
		case 78:
		case 79:
		case 109:
		case 110:
			$offset=ord($scriptsblob[$currentaddress+1])+1;
			if($offset>127) {
				return 0-(256-$offset);
			}
			return $offset;
	}
	return 0;
}
?>