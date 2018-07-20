// [_staticGroupName] execVm "scripts\common\aiSetUpStatic.sqf"
//if (!isServer) exitWith {};
//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

fnc_aiSetUpStatic =
{
    private ["_group","_groupOk","_watchPos","_nearestEnemy","_assistant","_restofunits","_leader"];
    _group = _this select 0;

    _groupOk = [_group] call Saber_fnc_groupOk;
    _groupUnits = units _group;
    if (!_groupOk or (count _groupUnits < 3) or ()) exitWith {};

    _leader = leader _group;
    _restofunits = (units _group - [_leader]);
    _gunner = _restofunits select 0;
    _assistant = _restofunits select 1;

    _gunnerBackpack = unitBackpack _gunner;
    _assistantBackpack = unitBackpack _assistant;
    if ((isNull _gunnerBackpack) or (isNull _assistantBackpack)) exitWith {};
    units _group doFollow _leader;
    _group allowFleeing 0;
    
    _nearestEnemy = _leader findNearestEnemy (getPos _leader);
    if (isNull _nearestEnemy) then
    {
        _watchPos = getPos _nearestEnemy;
    }
    else
    {
        _watchPos = _leader getPos [700, random 360];
    };
    
    [_group, _leader getPos [5, random 360], _watchPos, _leader getPos [5, random 360]] call BIS_fnc_unpackStaticWeapon;
}

if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
{
    //hint "Calling fnc_aiSetUpStatic.";
    //sleep 1.0;
    _return = _this call fnc_aiSetUpStatic;
}
else
{
    if(isServer) then
    {
        //hint "Calling fnc_aiSetUpStatic.";
        //sleep 1.0;
        _return = _this call fnc_aiSetUpStatic;
    };
};
