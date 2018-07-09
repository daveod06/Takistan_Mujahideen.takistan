/* 
 * This file contains parameters to config and function call to start an instance of
 * traffic in the mission. The file is edited by the mission developer.
 *
 * See file Engima\Traffic\Documentation.txt for documentation and a full reference of 
 * how to customize and use Engima's Traffic.
 */
 
 private ["_parameters"];

// Set traffic parameters.

_parameters = [
	["SIDE", civilian],
	["VEHICLES", ["CUP_C_S1203_CIV","CUP_C_S1203_Ambulance_CIV","CUP_C_Lada_GreenTK_CIV","CUP_C_Lada_TK2_CIV","CUP_C_V3S_Open_TKC","CUP_C_V3S_Covered_TKC","CUP_C_UAZ_Unarmed_TK_CIV","CUP_C_Datsun","CUP_C_Volha_Blue_TKCIV","CUP_C_Volha_Gray_TKCIV","CUP_C_Volha_Limo_TKCIV"]],
	["VEHICLES_COUNT", 10],
	["MAX_GROUPS_COUNT", 0],
	["MIN_SPAWN_DISTANCE", 800],
	["MAX_SPAWN_DISTANCE", 1200],
	["MIN_SKILL", 0.4],
	["MAX_SKILL", 0.6],
	["AREA_MARKER", "traffic_area"],
	["HIDE_AREA_MARKER", true],
	["ON_UNIT_CREATING", { true }],
	["ON_UNIT_CREATED", {}],
	["ON_UNIT_REMOVING", {}]
];

/*
_parameters = [
	["SIDE", civilian],
	["VEHICLES", ["CUP_C_UAZ_Unarmed_TK_CIV","CUP_C_Volha_Blue_TKCIV","CUP_C_V3S_Open_TKC","CUP_C_LR_Transport_CTK","CUP_C_Lada_GreenTK_CIV","CUP_C_Datsun"]],
	["VEHICLES_COUNT", 10],
	["MAX_GROUPS_COUNT", 12],
	["MIN_SPAWN_DISTANCE", 800],
	["MAX_SPAWN_DISTANCE", 1200],
	["MIN_SKILL", 0.4],
	["MAX_SKILL", 0.6],
	["AREA_MARKER", "traffic_area"],
	["HIDE_AREA_MARKER", true],
	["ON_UNIT_CREATING", { true }],
	["ON_UNIT_CREATED", {}],
	["ON_UNIT_REMOVING", {}],
	["DEBUG", false]
];
*/

// Start an instance of the traffic
_parameters spawn ENGIMA_TRAFFIC_StartTraffic;
