diag_log format ["DRO: player %1 waiting for player init", player];
waitUntil {!isNull player};
_player = _this select 0;
_player = player;
// Load function libraries

addWeaponItemEverywhere = compileFinal " _this select 0 addPrimaryWeaponItem (_this select 1); ";
addHandgunItemEverywhere = compileFinal " _this select 0 addHandgunItem (_this select 1); ";
removeWeaponItemEverywhere = compileFinal "_this select 0 removePrimaryWeaponItem (_this select 1)";

if (!hasInterface || isDedicated) exitWith {};

_player setVariable ['startReady', false, true];

fnc_missionText = {
	// Mission info readout
	_campName = (missionNameSpace getVariable "publicCampName");
	diag_log format ["DRO: _player %1 establishing shot initialised", _player];
	sleep 3;
	[parseText format [ "<t font='EtelkaMonospaceProBold' color='#ffffff' size = '1.7'>%1</t>", toUpper _campName], true, nil, 5, 0.7, 0] spawn BIS_fnc_textTiles;
	sleep 6;
	_hours = "";
	if ((date select 3) < 10) then {
		_hours = format ["0%1", (date select 3)];
	} else {
		_hours = str (date select 3);
	};
	_minutes = "";
	if ((date select 4) < 10) then {
		_minutes = format ["0%1", (date select 4)];
	} else {
		_minutes = str (date select 4);
	};
	[parseText format [ "<t font='EtelkaMonospaceProBold' color='#ffffff' size = '1.7'>%1  %2</t>", str(date select 1) + "." + str(date select 2) + "." + str(date select 0), _hours + _minutes + " HOURS"], true, nil, 5, 0.7, 0] spawn BIS_fnc_textTiles;
	sleep 6;
	// Operation title text
	_missionName = missionNameSpace getVariable "mName";
	_string = format ["<t font='EtelkaMonospaceProBold' color='#ffffff' size = '1.7'>%1</t>", _missionName];
	[parseText format [ "<t font='EtelkaMonospaceProBold' color='#ffffff' size = '1.7'>%1</t>", toUpper _missionName], true, nil, 7, 0.7, 0] spawn BIS_fnc_textTiles;
};



_player setVariable ["respawnLoadout", (getUnitLoadout _player), true];

enableTeamSwitch false;

setViewDistance 9000;
setTerrainGrid 6.25;
setObjectViewDistance [4000,800];
setDetailMapBlendPars [50, 150];


removeAllWeapons _player;
removeAllItems _player;
removeAllAssignedItems _player;
_player addItemToUniform "FirstAidKit";
for "_i" from 1 to 8 do {_player addItemToUniform "rhsgref_5Rnd_762x54_m38";};

_player addWeapon "rhs_weap_m38";

_player linkItem "ItemMap";
_player linkItem "ItemCompass";
_player linkItem "ItemWatch";


// Start saving player loadout periodically
[] spawn {
	while {true} do {
		sleep 5;
		if (alive player) then {
			player enableFatigue false;
			player setVariable ["respawnLoadout", getUnitLoadout player]; 
		};
	};
};
