// ##POTS## 
// _nil = null [CAR, CHANCE, SUICIDE_YELL, DELAY, SIZE, ATTACH_TO_VEHICLE, DISTANCE_FROM_TARGET, [_targetSide], DEAD_MAN_SWITCH, DETONATION_TRIGGER] execVM "suicidebomber.sqf";
if(!isServer)exitWith{};
//private ["_types","_null3","_null2","_null1","_men","_null","_achance","_rchance","_driver_is_alive","_enemyside","_driver_is_alive_lp","_detonateTrigger","_deadManSwitch","_targetSide","_distance","_wait","_size","_delay","_shoutout","_possibility","_car",];
COMMON_fnc_getEnemyFactions = compile preprocessfile "scripts\common\getEnemyFactions.sqf";
_car = _this select 0;
_possibility = _this select 1;
_shoutout = _this select 2;
_delay = _this select 3;
_size = _this select 4;
_attachToVehicle = _this select 5;
_distance = _this select 6;
_targetSide = _this select 7;
_deadManSwitch = _this select 8;
_detonateTrigger = _this select 9;
_driver_is_alive_lp = true;
_detonateTrigger = false;
_enemyside = west;
_enemyFactions = [driver _car] call COMMON_fnc_getEnemyFactions;
_wait = 1;

{
    //if(_enemyside == _x) then
    if(_x in _enemyFactions) then
    {
    	while {_wait == 1} do
    	{
    		if(alive _car) then
    		{
    			_driver_is_alive = alive (driver _car);
    			sleep 0.75;
    			if((driver _car isKindOf "Man") && (side driver _car != _x) && (_driver_is_alive)) then
    			{
    				_types = _car nearObjects ["All", _distance];
    				{if(side _x == west) then {_wait = 0}} foreach _types;
    			};
    			if ((!_driver_is_alive) && (_driver_is_alive_lp) && _deadManSwitch) then
    			{
    				_possibility = 10;
    				_wait = 0;
    			};
    			if (_detonateTrigger) then
    			{
    				_possibility = 10;
    				_wait = 0;
    			};
    			_driver_is_alive_lp = _driver_is_alive;
    		}
    		else
    		{
    			_wait = 0;
    			_possibility = 0;
    		};
    	};
    };

} forEach _targetSide;



if (_possibility > 0) then
{
	_achance = random 10;
	_rchance = round _achance;
	if(_rchance <= _possibility) then
	{
		cuttext [_shoutout,"PLAIN",2];
		sleep _delay;
		if (_size == "SMALL") then 
		{
			_men = crew _car;	
			{deleteVehicle _x} foreach _men;
			_null = "R_80mm_HE" createVehicle getPos _car;
			//_updatepos = [(getPos _car) select 0, ((getPos _car) select 1) + 1];
			//sleep 0.25;
			//_null = "R_80mm_HE" createVehicle _updatepos;	
            _null setDammage 1;
			//_car setDammage 1; 
		};
		if (_size == "MEDIUM") then 
		{
			_men = crew _car;	
			{deleteVehicle _x} foreach _men;
			//_null = "Sh_122_HE" createVehicle getPos _car;
			_null = "SatchelCharge_Remote_Ammo" createVehicle getPos _car;
            _null setDammage 1;
			//_car setDammage 1; 
		};
		if (_size == "LARGE") then 
		{
			_men = crew _car;	
			{deleteVehicle _x} foreach _men;
			_null1 = "Bo_GBU12_LGB" createVehicle getPos _car;
			_null2 = "R_80mm_HE" createVehicle getPos _car;
			_null3 = "IEDLandBig_F" createVehicle getPos _car;
			_null1 setDammage 1;
			sleep 0.1;
			_null2 setDammage 1;
			sleep 0.1;
			_null3 setDammage 1;
			_car setDammage 1;
			//deleteVehicle _car;
		};
	};
};
