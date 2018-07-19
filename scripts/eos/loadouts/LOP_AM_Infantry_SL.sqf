// Warlord
comment "Exported from Arsenal by SaberSnack";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeBackpack this;


comment "Add containers";
for "_i" from 1 to 2 do {this addItemToUniform "FirstAidKit";};
this addItemToUniform "rhs_mag_rdg2_white";
for "_i" from 1 to 6 do {this addItemToUniform "rhs_30Rnd_762x39mm";};

comment "Add weapons";
this addWeapon "rhs_weap_akm";
this addPrimaryWeaponItem "rhs_acc_dtkakm";
this addWeapon "Binocular";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "ItemRadio";