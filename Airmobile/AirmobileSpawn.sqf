// spawn n helicopters with crew
// group helicopters
// spawn n squads
// group squads
// try to put squads in helicopter cargo depending on size of each helicopter cargo, delete extra troops




//if (!isServer) exitWith {};
//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

private _btr_convoy = [
"OKSVA_BRDM2",
"OKSVA_BTR60PB",
"OKSVA_BTR60PB",
"OKSVA_BTR60PB",
"OKSVA_BTR60PB",
"OKSVA_GAZ66_Ammo",
"OKSVA_GAZ66_R142",
"OKSVA_BRDM2UM_Armed"
];

private _bmp_convoy = [
"OKSVA_BRDM2",
"OKSVA_BMP1K",
"OKSVA_BMP1",
"OKSVA_BMP1",
"OKSVA_BMP1",
"OKSVA_GAZ66_Ammo",
"OKSVA_GAZ66_R142",
"OKSVA_BRDM2UM_Armed"
];

private _truck_convoy = [
"OKSVA_UAZ_Open",
"OKSVA_GAZ66",
"OKSVA_GAZ66",
"OKSVA_GAZ66",
"OKSVA_GAZ66",
"OKSVA_GAZ66",
"OKSVA_GAZ66",
"OKSVA_GAZ66_Ammo"
];

private _bmd_convoy = [
"OKSVA_BRDM2",
"OKSVA_BMD1K",
"OKSVA_BMD1",
"OKSVA_BMD1",
"OKSVA_BMD1",
"OKSVA_BRDM2UM_Armed"
];

private _tank_convoy = [
"OKSVA_BRDM2",
"OKSVA_T72B_1984",
"OKSVA_T72B_1984",
"OKSVA_T72B_1984",
"OKSVA_Ural_Fuel",
"OKSVA_GAZ66_Repair",
"OKSVA_BRDM2UM_Armed"
];

private _armed_supply_convoy = [
"OKSVA_BRDM2",
"OKSVA_GAZ66_ZU23",
"OKSVA_GAZ66_Ammo",
"OKSVA_GAZ66_Ammo",
"OKSVA_GAZ66_Ammo",
"OKSVA_Ural_Fuel",
"OKSVA_Ural_Fuel",
"OKSVA_Ural_Fuel",
"OKSVA_BRDM2"
];

private _unarmed_supply_convoy = [
"OKSVA_UAZ",
"OKSVA_GAZ66",
"OKSVA_GAZ66_Ammo",
"OKSVA_GAZ66_Ammo",
"OKSVA_GAZ66_Ammo",
"OKSVA_Ural_Fuel",
"OKSVA_Ural_Fuel",
"OKSVA_Ural_Fuel",
"OKSVA_GAZ66"
];

private _small_supply_convoy = [
"OKSVA_UAZ",
"OKSVA_GAZ66_Ammo",
"OKSVA_GAZ66_Ammo",
"OKSVA_Ural_Fuel",
"OKSVA_Ural_Fuel"
];



private _convoy_route = ["convoy_route_0","convoy_route_1","convoy_route_2","convoy_route_3","convoy_route_4"];
private _convoy_spawn_points = ["convoy_pos_0","convoy_pos_1","convoy_pos_2","convoy_pos_3","convoy_pos_4","convoy_pos_5","convoy_pos_6","convoy_pos_7","convoy_pos_8"];
private _convoy_side = east;
private _enemy_side = resistance;

_possible_convoys=[_btr_convoy,_bmd_convoy,_truck_convoy,_tank_convoy,_armed_supply_convoy,_unarmed_supply_convoy,_small_supply_convoy];
_pos_names = ["convoy_pos_"];
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


{ _x setmarkerAlpha 0; } forEach _convoy_route;
{ _x setmarkerAlpha 0; } forEach _convoy_spawn_points;

fnc_spawnConvoy = {
    _convoy_to_spawn = selectRandom _possible_convoys;
    _spawned_vehicles = [];
    _pos_prefix = (_pos_names select 0);
    _EastHQ = createCenter _convoy_side;
    _IndHQ = createCenter _enemy_side;
    {
        _pos_name = _pos_prefix + str _forEachIndex ;//str _vehCounterLocal;
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
    _vehicles = call fnc_spawnConvoy;
    _handle = [_convoy_route,_vehicles, 55, 400, 1, "NORMAL", "CARELESS"] spawn Saber_fnc_ConvoyMove;
}
else
{
    if(isServer) then
    {
        hint "Calling fnc_spawnConvoy.";
        sleep 1.0;
        _vehicles = call fnc_spawnConvoy;
        _handle = [_convoy_route,_vehicles, 55, 400, 1, "NORMAL", "CARELESS"] spawn Saber_fnc_ConvoyMove;
    };
};
