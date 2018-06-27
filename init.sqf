//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

sleep 4.0;
[] execVM "Convoy\ConvoyInit.sqf";
[] execVM "Airmobile\AirmobileInit.sqf";
sleep 1.0;

if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
{
    //hint "Calling Saber_fnc_ConvoySpawnVehicles.";
    //[] spawn Saber_fnc_ConvoySpawnVehicles;
    hint "Calling Saber_fnc_AirmobileMaster.";
    [] spawn Saber_fnc_AirmobileMaster;
}
else
{
    if(isServer) then
    {
        //hint "Calling Saber_fnc_ConvoySpawnVehicles.";
        //[] spawn Saber_fnc_ConvoySpawnVehicles;
        hint "Calling Saber_fnc_AirmobileMaster.";
        [] spawn Saber_fnc_AirmobileMaster;
    };
};

//if (isServer) then 
//{
//	_handle = [["convoy_route_0","convoy_route_1","convoy_route_2","convoy_route_3","convoy_route_4"],[v_1,v_2,v_3], 35, 500, 1, "NORMAL", "CARELESS"] spawn Saber_fnc_ConvoyMove; 
//};