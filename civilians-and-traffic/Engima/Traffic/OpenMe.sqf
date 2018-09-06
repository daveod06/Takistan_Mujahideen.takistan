// put this in init.sqf

// --------------------------------------  COMPILE CIVILIANS
call compile preprocessFileLineNumbers "civilians-and-traffic\Engima\Traffic\TrafficInit.sqf";
// --------------------------------------  START UP CIVILIANS
_faction = 1;
_SIDE = civilian;
_VEHICLES_COUNT = 10;
_MAX_GROUPS_COUNT = 0;
_MIN_SPAWN_DISTANCE = 600;
_MAX_SPAWN_DISTANCE = 1200;
_MIN_SKILL = 0.3;
_MAX_SKILL = 0.6;
_AREA_MARKER = "traffic_area";
_HIDE_AREA_MARKER = true;
_ON_UNIT_CREATING = {true};
_ON_UNIT_CREATED = {};
_ON_UNIT_REMOVING = {};
[_faction,_SIDE,_VEHICLES_COUNT,_MAX_GROUPS_COUNT,_MIN_SPAWN_DISTANCE,_MAX_SPAWN_DISTANCE,_MIN_SKILL,_MAX_SKILL,_AREA_MARKER,_HIDE_AREA_MARKER,_ON_UNIT_CREATING,_ON_UNIT_CREATED,_ON_UNIT_REMOVING] spawn Saber_fnc_TrafficMaster;

