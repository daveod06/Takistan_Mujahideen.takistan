Saber_DEBUG = true;

// Compile EOS
call compile preprocessFileLineNumbers "EnemyOccupationSystem\EOSInit.sqf";
sleep 1.0;

// Civilians & Traffic
call compile preprocessFileLineNumbers "CiviliansAndTraffic\Engima\Civilians\Init.sqf";
sleep 1.0;
//call compile preprocessFileLineNumbers "CiviliansAndTraffic\Engima\Traffic\Init.sqf";
sleep 1.0;

// Compile Convoy, Airmobile, and Artillery
[] execVM "scripts\common\CommonInit.sqf";
sleep 2.0;
[] execVM "Convoy\ConvoyInit.sqf";
sleep 2.0;
[] execVM "Airmobile\AirmobileInit.sqf";
sleep 2.0;
[] execVM "Artillery\ArtilleryInit.sqf";
sleep 2.0;
[] execVM "WaveDefense\WaveInit.sqf";
sleep 2.0;

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
//					//hint "SET SAFE.";
//				};
//			};
//		} forEach allUnits;
//		sleep 5.0;
//	};
//};

// start up EOS
[] spawn EOS_fnc_Master;
sleep 10.0;

//// Start up convoy
//[] spawn Saber_fnc_ConvoyMaster;
//sleep 10.0;

// Start up artillery
[] spawn FFE_fnc_Master;
sleep 10.0;

// Start up Waves
[] spawn Saber_fnc_WaveMaster;
sleep 10.0;


