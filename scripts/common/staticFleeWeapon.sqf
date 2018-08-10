// [_staticName] execVm "scripts\common\staticFleeWeapon.sqf"
//if(!isServer)exitWith{};
//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

fnc_staticFleeWeapon =
{
    private ["_staticName","_loop","_string","_triggers","_enemyFactions","_staticTrigger","_numTriggersActive"];
    _staticName = _this;
    _loop = 1;
    _numTriggersActive = 0;

    while {_loop == 1} do
    {
        if ([_staticName] call Saber_fnc_staticOk) then
        {
            _nearestEnemy = _staticName findNearestEnemy (getPosAtl _staticName);
            if !(isNull _nearestEnemy) then
            {
                _distance = (getPosAtl _nearestEnemy) distance2D (getPosAtl _staticName);
                if (_distance < 20) then
                {
                    doGetOut (gunner _staticName);
                    moveOut (gunner _staticName);
                    wp0 = (group (gunner _staticName)) addwaypoint [(getPos _staticName), 500];
                    wp0 setwaypointtype "MOVE";
                }; 
            };
        }
        else
        {
            _loop = 0;
        };
        sleep 6.0;
    };
};

if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
{
    hint "Calling fnc_staticFleeWeapon.";
    sleep 1.0;
    _return = (_this select 0) call fnc_staticFleeWeapon;
}
else
{
    if(isServer) then
    {
        hint "Calling fnc_staticFleeWeapon.";
        sleep 1.0;
        _return = (_this select 0) call fnc_staticFleeWeapon;
    };
};