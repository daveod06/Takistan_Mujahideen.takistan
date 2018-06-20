// _script = [_numRounds, _mortar, _targetUnit, _radius, _delay] execVM "scripts\mortars.sqf";
if(!isServer)exitWith{};
//private ["_mortarOk","_i","_gunnerName","_numRounds","_mortar","_targetUnit","_radius","_delay","_unit","_pos","_center","_ammo"];
_numRounds = _this select 0;
_mortar = _this select 1;
_targetUnit = _this select 2; // array of possible target units
_radius = _this select 3;
_delay = _this select 4;

aliveCheckFnc = {
	private _mortarName = _this select 0;
	private _mortarOk = false;
	if (!(isNull _mortarName)) then
	{
    		if (alive _mortarName) then
		{
			if (!(isNull (gunner _mortarName))) then
			{
				if (alive (gunner _mortarName)) then
				{
					_mortarOk = true;
				};
			};
		};
	};
	_mortarOk;
};

setAiFireFnc = {
	private _mortarName = _this select 0;
	private _mode = _this select 1;
	if (!(isNull _mortarName)) then
	{
		_gunnerName = gunner _mortarName;
	}
	else
	{
		_gunnerName = objNull;
	};
	
	if (!(isNull _gunnerName) && (alive _gunnerName)) then
	{
		if (_mode) then
		{
			_gunnerName enableAI "TARGET";
			_gunnerName enableAI "AUTOTARGET";
			_gunnerName enableAI "WEAPONAIM";
		}
		else
		{
			_gunnerName disableAI "TARGET";
			_gunnerName disableAI "AUTOTARGET";
			_gunnerName disableAI "WEAPONAIM";
		};
	}
};

for [{_i=0}, {_i<_numRounds}, {_i=_i+1}] do 
{  
	_mortarOk = [_mortar] call aliveCheckFnc;
	if ((_mortarOk) && (count _targetUnit != 0)) then
	{
		_unit = _targetUnit call BIS_fnc_selectRandom;
		_center = getPosAtl _unit;
		_ammo = getArtilleryAmmo [_mortar] select 0;
		_pos = [(_center select 0) - _radius + (2 * random _radius), (_center select 1) - _radius + (2 * random _radius), 0];
		_mortar doArtilleryFire [_pos, _ammo, 1];
		sleep _delay;
	};
};
