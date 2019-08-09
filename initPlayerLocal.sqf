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
_player setFatigue 0.0;
_player enableStamina false;

[_player] spawn
{
	_player = _this select 0;
    while {alive _player} do
    {
        _player setFatigue 0.0;
        _player enableStamina false;
        sleep 2.0;
    };
};


//// Start saving _player loadout periodically
//[_player] spawn {
//	_player = _this select 0;
//	while {true} do {
//		sleep 10;
//		if (alive _player) then {
//			_player setVariable ["respawnLoadout", getUnitLoadout _player]; 
//		};
//	};
//};

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
	[A3E_WorldName , format ["%1 %2",_monthString,(date select 0)]] spawn BIS_fnc_infoText;
};

ZeusVariable = [_player]; //ie _player
publicVariableServer "ZeusVariable";
