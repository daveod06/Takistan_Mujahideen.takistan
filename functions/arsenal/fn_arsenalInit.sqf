private [
	// [OBJECT] The ammo box that will be initialized
	// with the Arsenal
	"_container"
];

// Read the first parameter into the container var,
// checking for null
_container = [_this, 0] call BIS_fnc_param;

// Clear all items from box
clearItemCargoGlobal _container;
clearWeaponCargoGlobal _container;
clearMagazineCargoGlobal _container;
clearBackpackCargo _container;

// Initialize the Arsenal content with no items
["AmmoboxInit", [_container, false]] spawn BIS_fnc_arsenal;

// Enable these backpacks in the Arsenal
[_container,[
	"rhs_sidor",
	"rhs_rpg_empty",
	"RD_54_69_R148"
],true] call BIS_fnc_addVirtualBackpackCargo;

// Enable these weapons in the Arsenal
[this,[
	"rhs_weap_ak74",
	"rhs_weap_ak74_gp25",
	"rhs_weap_makarov_pm",
	"hlc_rifle_rpk74n",
	"rhs_weap_pkm",
	"rhs_weap_svdp",
	"rhs_weap_rpg7",
	"rhs_weap_igla",
	"rhs_weap_rpg26",
	"rhs_weap_aks74",
	"rhs_weap_aks74_gp25",
	"rhs_weap_aks74u"
],true] call BIS_fnc_addVirtualWeaponCargo;

// Enable these magazines and throwables in the Arsenal
[this,[
	"rhs_30Rnd_545x39_AK",
	"rhs_VOG25",
	"rhs_VG40OP_white",
	"rhs_mag_9x18_8_57N181S",
	"hlc_30Rnd_545x39_B_AK",
	"hlc_45Rnd_545x39_m_rpk",
	"rhs_100Rnd_762x54mmR",
	"rhs_100Rnd_762x54mmR_green",
	"rhs_10Rnd_762x54mmR_7N1",
	"rhs_rpg7_PG7VL_mag",
	"rhs_mag_9k38_rocket",
	"rhs_rpg26_mag",
	"rhs_30Rnd_545x39_AK_green",
	"rhs_45Rnd_545X39_AK",
	"rhs_45Rnd_545X39_AK_Green",
	"hlc_60Rnd_545x39_t_rpk",
	"rhs_mag_rgd5",
	"rhs_mag_rdg2_white",
	"rhs_mag_rdg2_black"
],true] call BIS_fnc_addVirtualMagazineCargo;

// Enable these items in the Arsenal
[this,[
	"rhs_acc_dtk1983",
	"rhs_acc_pso1m21",
	"rhs_acc_pgo7v",
	"rhs_acc_pgs64_74u",
	"rhs_6b5_khaki",
	"rhs_6b5_rifleman_khaki",
	"rhs_6b5_officer_khaki",
	"rhs_6b5_sniper_khaki",
	"rhs_6b5_medic_khaki",
	"6B3_RHS",
	"6B3_RHS_RF",
	"6B3_RHS_OF",
	"6B3_RHS_GP",
	"rhs_6sh46",
	"rhs_fieldcap_khk",
	"panama_afg2",
	"ssh68_net",
	"ssh68_khaki",
	"ssh68_camo_yel",
	"rhs_tsh4",
	"Medikit",
	"MineDetector",
	"ItemWatch",
	"ItemCompass",
	"ItemMap",
	"ItemRadio",
	"Binocular",
	"acc_flashlight",
	"ToolKit",
	"FirstAidKit",
	"Afghanka_M88",
	"Butan_M88",
	"Butan_M88_vdv"
],true] call BIS_fnc_addVirtualItemCargo;

// Return true
true;