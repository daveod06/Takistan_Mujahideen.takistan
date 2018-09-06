_faction=(_this select 0);

// MIDDLE EASTERN CIVILIANS
if (_faction==0) then
{
	_units = [
    "LOP_Tak_Civ_Man_06",
    "LOP_Tak_Civ_Man_08",
    "LOP_Tak_Civ_Man_07",
    "LOP_Tak_Civ_Man_05",
    "LOP_Tak_Civ_Man_01",
    "LOP_Tak_Civ_Man_10",
    "LOP_Tak_Civ_Man_02",
    "LOP_Tak_Civ_Man_09",
    "LOP_Tak_Civ_Man_11",
    "LOP_Tak_Civ_Man_12",
    "LOP_Tak_Civ_Man_04",
    "LOP_Tak_Civ_Man_14",
    "LOP_Tak_Civ_Man_13",
    "LOP_Tak_Civ_Man_16",
    "LOP_Tak_Civ_Man_15",
    "LOP_Tak_Civ_Random"
    ];
};

// CUP TAK CIVILIANS
if (_faction==1) then
{
	_units = [
    "CUP_C_TK_Man_04",
    "CUP_C_TK_Man_04_Jack",
    "CUP_C_TK_Man_04_Waist",
    "CUP_C_TK_Man_07",
    "CUP_C_TK_Man_07_Coat",
    "CUP_C_TK_Man_07_Waist",
    "CUP_C_TK_Man_08",
    "CUP_C_TK_Man_08_Jack",
    "CUP_C_TK_Man_08_Waist",
    "CUP_C_TK_Man_05_Coat",
    "CUP_C_TK_Man_05_Jack",
    "CUP_C_TK_Man_05_Waist",
    "CUP_C_TK_Man_06_Coat",
    "CUP_C_TK_Man_06_Jack",
    "CUP_C_TK_Man_06_Waist",
    "CUP_C_TK_Man_02",
    "CUP_C_TK_Man_02_Jack",
    "CUP_C_TK_Man_01_Coat",
    "CUP_C_TK_Man_01_Jack",
    "CUP_C_TK_Man_03_Coat",
    "CUP_C_TK_Man_03_Jack",
    "CUP_C_TK_Man_03_Waist"
    ];
};

// 
if (_faction==2) then
{
	_units = [];
};

_units
