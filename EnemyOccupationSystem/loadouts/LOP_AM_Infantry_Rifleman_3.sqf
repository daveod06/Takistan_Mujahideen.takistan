// LEE-ENFIELD
comment "Exported from Arsenal by SaberSnack";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeBackpack this;


comment "Add containers";
for "_i" from 1 to 2 do {this addItemToUniform "FirstAidKit";};
this addItemToUniform "rhs_mag_rgd5";
for "_i" from 1 to 10 do {this addItemToUniform "rhsgref_5Rnd_792x57_kar98k";};

comment "Add weapons";
this addWeapon "rhs_weap_kar98k";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";


