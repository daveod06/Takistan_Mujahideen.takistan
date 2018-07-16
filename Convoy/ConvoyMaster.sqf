//if (!isServer) exitWith {};
//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

fnc_ConvoyMaster =
{
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

    private _possible_convoys=[_btr_convoy,_truck_convoy,_armed_supply_convoy,_unarmed_supply_convoy,_small_supply_convoy];
    
    private _convoy_route = ["convoy_route_0","convoy_route_1","convoy_route_2","convoy_route_3"];
    private _convoy_spawn_points = ["convoy_pos_0","convoy_pos_1","convoy_pos_2","convoy_pos_3","convoy_pos_4","convoy_pos_5","convoy_pos_6","convoy_pos_7","convoy_pos_8"];
    private _convoy_side = east;
    private _enemy_side = resistance;
    private _pos_name_prefix = "convoy_pos_";
    private _convoy_type = selectRandom _possible_convoys;
    private _speed_kph = 55;
    private _threat_radius_m = 400;
    private _convoy_id = 1;
    private _speed_str = "NORMAL";
    private _behavior = "CARELESS";

    hint "Calling Saber_fnc_ConvoySpawnVehicles.";
    sleep 1.0;
    _vehicles = [_convoy_route,_convoy_spawn_points,_convoy_side,_enemy_side,_pos_name_prefix,_convoy_type] call Saber_fnc_ConvoySpawnVehicles;
    
    hint "Calling Saber_fnc_ConvoyMove.";
    sleep 1.0;
    _handle = [_convoy_route,_vehicles select 0, _speed_kph, _threat_radius_m, _vehicles select 1, _speed_str, _behavior] spawn Saber_fnc_ConvoyMove;

};

if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
{
    _go = [] spawn fnc_ConvoyMaster;
}
else
{
    if(isServer) then
    {
        _go = [] spawn fnc_ConvoyMaster;
    };
};
