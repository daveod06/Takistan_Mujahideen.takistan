/* 
 * This file contains config parameters and a function call to start the civilian script.
 * The parameters in this file may be edited by the mission developer.
 *
 * See file Engima\Civilians\Documentation.txt for documentation and a full reference of 
 * how to customize and use Engima's Civilians.
 */
 
private ["_parameters"];

// Set civilian parameters.
_parameters = [
	["UNIT_CLASSES", ["C_CUPTAKCIVS_Civ_1_01","C_CUPTAKCIVS_Civ_2_01","C_CUPTAKCIVS_Civ_3_01","C_CUPTAKCIVS_Civ_4_01","C_CUPTAKCIVS_Civ_5_01","C_CUPTAKCIVS_Civ_6_01","C_CUPTAKCIVS_Civ_7_01","C_CUPTAKCIVS_Civ_8_01","C_CUPTAKCIVS_Civ_9_01","C_CUPTAKCIVS_Civ_10_01"]],
	["UNITS_PER_BUILDING", 0.4],
	["MAX_GROUPS_COUNT", 50],
	["MIN_SPAWN_DISTANCE", 50],
	["MAX_SPAWN_DISTANCE", 500],
	["BLACKLIST_MARKERS", ["no_civ_1","no_civ_2","no_civ_3"]],
	["HIDE_BLACKLIST_MARKERS", true],
	["ON_UNIT_SPAWNED_CALLBACK", {}],
	["ON_UNIT_REMOVE_CALLBACK", { true }],
	["DEBUG", false]
];

// Start the script
_parameters spawn ENGIMA_CIVILIANS_StartCivilians;
