// [_staticName] execVm "scripts\common\staticFleeWeapon.sqf"
if(!isServer)exitWith{};
private ["_staticName","_loop","_string","_triggers","_enemyFactions","_staticTrigger","_numTriggersActive"];
COMMON_fnc_staticOk = compile preprocessfile "scripts\common\staticOk.sqf";
COMMON_fnc_getEnemyFactions = compile preprocessfile "scripts\common\getEnemyFactions.sqf";
_staticName = _this select 0;
_loop = 1;
_numTriggersActive = 0;

_enemyFactions = [gunner _staticName] call COMMON_fnc_getEnemyFactions;
_triggers = [];
{    
    _string = (str _x) + " SEIZED";
    _staticTrigger = createTrigger ["EmptyDetector", (getPos _staticName), true];
    _staticTrigger setTriggerArea [20, 20, 0, false, 20];
    _staticTrigger setTriggerActivation [_string, "PRESENT", false];
    _triggers append [_staticTrigger];
} forEach _enemyFactions;


while {_loop == 1} do
{
    if ([_staticName] call COMMON_fnc_staticOk) then
    {
        {
            if (triggerActivated _x) then
            {
                _numTriggersActive = _numTriggersActive + 1;
            };
        } forEach _triggers;

        if (_numTriggersActive > 0) then
        {
            _loop = 0;
            doGetOut (gunner _staticName);
            moveOut (gunner _staticName);
            wp0 = (group (gunner _staticName)) addwaypoint [(getPos _staticName), 500];
            wp0 setwaypointtype "MOVE";
        };
    }
    else
    {
        _loop = 0;
    };
};


