//if (!isServer) exitWith {};

_btr_convoy = [
"OKSVA_BRDM2",
"OKSVA_BTR60PB",
"OKSVA_BTR60PB",
"OKSVA_BTR60PB",
"OKSVA_BTR60PB",
"OKSVA_GAZ66_Ammo",
"OKSVA_GAZ66_R142",
"OKSVA_BRDM2UM_Armed"
];

_bmp_convoy = [
"OKSVA_BRDM2",
"OKSVA_BMP1K",
"OKSVA_BMP1",
"OKSVA_BMP1",
"OKSVA_BMP1",
"OKSVA_GAZ66_Ammo",
"OKSVA_GAZ66_R142",
"OKSVA_BRDM2UM_Armed"
];

_truck_convoy = [
"OKSVA_UAZ_Open",
"OKSVA_GAZ66",
"OKSVA_GAZ66",
"OKSVA_GAZ66",
"OKSVA_GAZ66",
"OKSVA_GAZ66",
"OKSVA_GAZ66",
"OKSVA_GAZ66_Ammo"
];

_bmd_convoy = [
"OKSVA_BRDM2",
"OKSVA_BMD1K",
"OKSVA_BMD1",
"OKSVA_BMD1",
"OKSVA_BMD1",
"OKSVA_BRDM2UM_Armed"
];

_tank_convoy = [
"OKSVA_BRDM2",
"OKSVA_T72B_1984",
"OKSVA_T72B_1984",
"OKSVA_T72B_1984",
"OKSVA_Ural_Fuel",
"OKSVA_GAZ66_Repair",
"OKSVA_BRDM2UM_Armed"
];

_armed_supply_convoy = [
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

_unarmed_supply_convoy = [
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

_small_supply_convoy = [
"OKSVA_UAZ",
"OKSVA_GAZ66_Ammo",
"OKSVA_GAZ66_Ammo",
"OKSVA_Ural_Fuel",
"OKSVA_Ural_Fuel"
];

_possible_convoys=[_btr_convoy,_bmd_convoy,_truck_convoy,_tank_convoy,_armed_supply_convoy,_unarmed_supply_convoy,_small_supply_convoy];
_pos_names = ["convoy_pos_"];
publicVariable vehCounterGlobal;
publicVariable convoyCounterGlobal;
vehCounterGlobal = 0;
convoyCounterGlobal = 0;
//private _vehCounterLocal = 0;
private _pos_prefix = objNull;
private _veh_name = objNull;
private _convoy_to_spawn = objNull;
private _pos_name = objNull;

fnc_spawnConvoy = {
    _convoy_to_spawn = selectRandom _possible_convoys;
    //_vehCounterLocal = 0;
    _pos_prefix = (_pos_names select 0);
    {
        //_vehCounterLocal = _vehCounterLocal + 1;
        _veh_name = "convoy_v_" + str vehCounterGlobal;
        _pos_name = _pos_prefix + str _forEachIndex ;//str _vehCounterLocal;
        //_veh_name = ["convoy_v_",toString [vehCounterGlobal]];
        //_pos_name = ["convoy_pos_",toString [_vehCounterLocal]];
        if((isNil _veh_name) && (!isNil _pos_name)) then // unit doesn't exist and marker does exist
        {
            _veh_name = _x createVehicle _pos_name;
            vehCounterGlobal = vehCounterGlobal + 1;
        }
        else
        {
            if(!isNil _veh_name) then
            {
                hint "Unit already exists!!!!";
            };
            sleep 1.0;
            if(isNil _pos_name) then
            {
                hint "Marker doesn't exist!!!!";
            };
        };
        sleep 0.2;
    }
    forEach _convoy_to_spawn;
    convoyCounterGlobal = convoyCounterGlobal + 1;
    publicVariable vehCounterGlobal;
    publicVariable convoyCounterGlobal;
};


if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
{
    call fnc_spawnConvoy;
}
else
{
    if(isServer) then
    {
        call fnc_spawnConvoy;
    };
};
