params ["_player", "_didJIP"];

diag_log format["initPlayerLocal run for %1 (prewaituntil)", name _player];
if (!hasInterface || isDedicated) exitWith {};

waituntil{!isNull(_player)};

//Clientside Stuff

titleText ["Loading...", "BLACK",0.1];
0.1 fadeSound 0;
0.1 fadeRadio 0;
0.1 fadeMusic 0;
0.1 fadeSpeech 0;

diag_log format["Tooth DEBUG: initPlayerLocal run for %1", name _player];


AT_Revive_StaticRespawns = [];
AT_Revive_enableRespawn = false;
AT_Revive_clearedDistance = 0;
AT_Revive_Camera = 1;

//[] call ATR_FNC_ReviveInit;
_player addEventHandler ["HandleDamage", ATR_FNC_ReduceDamage];

//BIS
//_player unassignItem "ItemMap";
//_player removeItem "ItemMap";
//_player unassignItem "ItemCompass";
//_player removeItem "ItemCompass";
_player unassignItem "itemGPS";
_player removeItem "itemGPS";
//_player unassignItem "O_UavTerminal";
//_player removeItem "O_UavTerminal";
//_player unassignitem "B_UavTerminal"; 
//_player removeitem "B_UavTerminal";
//_player unassignitem "I_UavTerminal"; 
//_player removeitem "I_UavTerminal";
_player unassignItem "NVGoggles";
_player removeItem "NVGoggles";
_player unassignItem "NVGoggles_OPFOR";
_player removeItem "NVGoggles_OPFOR";
_player unassignItem "NVGoggles_INDEP";
_player removeItem "NVGoggles_INDEP";
//RHS
_player unassignItem "rhsusf_ANPVS_14";
_player removeItem "rhsusf_ANPVS_14";
_player unassignItem "rhsusf_ANPVS_15";
_player removeItem "rhsusf_ANPVS_15";
_player unassignItem "rhs_1PN138";
_player removeItem "rhs_1PN138";
_player unassignItem "rhsusf_ANPVS_15";
_player removeItem "rhsusf_ANPVS_15";
//
_player unassignItem "A3_GPNVG18_REC_BLK_F";
_player removeItem "A3_GPNVG18_REC_BLK_F";
//BIS Apex
_player unassignItem "O_NVGoggles_hex_F";
_player removeItem "O_NVGoggles_hex_F";
_player unassignItem "O_NVGoggles_urb_F";
_player removeItem "O_NVGoggles_urb_F";
_player unassignItem "O_NVGoggles_ghex_F";
_player removeItem "O_NVGoggles_ghex_F";
_player unassignItem "NVGoggles_tna_F";
_player removeItem "NVGoggles_tna_F";
_player unassignItem "NVGogglesB_blk_F";
_player removeItem "NVGogglesB_blk_F";
_player unassignItem "NVGogglesB_grn_F";
_player removeItem "NVGogglesB_grn_F";
_player unassignItem "NVGogglesB_gry_F";
_player removeItem "NVGogglesB_gry_F";
//CUP
_player unassignItem "CUP_NVG_HMNVS";
_player removeItem "CUP_NVG_HMNVS";
_player unassignItem "CUP_NVG_PVS7";
_player removeItem "CUP_NVG_PVS7";
_player unassignItem "CUP_NVG_PVS14";
_player removeItem "CUP_NVG_PVS14";


//removeAllWeapons _player;
//removeAllItems _player;
if(hmd _player != "") then {
	private _hmd = hmd _player;
	_player unlinkItem _hmd;
};


if (Tooth_playerUniform != "") then
{
    removeUniform _player;    
	_player forceAddUniform Tooth_playerUniform;
};
if (Tooth_playerVest != "") then
{
    removeVest _player;    
	_player addVest Tooth_playerVest;
};
if (Tooth_playerHeadgear != "") then
{
    removeHeadgear _player;    
	_player addHeadgear Tooth_playerHeadgear;
};
if (Tooth_playerGoggles != "") then
{
    removeGoggles _player;    
	_player addGoggles Tooth_playerGoggles;
};
if (Tooth_playerBackpack != "") then
{
    removeBackpack _player;    
	_player addBackpack Tooth_playerBackpack;
};

if (Tooth_playersHaveRadio) then
{
	_player addItem "ItemRadio";
	_player assignItem "ItemRadio";
};

if (Tooth_playersHaveWatch) then
{
	_player addItem "ItemWatch";
	_player assignItem "ItemWatch";
};

if (Tooth_playersHaveMap) then
{
	_player addItem "ItemMap";
	_player assignItem "ItemMap";
};

if (Tooth_playersHaveCompass) then
{
	_player addItem "ItemCompass";
	_player assignItem "ItemCompass";
};

enableTeamSwitch false;
// mag repack
[] execVM "scripts\outlw_magRepack\MagRepack_init_sv.sqf";

[] spawn {
	disableSerialization;
	waitUntil {!isNull(findDisplay 46)};
	(findDisplay 46) displayAddEventHandler ["keyDown", "_this call a3e_fnc_KeyDown"];
};

// stamina stuff
//_player setFatigue 0.0;
_player enableStamina false;
//[_player] spawn
//{
//	_player = _this select 0;
//    while {alive _player} do
//    {
//        //_player setFatigue 0.0;
//        _player enableStamina false;
//        sleep 10.0;
//    };
//};

// Start saving _player loadout periodically
[_player] spawn {
	_player = _this select 0;
	while {true} do {
		sleep 10;
		if (alive _player) then {
			_player setVariable ["respawnLoadout", getUnitLoadout _player]; 
		};
	};
};

_player setUnitTrait ["medic",true];
_player setUnitTrait ["engineer",true];
_player setUnitTrait ["explosiveSpecialist",true];

_player setvariable["A3E_PlayerInitializedLocal",true,true];
waituntil {sleep 0.5;((_player getvariable["A3E_PlayerInitializedServer",false]) && (_player getvariable["A3E_PlayerInitializedLocal",false]) && (missionNameSpace getvariable["A3E_ServerInitialized",false]))};


diag_log format["Tooth DEBUG: %1 is now ready (clientside).", name _player];

titleFadeOut 0.5;
0.5 fadeSound 1;
0.5 fadeRadio 1;
0.5 fadeMusic 1;
0.5 fadeSpeech 1;

[] spawn 
{
	sleep 12.0;
	if (Tooth_introMusic != "") then
	{
		playMusic Tooth_introMusic;
	};
    _monthString = [] call Toothfunctions_fnc_monthToString;
	["Mujahideen Camp",A3E_WorldName,format ["%1 %2",_monthString,(date select 0)]] spawn BIS_fnc_infoText;
};

ZeusVariable = [_player]; //ie _player
publicVariableServer "ZeusVariable";
