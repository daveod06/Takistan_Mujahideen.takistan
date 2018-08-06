if (!isServer) exitWith {};
//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};


if (isClass (configfile >> "CfgPatches" >> "ace_weather")) then { //We have ACE Weather, oh god, we've gotta turn it off before it breaks everything!
	["ace_weather_useACEWeather", false, true, true] call ace_common_fnc_setSetting;
	["ace_weather_enableServerController", false, true, true] call ace_common_fnc_setSetting;
	["ace_weather_syncRain", false, true, true] call ace_common_fnc_setSetting;
	["ace_weather_syncWind", false, true, true] call ace_common_fnc_setSetting;
	["ace_weather_syncMisc", false, true, true] call ace_common_fnc_setSetting;	
};

Saber_DEBUG = true;

// Compile EOS
call compile preprocessFileLineNumbers "EnemyOccupationSystem\EOSInit.sqf";

// Civilians & Traffic
call compile preprocessFileLineNumbers "CiviliansAndTraffic\Engima\Civilians\Init.sqf";
call compile preprocessFileLineNumbers "CiviliansAndTraffic\Engima\Traffic\Init.sqf";

// Compile Convoy, Airmobile, and Artillery
[] execVM "scripts\common\CommonInit.sqf";
sleep 1.0;
[] execVM "Convoy\ConvoyInit.sqf";
sleep 1.0;
[] execVM "Airmobile\AirmobileInit.sqf";
sleep 1.0;
[] execVM "Artillery\ArtilleryInit.sqf";
sleep 1.0;

// start up EOS
[] spawn EOS_fnc_Master;

setViewDistance 9000;
setTerrainGrid 6.25;
setObjectViewDistance [4000,800];
setDetailMapBlendPars [50, 150];


missionNameSpace setVariable ["serverReady", 1];
publicVariable "serverReady";

