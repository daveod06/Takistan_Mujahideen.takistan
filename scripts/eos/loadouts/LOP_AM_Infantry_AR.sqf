// PKM
comment "Exported from Arsenal by SaberSnack";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeBackpack this;


comment "Add containers";
for "_i" from 1 to 2 do {this addItemToUniform "FirstAidKit";};
this addItemToUniform "rhs_mag_rgd5";
this addBackpack "rhs_sidor";
for "_i" from 1 to 2 do {this addItemToBackpack "rhs_100Rnd_762x54mmR";};

comment "Add weapons";
this addWeapon "rhs_weap_pkm";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";