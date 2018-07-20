//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

// Enemy Occupation System (EOS) Setup
if HC3Present then
{
	//EOS Dynamic Combat System
	[] execVM "scripts\eos\OpenMe.sqf";
}
else
{
	if HC2Present then
	{
		//EOS Dynamic Combat System
		[] execVM "scripts\eos\OpenMe.sqf";
	}
	else
	{
		if HC1Present then
		{
			//EOS Dynamic Combat System
			[] execVM "scripts\eos\OpenMe.sqf";
		}
		else
		{
			//EOS Dynamic Combat System
			[] execVM "scripts\eos\OpenMe.sqf";
		};
	};
};

// Civilians & Traffic
call compile preprocessFileLineNumbers "scripts\Engima\Civilians\Init.sqf";
call compile preprocessFileLineNumbers "scripts\Engima\Traffic\Init.sqf";

// Compile Convoy, Airmobile, and Artillery
[] execVM "Convoy\ConvoyInit.sqf";
[] execVM "Airmobile\AirmobileInit.sqf";
[] execVM "Artillery\ArtilleryInit.sqf";
[] execVM "scripts\common\CommonInit.sqf";

init_fnc =
{
	"traffic_area" setMarkerAlpha 0.0;
	_laserT = createVehicle ["LaserTargetE", [0,0,0], [], 0, "NONE"]; 
	_laserT attachto [attack_heli0, [0, 0, 0]];
	attack_heli0 doTarget attack_heli0;
	attack_heli0 reveal attack_heli0;
};



