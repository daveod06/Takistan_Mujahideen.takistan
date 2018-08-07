//[_bomber,[CIVILIAN,WEST,EAST,RESISTANCE],_explosiveSize,_radius,_deadManSwtich,_detonateTrigger] execVM "scripts\suicideBomber.sqf"; //The unit you want to be the bomber, the sides you want the bomber to attack, classname of explosive you want to use
if(!isServer)exitWith{};
//private ["_pos","_nearUnits","_explosive","_explosiveClass","_explosivesOptions","_runCode","_detonateTrigger","_deadManSwtich","_radius","_explosiveSize","_targetSide","_bomber",];
COMMON_fnc_unitOk = compile preprocessfile "scripts\common\unitOk.sqf";
_bomber = _this select 0;
_targetSide = _this select 1;
_explosiveSize = _this select 2;
_radius = _this select 3;
_deadManSwtich = _this select 4;
_detonateTrigger = _this select 5;
_runCode = 1;
_detonateTrigger = false;

_explosivesOptions = ["SMALL","MEDIUM","LARGE"];

if (!(_explosiveSize in _explosivesOptions)) then
{
    _explosiveSize = "SMALL";
};

if (_explosiveSize == "SMALL") then
{
    _explosiveClass = "grenadeHand"
};
if (_explosiveSize == "MEDIUM") then
{
    _explosiveClass = "R_60mm_HE"
};
if (_explosiveSize == "LARGE") then
{
    _explosiveClass = "Bo_Mk82"
};

//while {alive _bomber && _runCode == 1} do
while {_runCode == 1} do
{
	if ((!(isNull _bomber) && !(alive _bomber) && _deadManSwtich) || (!(isNull _bomber) && _detonateTrigger)) then
	{
		_explosive = _explosiveClass createVehicle (position _bomber);
		[_explosive] spawn {
			_explosive = _this select 0; 
			_explosive setDamage 1; 
		};
		[_explosive] spawn {
			_explosive = _this select 0; 
			deleteVehicle _explosive; 
		};
		_runCode = 0;
	}
	else
	{
		if ([_bomber] call COMMON_fnc_unitOk) then
		{
			_nearUnits = nearestObjects [_bomber,["CAManBase"],70];
			_nearUnits = _nearUnits - [_bomber];
			{
				if(!(side _x in _targetSide)) then {_nearUnits = _nearUnits - [_x];};
			} forEach _nearUnits;
			if(count _nearUnits != 0) then
			{
				_pos = position (_nearUnits select 0);
				_bomber doMove _pos;
				waitUntil {(_bomber distance _pos < _radius) or (!alive _bomber) or (!alive(_nearUnits select 0))};
				if(_bomber distance (_nearUnits select 0) < _radius)
				exitWith
				{
				_runCode = 0;
				_explosive = _explosiveClass createVehicle (position _bomber);
				[_bomber,_explosive] spawn {
					_bomber = _this select 0; 
					_explosive = _this select 1; 
					_bomber say3D "shout";
					sleep 1.5; 
					_explosive setDamage 1; 
					_bomber addRating -10000000;
					};
				[_explosive,_bomber] spawn {
					_explosive = _this select 0; 
					_bomber = _this select 1; 
					waitUntil {!alive _bomber};
					deleteVehicle _explosive; 
					};
				};
			};
		};
	};
	sleep 1;
};
