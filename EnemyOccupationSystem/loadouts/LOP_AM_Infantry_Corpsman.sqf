// MEDIC
comment "Exported from Arsenal by SaberSnack";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeBackpack this;


comment "Add containers";
for "_i" from 1 to 2 do {this addItemToUniform "FirstAidKit";};
this addItemToUniform "rhs_mag_rgd5";
for "_i" from 1 to 8 do {this addItemToUniform "rhsgref_5Rnd_762x54_m38";};
this addBackpack "rhs_sidor";
this addItemToBackpack "Medikit";
for "_i" from 1 to 4 do {this addItemToBackpack "FirstAidKit";};

comment "Add weapons";
this addWeapon "rhs_weap_m38";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";
