// F3 - Briefing
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// MAKE SURE THE PLAYER INITIALIZES PROPERLY

if (!isDedicated && (isNull player)) then
{
    waitUntil {sleep 0.1; !isNull player};
};

// ====================================================================================

// DECLARE VARIABLES AND FUNCTIONS

private ["_unitFaction", "_leaderFaction"];

// ====================================================================================

// DETECT PLAYER FACTION
// The following code detects what faction the player's slot belongs to, and stores
// it in the private variable _unitFaction

_unitFaction = toLower (faction player);
_leaderFaction = toLower (faction (leader group player));

// If the unitfaction is different from the group leader's faction, the latters faction is used
if (_unitFaction != _leaderFaction) then {
	_unitFaction = _leaderFaction;
};

// ====================================================================================

// NOTES: CREDITS
// The code below creates the administration sub-section of notes.

_cre = player createDiaryRecord ["diary", ["Credits","
<br/>
Created by GRUBES (https://github.com/GRUBES/alive-uprising)
<br/><br/>
Briefings by F3 (http://www.ferstaberinde.com/f3/en/)
"]];

// ====================================================================================

// BRIEFING: ADMIN
// The following block of code executes only if the player is the current host
// it automatically includes a file which contains the appropriate briefing data.

if (serverCommandAvailable "#kick") then {

#include "f_briefing_admin.sqf"

};

// ====================================================================================

//// BRIEFING: BLUFOR > NATO
//// The following block of code executes only if the player is in a NATO slot; it
//// automatically includes a file which contains the appropriate briefing data.
//
//if (_unitFaction == "blu_f") exitWith {
//
//#include "f_briefing_nato.sqf"
//
//};

// ====================================================================================

// BRIEFING: FIA
// The following block of code executes only if the player is in a FIA slot; it
// automatically includes a file which contains the appropriate briefing data.

if (_unitFaction in ["blu_g_f","ind_g_f","opf_g_f","I_MiddleEastMujahideen_1980s"]) exitWith {

#include "f_briefing_fia.sqf"

};

// ====================================================================================

// BRIEFING: OPFOR > CSAT
// The following block of code executes only if the player is in a CSAT slot; it
// automatically includes a file which contains the appropriate briefing data.

if (_unitFaction in ["caf_ag_eeur_r","O_USSRSovietArmy_OKSVA"]) exitWith {

#include "f_briefing_csat.sqf"

};

// ====================================================================================

// BRIEFING: CIVILIAN
// The following block of code executes only if the player is in a CIVILIAN
// slot; it automatically includes a file which contains the appropriate briefing data.

if (_unitFaction in ["civ_f","CUP_TAK_CIVS"]) exitWith {

#include "f_briefing_civ.sqf"

};

// ====================================================================================

// ERROR CHECKING
// If the faction of the unit cannot be defined, the script exits with an error.

player globalChat format ["DEBUG (briefing.sqf): Faction %1 is not defined.",_unitFaction];