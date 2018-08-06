if (!isServer) exitWith {};
// SINGLE INFANTRY GROUP
private ["_grp","_unit","_pool","_pos","_faction"];

_pos=(_this select 0);
_grpSize=(_this select 1);
_faction=(_this select 2);
_side=(_this select 3);
_sidesArray = [WEST,EAST,Resistance,Civilian];
_enemyFactionsArray = [];

_grpMin=_grpSize select 0;
_grpMax=_grpSize select 1;
_d=_grpMax-_grpMin;				
_r=floor(random _d);							
_grpSize=_r+_grpMin;
				
	if (surfaceiswater _pos) then {_pool=[_faction,1] call eos_fnc_getunitpool;}else{_pool=[_faction,0] call eos_fnc_getunitpool;};
	
	_grp=createGroup _side;
    
    {
        if ([_side, _x] call BIS_fnc_sideIsEnemy) then
        {
            _enemyFactionsArray append [_x];
        };
    } forEach _sidesArray;
			
for "_x" from 1 to _grpSize do {					
		_unitType=_pool select (floor(random(count _pool)));
        _init = [_unitType,_enemyFactionsArray] call eos_fnc_getunitloadout;
		//_unit = _grp createUnit [_unitType, _pos, [], 6, "FORM"];
        _unit = _unitType createUnit [_pos, _grp, _init];
	};


_grp
