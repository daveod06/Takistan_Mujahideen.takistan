// AKS-74
comment "Exported from Arsenal by SaberSnack";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeBackpack this;


comment "Add containers";
for "_i" from 1 to 2 do {this addItemToUniform "FirstAidKit";};
this addItemToUniform "rhs_mag_rgd5";
for "_i" from 1 to 6 do {this addItemToUniform "rhs_30Rnd_545x39_AK";};

comment "Add weapons";
this addWeapon "rhs_weap_aks74";
this addPrimaryWeaponItem "rhs_acc_dtk1983";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";