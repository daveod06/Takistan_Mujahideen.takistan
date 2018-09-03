_faction = _this select 0;

_message = format ["WaveGetUnitPools faction input: %1\n _faction isEqualTo SovietArmy_OKSVA: %2 %3",_faction,(_faction isEqualTo "SovietArmy_OKSVA"),(_faction == "SovietArmy_OKSVA")];
if Saber_DEBUG then {hint _message; sleep 5.0;};

_squadArray = [];
_hqArray = [];
_lightVehiclesArray = [];
_apcsArray = [];
_armorArray = [];
_attackHeliArray = [];
_cargoHeliArray = [];
_boatArray = [];

_message = format ["GetUnitPools before selection: %1 %2 %3 %4",[_hqArray,_squadArray],_lightVehiclesArray,_apcsArray,_armorArray];
if Saber_DEBUG then {hint _message; sleep 3.0;};

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
    private _attackHeliArray = [
    ];
    private _cargoHeliArray = [
    ];
    private _boatArray = [
    ];
};

if (_faction isEqualTo "LOP_AM") then
{
    _squadArray = [
    ["Infantry","LOP_AM_Rifle_Squad"]
    ];
    _hqArray = [
    ["Infantry","LOP_AM_Support_section"],
    ["Infantry","LOP_AM_AT_section"]
    ];
    private _lightVehiclesArray = [
    LOP_AM_Nissan_PKM",
    "LOP_AM_UAZ_DshKM",
    "LOP_AM_UAZ_Open",
    "LOP_AM_UAZ_SPG"
    ];
    private _apcsArray = [
    ];
    private _armorArray = [
    ];
    private _attackHeliArray = [
    ];
    private _cargoHeliArray = [
    ];
    private _boatArray = [
    ];
};

if (_faction isEqualTo "FIXME") then
{
    _squadArray = [
    ["Infantry","LOP_AM_Rifle_Squad"]
    ];
    _hqArray = [
    ["Infantry","LOP_AM_Support_section"],
    ["Infantry","LOP_AM_AT_section"]
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
    private _attackHeliArray = [
    "",
    ""
    ];
    private _cargoHeliArray = [
    "",
    ""
    ];
    private _boatArray = [
    "",
    ""
    ];
};

_message = format ["GetUnitPools output: %1 %2 %3 %4",[_hqArray,_squadArray],_lightVehiclesArray,_apcsArray,_armorArray];
if Saber_DEBUG then {hint _message; sleep 5.0;};

_output = [[_hqArray,_squadArray],_lightVehiclesArray,_apcsArray,_armorArray,_attackHeliArray,_cargoHeliArray,_boatArray];
_output
