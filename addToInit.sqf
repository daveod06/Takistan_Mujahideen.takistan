// define function to spawn units
_spawnUnits = {
    //regular spawn method
    [] execVM "spawn_viaScript.sqf";
    [] execVM "spawn_EditorPlaced.sqf";
    
    //DAC spawning
    [] execVM "DAC\DAC_Config_Creator.sqf";
    [] execVM "spawn_viaDAC.sqf";
    True
};

//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

//spawn untis on HC1 if present
if(HC1Present && isMultiplayer) then
{
    if(!isServer && !hasInterface) then
    {
        [] call _spawnUnits;
    };
    //else
    //{
    //    // throw error
    //};
}
//otherwise spawn units on the server
else
{
    if(isServer) then
    {
        [] call _spawnUnits;
    };
};






if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
{
    _random_enemy   = [_Enemy_Eval, _vehicle] call Saber_fnc_ConvoyEnemy;
}
else
{
    if(isServer) then
    {
        _random_enemy    = [_Enemy_Eval, _vehicle] call Saber_fnc_ConvoyEnemy;
    };
};

