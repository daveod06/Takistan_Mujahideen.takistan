// SVD
comment "Exported from Arsenal by SaberSnack";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeBackpack this;


comment "Add containers";
for "_i" from 1 to 2 do {this addItemToUniform "FirstAidKit";};
this addItemToUniform "rhs_mag_rgd5";
for "_i" from 1 to 7 do {this addItemToUniform "rhs_10Rnd_762x54mmR_7N1";};

comment "Add weapons";
this addWeapon "rhs_weap_svdp";
this addPrimaryWeaponItem "rhs_acc_pso1m2";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";