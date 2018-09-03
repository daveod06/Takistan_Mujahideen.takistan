if (!isServer or hasInterface) exitWith {};

//Saber_DEBUG = true;

// Compile EOS
//call compile preprocessFileLineNumbers "EnemyOccupationSystem\EOSInit.sqf";
//sleep 1.0;

//// Civilians & Traffic
//call compile preprocessFileLineNumbers "CiviliansAndTraffic\Engima\Civilians\Init.sqf";
//sleep 1.0;
//call compile preprocessFileLineNumbers "CiviliansAndTraffic\Engima\Traffic\Init.sqf";
//sleep 1.0;

//// Compile Convoy, Airmobile, and Artillery
//[] execVM "scripts\common\CommonInit.sqf";
//sleep 2.0;
//[] execVM "Convoy\ConvoyInit.sqf";
//sleep 2.0;
//[] execVM "Airmobile\AirmobileInit.sqf";
//sleep 2.0;
//[] execVM "Artillery\ArtilleryInit.sqf";
//sleep 2.0;
//[] execVM "WaveDefense\WaveInit.sqf";
//sleep 2.0;

setViewDistance 9000;
setTerrainGrid 6.25;
setObjectViewDistance [4000,800];
setDetailMapBlendPars [50, 150];



//init_fnc =
//{
//	"traffic_area" setMarkerAlpha 0.0;
//	_laserT = createVehicle ["LaserTargetE", [0,0,0], [], 0, "NONE"]; 
//	_laserT attachto [attack_heli0, [0, 0, 0]];
//	attack_heli0 doTarget attack_heli0;
//	attack_heli0 reveal attack_heli0;
//};


ToggleAmbush = false;

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
//					//hint "SET SAFE.";
//				};
//			};
//		} forEach allUnits;
//		sleep 5.0;
//	};
//};


//// start up EOS
//[] spawn EOS_fnc_Master;
//sleep 10.0;

//// Start up convoy
//[] spawn Saber_fnc_ConvoyMaster;
//sleep 10.0;

//// Start up artillery
//[] spawn FFE_fnc_Master;
//sleep 10.0;

//// Start up Waves
//[] spawn Saber_fnc_WaveMaster;
//sleep 10.0;


// set up zeus for 4 players
missionCurators = [];
CuratorLogicGroup = creategroup sideLogic;


//if (isServer) then {
//	CuratorLogicGroup = creategroup sideLogic;  
//	CheatCurator0 = CuratorLogicGroup createunit ["ModuleCurator_F", [0, 90, 90],[],0.5,"NONE"];    
//	CheatCurator0 setvariable ["text","CheatCurator0"];     
//	CheatCurator0 setvariable ["Addons",3,true];//3: allow all addons with proper use of CfgPatches
//	CheatCurator0 setvariable ["owner","objnull"];  
//	CheatCurator0 setvariable ["vehicleinit","_this setvariable ['Addons',3,true]; _this setvariable ['owner','objnull'];"]; 
//	unassignCurator CheatCurator0;
//    sleep 1.0;
//	objnull assignCurator CheatCurator0;
//	
//	CheatCurator1 = CuratorLogicGroup createunit ["ModuleCurator_F", [0, 90, 90],[],0.5,"NONE"];    
//	CheatCurator1 setvariable ["text","CheatCurator1"];     
//	CheatCurator1 setvariable ["Addons",3,true];//3: allow all addons with proper use of CfgPatches
//	CheatCurator1 setvariable ["owner","objnull"];  
//	CheatCurator1 setvariable ["vehicleinit","_this setvariable ['Addons',3,true]; _this setvariable ['owner','objnull'];"]; 
//	unassignCurator CheatCurator1;
//    sleep 1.0;
//	objnull assignCurator CheatCurator1;
//	
//	CheatCurator2 = CuratorLogicGroup createunit ["ModuleCurator_F", [0, 90, 90],[],0.5,"NONE"];    
//	CheatCurator2 setvariable ["text","CheatCurator2"];     
//	CheatCurator2 setvariable ["Addons",3,true];//3: allow all addons with proper use of CfgPatches
//	CheatCurator2 setvariable ["owner","objnull"];  
//	CheatCurator2 setvariable ["vehicleinit","_this setvariable ['Addons',3,true]; _this setvariable ['owner','objnull'];"]; 
//	unassignCurator CheatCurator2;
//    sleep 1.0;
//	objnull assignCurator CheatCurator2;
//	
//	CheatCurator3 = CuratorLogicGroup createunit ["ModuleCurator_F", [0, 90, 90],[],0.5,"NONE"];    
//	CheatCurator3 setvariable ["text","CheatCurator3"];     
//	CheatCurator3 setvariable ["Addons",3,true];//3: allow all addons with proper use of CfgPatches
//	CheatCurator3 setvariable ["owner","objnull"];  
//	CheatCurator3 setvariable ["vehicleinit","_this setvariable ['Addons',3,true]; _this setvariable ['owner','objnull'];"]; 
//	unassignCurator CheatCurator3;
//    sleep 1.0;
//	objnull assignCurator CheatCurator3;
//	
//	missionCurators = [CheatCurator0, CheatCurator1, CheatCurator2, CheatCurator3];
//	[] execVM "setupmissionzeus.sqf";
//};
