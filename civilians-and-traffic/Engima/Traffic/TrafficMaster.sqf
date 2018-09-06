

fnc_master = 
{
	
	_faction = _this select 0;
	_SIDE = _this select 1;
	_VEHICLES_COUNT = _this select 2;
	_MAX_GROUPS_COUNT = _this select 3;
	_MIN_SPAWN_DISTANCE = _this select 4;
	_MAX_SPAWN_DISTANCE = _this select 5;
	_MIN_SKILL = _this select 6;
	_MAX_SKILL = _this select 7;
	_AREA_MARKER = _this select 8;
	_HIDE_AREA_MARKER = _this select 9;
	_ON_UNIT_CREATING = _this select 10;
	_ON_UNIT_CREATED = _this select 11;
	_ON_UNIT_REMOVING = _this select 12;


	ENGIMA_TRAFFIC_instanceIndex = -1;
	ENGIMA_TRAFFIC_areaMarkerNames = [];
	ENGIMA_TRAFFIC_roadSegments = [];
	ENGIMA_TRAFFIC_edgeTopLeftRoads = [];
	ENGIMA_TRAFFIC_edgeTopRightRoads = [];
	ENGIMA_TRAFFIC_edgeBottomRightRoads = [];
	ENGIMA_TRAFFIC_edgeBottomLeftRoads = [];
	ENGIMA_TRAFFIC_edgeRoadsUseful = [];


	/* 
	 * This file contains parameters to config and function call to start an instance of
	 * traffic in the mission. The file is edited by the mission developer.
	 *
	 * See file Engima\Traffic\Documentation.txt for documentation and a full reference of 
	 * how to customize and use Engima's Traffic.
	 */
	 
	 private ["_parameters"];

	// Set traffic parameters.
	_units = [_faction] call Saber_fnc_TrafficUnitPools;

	_parameters = [
		["SIDE", _SIDE],
		["VEHICLES", _units],
		["VEHICLES_COUNT", _VEHICLES_COUNT],
		["MAX_GROUPS_COUNT", _MAX_GROUPS_COUNT],
		["MIN_SPAWN_DISTANCE", _MIN_SPAWN_DISTANCE],
		["MAX_SPAWN_DISTANCE", _MAX_SPAWN_DISTANCE],
		["MIN_SKILL", _MIN_SKILL],
		["MAX_SKILL", _MAX_SKILL],
		["AREA_MARKER", _AREA_MARKER],
		["HIDE_AREA_MARKER", true],
		["ON_UNIT_CREATING", _HIDE_AREA_MARKER],
		["ON_UNIT_CREATED", _ON_UNIT_CREATED],
		["ON_UNIT_REMOVING", _ON_UNIT_REMOVING]
	];

	// Start an instance of the traffic
	_parameters spawn ENGIMA_TRAFFIC_StartTraffic;

};

// DED SERVER LOAD BALANCE call fnc_master
if (isServer) then 
{
	_this call fnc_master;
};