// spawn n helicopters with crew
// group helicopters
// spawn n squads
// group squads
// try to put squads in helicopter cargo depending on size of each helicopter cargo, delete extra troops


_faction = _this select 0;


if (_faction isEqualTo "SovietArmy_OKSVA") then
{
    private _squadArray = [
    ["Infantry","SovietArmy_OKSVA_infantry_rifle_squad"],
    ["Infantry","SovietArmy_OKSVA_infantry_rifle_squad_gp_25"],
    ["Infantry","SovietArmy_OKSVA_infantry_rifle_squad_svd"],
    ["Infantry","SovietArmy_OKSVA_infantry_machine_gun_squad"],
    ["Infantry","SovietArmy_OKSVA_infantry_anti_tank_squad_rpg_26"]
    ];
    private hqArray = [
    ["Infantry","SovietArmy_OKSVA_infantry_platoon_hq_section"]
    ];
    private _lightVehiclesArray = [
    "OKSVA_UAZ",
    "OKSVA_UAZ_Open",
    "OKSVA_GAZ66",
    "OKSVA_GAZ66_Open",
    "OKSVA_Ural",
    "OKSVA_Ural_Open"
    ];
    private _apcsArray = [
    "OKSVA_BMP1",
    "OKSVA_BMP1K",
    "OKSVA_BMP2",
    "OKSVA_BMP2K",
    "OKSVA_BTR60PB",
    "OKSVA_BTR70",
    "OKSVA_BTR80"
    ];
    private _armorArray = [
    "OKSVA_ZSU23_4",
    "OKSVA_T72B_1984",
    "OKSVA_T72B_1985",
    "OKSVA_T72B_1989",
    "OKSVA_T80"
    ];
};

if (_faction isEqualTo "SovietArmy_OKSVA") then
{
    private _squadArray = [
    ["Infantry",""],
    ["Infantry",""]
    ];
    private hqArray = [
    ["Infantry",""],
    ["Infantry",""]
    ];
    private _lightVehiclesArray = [
    "",
    ""
    ];
    private _apcsArray = [
    "",
    ""
    ];
    private _armorArray = [
    "",
    ""
    ];
};

[[_hqArray,_squadArray],_lightVehiclesArray,_apcsArray,_armorArray]
