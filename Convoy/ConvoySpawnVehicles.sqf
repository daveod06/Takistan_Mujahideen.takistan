//if (!isServer) exitWith {};
//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};



//{ _x setmarkerAlpha 0; } forEach _convoy_route;
//{ _x setmarkerAlpha 0; } forEach _convoy_spawn_points;

fnc_spawnConvoy = {
    private _convoy_route = _this select 0;
    private _convoy_spawn_points = _this select 1;
    private _convoy_side = _this select 2;
    private _enemy_side = _this select 3;
    private _pos_name_prefix = _this select 4;
    private _convoy_type = _this select 5;
    
    { _x setmarkerAlpha 0; } forEach _convoy_route;
    { _x setmarkerAlpha 0; } forEach _convoy_spawn_points;
    vehCounterGlobal = 0;
    convoyCounterGlobal = 0;
    private _pos_prefix = "";
    private _veh_name = "";
    private _convoy_to_spawn = [];
    private _pos_name = "";
    private _spawned_vehicles = [];
    private _marker_color = "";
    publicVariable "vehCounterGlobal";
    publicVariable "convoyCounterGlobal";

    _convoy_to_spawn = _convoy_type;
    _spawned_vehicles = [];
    _EastHQ = createCenter _convoy_side;
    _IndHQ = createCenter _enemy_side;
    {
        _pos_name = _pos_name_prefix + str _forEachIndex ;//str _vehCounterLocal;
        //sleep 2.0;
        //hint (str _veh_name);
        //sleep 2.0;
        //hint (str _pos_name);
        _marker_color = getMarkerColor _pos_name;
        if(_marker_color != "") then // unit doesn't exist and marker does exist
        {
            _vecarray =[getMarkerPos _pos_name, markerDir _pos_name, _x, _convoy_side] call bis_fnc_spawnvehicle;
            _veh_name = _vecarray select 0;
            vehCounterGlobal = vehCounterGlobal + 1;
            _spawned_vehicles pushBack _veh_name;
        }
        else
        {
            sleep 1.0;
            if(_marker_color != "") then
            {
                hint "Marker doesn't exist!!!!";
            };
        };
        sleep 0.5;
    }
    forEach _convoy_to_spawn;
    convoyCounterGlobal = convoyCounterGlobal + 1;
    publicVariable "vehCounterGlobal";
    publicVariable "convoyCounterGlobal";
    
    _spawned_vehicles;
};

if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
{
    hint "Calling fnc_spawnConvoy.";
    sleep 1.0;
    _vehicles = [_this] call fnc_spawnConvoy;
}
else
{
    if(isServer) then
    {
        hint "Calling fnc_spawnConvoy.";
        sleep 1.0;
        _vehicles = [_this] call fnc_spawnConvoy;
    };
};
