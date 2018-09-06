_faction=(_this select 0);

// PROJECT OPFOR MIDDLE EASTERN CIVILIANS
if (_faction==0) then
{
	_units = [
    "LOP_TAK_Civ_UAZ",
    "LOP_TAK_Civ_Landrover",
    "LOP_TAK_Civ_UAZ_open",
    "LOP_TAK_Civ_Ural",
    "LOP_TAK_Civ_Ural_open"
    ];
};

// CUP TAK CIVILIANS
if (_faction==1) then
{
	_units = [
    "CUP_C_S1203_CIV",
    "CUP_C_S1203_Ambulance_CIV",
    "CUP_C_Lada_GreenTK_CIV",
    "CUP_C_Lada_TK2_CIV",
    "CUP_C_V3S_Open_TKC",
    "CUP_C_V3S_Covered_TKC",
    "CUP_C_UAZ_Unarmed_TK_CIV",
    "CUP_C_Datsun",
    "CUP_C_Volha_Blue_TKCIV",
    "CUP_C_Volha_Gray_TKCIV",
    "CUP_C_Volha_Limo_TKCIV"
    ];
};

// 
if (_faction==2) then
{
	_units = [];
};

_units
