//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};


if HC3Present then
{
	//EOS Dynamic Combat System
	[]execVM "scripts\eos\OpenMe.sqf";
}
else
{
	if HC2Present then
	{
		//EOS Dynamic Combat System
		[]execVM "scripts\eos\OpenMe.sqf";
	}
	else
	{
		if HC1Present then
		{
			//EOS Dynamic Combat System
			[]execVM "scripts\eos\OpenMe.sqf";
		}
		else
		{
			//EOS Dynamic Combat System
			[]execVM "scripts\eos\OpenMe.sqf";
		};
	};
};

// Civilians & Traffic
call compile preprocessFileLineNumbers "scripts\Engima\Civilians\Init.sqf";
call compile preprocessFileLineNumbers "scripts\Engima\Traffic\Init.sqf";




sleep 4.0;
[] execVM "Convoy\ConvoyInit.sqf";
[] execVM "Airmobile\AirmobileInit.sqf";
sleep 1.0;

//hint "Calling Saber_fnc_ConvoySpawnVehicles.";
//[] spawn Saber_fnc_ConvoySpawnVehicles;
//hint "Spawning Saber_fnc_AirmobileMaster.";
//[] spawn Saber_fnc_AirmobileMaster;
