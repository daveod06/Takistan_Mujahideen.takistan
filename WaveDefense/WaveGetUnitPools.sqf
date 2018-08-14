// spawn n helicopters with crew
// group helicopters
// spawn n squads
// group squads
// try to put squads in helicopter cargo depending on size of each helicopter cargo, delete extra troops


_faction = _this select 0;

//_message = format ["GetUnitPools faction input: %1\n _faction isEqualTo SovietArmy_OKSVA: %2 %3",_faction,(_faction isEqualTo "SovietArmy_OKSVA"),(_faction == "SovietArmy_OKSVA")];
//if Saber_DEBUG then {hint _message; sleep 5.0;};

_squadArray = [];
_hqArray = [];
_lightVehiclesArray = [];
_apcsArray = [];
_armorArray = [];

if (_faction isEqualTo "SovietArmy_OKSVA") then
{
    _squadArray = [
    ["Infantry","SovietArmy_OKSVA_infantry_rifle_squad"],
    ["Infantry","SovietArmy_OKSVA_infantry_rifle_squad_gp_25"],
    ["Infantry","SovietArmy_OKSVA_infantry_rifle_squad_svd"],
    ["Infantry","SovietArmy_OKSVA_infantry_machine_gun_squad"],
    ["Infantry","SovietArmy_OKSVA_infantry_anti_tank_squad_rpg_26"]
    ];
    _hqArray = [
    ["Infantry","SovietArmy_OKSVA_infantry_platoon_hq_section"]
    ];
    _lightVehiclesArray = [
    "OKSVA_UAZ",
    "OKSVA_UAZ_Open",
    "OKSVA_GAZ66",
    "OKSVA_GAZ66_Open",
    "OKSVA_Ural",
    "OKSVA_Ural_Open"
    ];
    _apcsArray = [
    "OKSVA_BMP1",
    "OKSVA_BMP1K",
    "OKSVA_BMP2",
    "OKSVA_BMP2K",
    "OKSVA_BTR60PB",
    "OKSVA_BTR70",
    "OKSVA_BTR80"
    ];
    _armorArray = [
    "OKSVA_ZSU23_4",
    "OKSVA_T72B_1984",
    "OKSVA_T72B_1985",
    "OKSVA_T72B_1989",
    "OKSVA_T80"
    ];
};

if (_faction isEqualTo "INSERT_FACTIOB_HERE") then
{
    private _squadArray = [
    ["Infantry",""],
    ["Infantry",""]
    ];
    private _hqArray = [
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

//_message = format ["GetUnitPools output: %1 HQs ",[[_hqArray,_squadArray],_lightVehiclesArray,_apcsArray,_armorArray]];
//if Saber_DEBUG then {hint _message; sleep 3.0;};

[[_hqArray,_squadArray],_lightVehiclesArray,_apcsArray,_armorArray]

