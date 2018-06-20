// [_unit]  execVM "scripts\common\getEnemyFactions.sqf"
if (!isServer) exitWith {};
private ["_unit","_sidesArray","_enemyFactionsArray","_side"];
_unit = _this select 0;

_sidesArray = [WEST,EAST,Resistance,Civilian];
_enemyFactionsArray = [];
_side = side _unit;

{
    if ([_side, _x] call BIS_fnc_sideIsEnemy) then
    {
        _enemyFactionsArray append [_x];
    };
} forEach _sidesArray;
_enemyFactionsArray
