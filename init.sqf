Saber_DEBUG = true;

// Compile EOS
call compile preprocessFileLineNumbers "enemy-occupation-system\EOSInit.sqf";
sleep 1.0;

// Civilians & Traffic
call compile preprocessFileLineNumbers "civilians-and-traffic\Engima\Civilians\Init.sqf";
sleep 1.0;
//call compile preprocessFileLineNumbers "civilians-and-traffic\Engima\Traffic\Init.sqf";
sleep 1.0;

// Compile Convoy, Airmobile, and Artillery
[] execVM "scripts\common\CommonInit.sqf";
sleep 2.0;
[] execVM "ai-convoys\ConvoyInit.sqf";
sleep 2.0;
[] execVM "airmobile-ops\AirmobileInit.sqf";
sleep 2.0;
[] execVM "ai-artillery\ArtilleryInit.sqf";
sleep 2.0;
[] execVM "wave-defense\WaveInit.sqf";
sleep 2.0;

setViewDistance 9000;
setTerrainGrid 6.25;
setObjectViewDistance [4000,800];
setDetailMapBlendPars [50, 150];

// set up zeus for 4 players
missionCurators = [];
CuratorLogicGroup = creategroup sideLogic;

//init_fnc =
//{
//	"traffic_area" setMarkerAlpha 0.0;
//	_laserT = createVehicle ["LaserTargetE", [0,0,0], [], 0, "NONE"]; 
//	_laserT attachto [attack_heli0, [0, 0, 0]];
//	attack_heli0 doTarget attack_heli0;
//	attack_heli0 reveal attack_heli0;
//};


//ToggleAmbush = false;

//[] spawn 
//{
//	while {!ToggleAmbush} do
//	{
//		{
//			if (side _x == independent) then
//			{
//				if (set_ind_ambush distance _x < 350.0) then
//				{
//					_x setBehaviour "STEALTH"; 
//					_x setCombatMode "BLUE";
//					_x setSpeedMode "LIMITED";
//					_x setUnitPos "DOWN";
//					hint "SET SAFE.";
//				    //_x setBehaviour "COMBAT";
//				    //_x setCombatMode "RED";
//				    //_x setSpeedMode "FULL";
//				    //_x setUnitPos "AUTO";
//				    //hint "ALLAH AKBAR!!!!!";
//				};
//			};
//		} forEach allUnits;
//		sleep 5.0;
//	};
//};

// -------------------------------------- Start up EOS
["JIP_id", "onplayerConnected", {[] spawn  execVM EOS_fnc_Markers;}] call BIS_fnc_addStackedEventHandler;
VictoryColor="colorGreen";	// Colour of marker after completion
hostileColor="colorRed";	// Default colour when enemies active
bastionColor="colorOrange";	// Colour for bastion marker
EOS_DAMAGE_MULTIPLIER=1;	// 1 is default
EOS_KILLCOUNTER=false;		// Counts killed units
EOS_USE_FLASHLIGHTS=false;   // Attempts to make spawned units use flashlights
EOS_SUICIDE_CHANCE=0.0;     // Attemps to % of units as suicide bombers 0.0-1.0
/*
GROUP SIZES
 0 = 1
 1 = 2,4
 2 = 4,8
 3 = 8,12
 4 = 12,16
 5 = 16,20

EXAMPLE CALL - EOS
 null = [["MARKERNAME","MARKERNAME2"],[2,1,70],[0,1],[1,2,30],[2,60],[2],[1,0,10],[1,0,250,WEST]] call EOS_Spawn;
 null=[["M1","M2","M3"],[HOUSE GROUPS,SIZE OF GROUPS,PROBABILITY],[PATROL GROUPS,SIZE OF GROUPS,PROBABILITY],[LIGHT VEHICLES,SIZE OF CARGO,PROBABILITY],[ARMOURED VEHICLES,PROBABILITY], [STATIC VEHICLES,PROBABILITY],[HELICOPTERS,SIZE OF HELICOPTER CARGO,PROBABILITY],[FACTION,MARKERTYPE,DISTANCE,SIDE,HEIGHTLIMIT,DEBUG]] call EOS_Spawn;

EXAMPLE CALL - BASTION
 null = [["BAS_zone_1"],[3,1],[2,1],[2],[0,0],[0,0,EAST,false,false],[10,2,120,TRUE,TRUE]] call EOS_fnc_Bastion_Spawn;//Bastion_Spawn;
 null=[["M1","M2","M3"],[PATROL GROUPS,SIZE OF GROUPS],[LIGHT VEHICLES,SIZE OF CARGO],[ARMOURED VEHICLES],[HELICOPTERS,SIZE OF HELICOPTER CARGO],[FACTION,MARKERTYPE,SIDE,HEIGHTLIMIT,DEBUG],[INITIAL PAUSE, NUMBER OF WAVES, DELAY BETWEEN WAVES, INTEGRATE EOS, SHOW HINTS]] call Bastion_Spawn;
*/
VictoryColor="colorGreen";	// Colour of marker after completion
hostileColor="colorRed";	// Default colour when enemies active
bastionColor="colorOrange";	// Colour for bastion marker
EOS_DAMAGE_MULTIPLIER=1;	// 1 is default
EOS_KILLCOUNTER=false;		// Counts killed units
EOS_USE_FLASHLIGHTS=false;   // Attempts to make spawned units use flashlights
EOS_SUICIDE_CHANCE=0.0;     // Attemps to % of units as suicide bombers 0.0 -1.0

null = [["EOSzone_1"],[4,2,80],[5,2,60],[2,1,60],[1,50],[1,50],[0,0],[7,1,1000,EAST,TRUE]] call EOS_fnc_Spawn; //EOS_Spawn;
null = [["EOSzone_2"],[2,2,60],[1,1,75],[0,0],[0],[0],[0,0],[7,1,400,EAST,TRUE]] call EOS_fnc_Spawn; //EOS_Spawn;
null = [["EOSzone_3"],[1,1,80],[2,1,80],[0,0],[0],[0],[0,0],[7,2,1000,EAST,TRUE]] call EOS_fnc_Spawn; //EOS_Spawn;
null = [["EOSzone_4"],[1,1,80],[2,1,80],[0,0],[0],[0],[0,0],[7,2,1000,EAST,TRUE]] call EOS_fnc_Spawn; //EOS_Spawn;
null = [["EOSzone_5"],[1,1,80],[2,1,80],[0,0],[0],[0],[0,0],[7,2,1000,EAST,TRUE]] call EOS_fnc_Spawn; //EOS_Spawn;
null = [["EOSzone_6"],[0,0,0],[4,1,100],[0,0,0],[0],[2,100],[0,0],[8,1,1000,Independent,TRUE]] call EOS_fnc_Spawn;  //EOS_Spawn;
//null = [["EOSzone_1"],["BAS_spawn_0",5],[4,3,80],[1,1,80],[0],[0,0],[8,0,Independent],[10*60,2,5*60,FALSE,TRUE]] call EOS_fnc_Bastion_Spawn;//Bastion_Spawn;
//null = [["EOSmot_1","EOSmot_2"],[0,0],[0,0],[3,1,90],[2,60],[0],[1,0,90],[0,0,350,EAST,FALSE]] call EOS_fnc_Spawn;//EOS_Spawn;
//null = [["BAS_zone_1"],[0,1],[0,2],[0],[1,2],[0,0,EAST,TRUE],[0,2,120,TRUE,FALSE]] call EOS_fnc_Bastion_Spawn;//Bastion_Spawn;
//[] spawn EOS_fnc_Master; // not needed
sleep 10.0;

// -------------------------------------- Start up convoy
_btr_convoy = [
"OKSVA_BRDM2",
"OKSVA_BTR60PB",
"OKSVA_BTR60PB",
"OKSVA_BTR60PB",
"OKSVA_BTR60PB",
"OKSVA_GAZ66_Ammo",
"OKSVA_GAZ66_R142",
"OKSVA_BRDM2UM_Armed"
];
_bmp_convoy = [
"OKSVA_BRDM2",
"OKSVA_BMP1K",
"OKSVA_BMP1",
"OKSVA_BMP1",
"OKSVA_BMP1",
"OKSVA_GAZ66_Ammo",
"OKSVA_GAZ66_R142",
"OKSVA_BRDM2UM_Armed"
];
_truck_convoy = [
"OKSVA_UAZ_Open",
"OKSVA_GAZ66",
"OKSVA_GAZ66",
"OKSVA_GAZ66",
"OKSVA_GAZ66",
"OKSVA_GAZ66",
"OKSVA_GAZ66",
"OKSVA_GAZ66_Ammo"
];
_bmd_convoy = [
"OKSVA_BRDM2",
"OKSVA_BMD1K",
"OKSVA_BMD1",
"OKSVA_BMD1",
"OKSVA_BMD1",
"OKSVA_GAZ66_Ammo",
"OKSVA_BRDM2UM_Armed"
];
_tank_convoy = [
"OKSVA_BRDM2",
"OKSVA_T72B_1984",
"OKSVA_T72B_1984",
"OKSVA_T72B_1984",
"OKSVA_Ural_Fuel",
"OKSVA_GAZ66_Repair",
"OKSVA_BRDM2UM_Armed"
];
_armed_supply_convoy = [
"OKSVA_BRDM2",
"OKSVA_GAZ66_ZU23",
"OKSVA_GAZ66_Ammo",
"OKSVA_GAZ66_Ammo",
"OKSVA_GAZ66_Ammo",
"OKSVA_Ural_Fuel",
"OKSVA_Ural_Fuel",
"OKSVA_Ural_Fuel",
"OKSVA_BRDM2"
];
_unarmed_supply_convoy = [
"OKSVA_UAZ",
"OKSVA_GAZ66",
"OKSVA_GAZ66_Ammo",
"OKSVA_GAZ66_Ammo",
"OKSVA_GAZ66_Ammo",
"OKSVA_Ural_Fuel",
"OKSVA_Ural_Fuel",
"OKSVA_Ural_Fuel",
"OKSVA_GAZ66"
];
_small_supply_convoy = [
"OKSVA_UAZ",
"OKSVA_GAZ66_Ammo",
"OKSVA_GAZ66_Ammo",
"OKSVA_Ural_Fuel",
"OKSVA_Ural_Fuel"
];
_possible_convoys=[_btr_convoy,_truck_convoy,_armed_supply_convoy,_unarmed_supply_convoy,_small_supply_convoy];
_convoy_route = ["convoy_route_0","convoy_route_1","convoy_route_2","convoy_route_3"];
_convoy_spawn_points = ["convoy_pos_0","convoy_pos_1","convoy_pos_2","convoy_pos_3","convoy_pos_4","convoy_pos_5","convoy_pos_6","convoy_pos_7","convoy_pos_8"];
_convoy_side = east;
_enemy_side = resistance;
_pos_name_prefix = "convoy_pos_";
_convoy_type = selectRandom _possible_convoys;
_speed_kph = 65;
_threat_radius_m = 300;
_speed_str = "FULL";
_behavior = "CARELESS";
_numConvoys = 5;
_waitTime = 60*20;
[_convoy_route,_convoy_spawn_points,_convoy_side,_enemy_side,_pos_name_prefix,_convoy_type,_speed_kph,_threat_radius_m,_speed_str,_behavior,_numConvoys,_waitTime] spawn Saber_fnc_ConvoyMaster;
sleep 10.0;

// --------------------------------------  Start up artillery
RydFFE_NoControl = []; // each arty group (battery) held inside this array will be excluded from FAW control
RydFFE_ArtyShells = 10; // positive integer. Multiplier of default magazines loadout per kind per each artillery piece
RydFFE_Interval = 20; // time gap (in seconds) between each “seek for targets cycle (each cycle each idle battery on map looks for new fire mission opportunity)
RydFFE_Debug = true; // if set as true, will be shown map markers that allows user to watch, what is going on. See DEBUG MARKERS chapter for details;
RydFFE_ShellView = true;
RydFFE_FOClass = [
"OKSVA_Spotter_MSV",
"OKSVA_Senior_Technician_MSV",
"OKSVA_Senior_Officer_MSV",
"OKSVA_Officer_MSV",
"OKSVA_Junior_Officer_MSV",
"OKSVA_Officer_VDV"
]; // if this array is set as not empty (even with objNull), limited spotting modebecomes active, so only members of groups, which names are inside this array or whichleaders are of proper class (see below), will have ability of spotting targets for batteries.
//RydFFE_FO = [objNull];
RydFFE_Amount = 5; // this holds number of shells, that in summary should be fired in each fire mission. CLUSTER and GUIDED salvo amount is always divided by 3 (rounded up);
RydFFE_Acc = 3; // multiplier of whole salvo drift radius. The bigger value, the bigger radius;
RydFFE_Safe = 50; // salvo will be not planned for coordinates located within this radius (in meters) around any allied group leader;
RydFFE_Monogamy = false; // by default each enemy group can be a target for only one battery at the time. If set to false, there is no such limitation, so one target can be shelled by any number of batteries at the time;
RydFFE_Add_SPMortar = []; // here you can list classnames of custom SP mortar units, that should be controlled by ;
RydFFE_Add_Mortar = ["OKSVA_2B14"]; // here you can list classnames of custom mortar units, that should be controlled by ;
RydFFE_Add_Rocket = ["oksva_bm21"]; // here you can list classnames of custom rocket artillery units, that should be controlled by ;
RydFFE_Add_Other = []; // here you can list classnames of other custom artillery units (lowercase only!), that should be controlled by , if are using custom magazines (classes added here shouldn't be added to any other array).
[] spawn FFE_fnc_Master;
sleep 10.0;

//// --------------------------------------  Start up Waves
//[] spawn Saber_fnc_WaveMaster;
//sleep 10.0;


