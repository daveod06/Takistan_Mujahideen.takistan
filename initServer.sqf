//if (!isServer or hasInterface) exitWith {};


// set up zeus for 4 players
missionCurators = [];
CuratorLogicGroup = creategroup sideLogic;

// Enable/Disbale animals, flies, and bugs -- false turns them off
enableEnvironment true;

_timeOfDay = ("Param_TimeOfDay" call BIS_fnc_getParamValue);
_hour = _timeOfDay;
switch (_timeOfDay) do {
    case 24: { 
		_hour = round(random(24));
	};
    case 25: {
		_hour = 6+round(random(12));  //Between 0600 and 1800
	};
	case 26: { 
		_hour = 20 + round(random(8)); //Between 2000 and 0400
		_hour = _hour % 24;
	};
    default { _hour = _timeOfDay };
};
setDate [Tooth_year, Tooth_month, Tooth_day, _timeOfDay, 0];

uiSleep 0.2;
setTimeMultiplier ("Param_TimeMultiplier" call BIS_fnc_getParamValue);
if ( ("Param_UseCustomWeather" call BIS_fnc_getParamValue) == 1) then
{
};

sleep 1.0;
missionNameSpace setvariable["A3E_ServerInitialized",true,true];
