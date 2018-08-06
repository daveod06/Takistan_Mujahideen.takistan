// RPG-7
comment "Exported from Arsenal by SaberSnack";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeBackpack this;


comment "Add containers";
for "_i" from 1 to 2 do {this addItemToUniform "FirstAidKit";};
for "_i" from 1 to 5 do {this addItemToUniform "rhs_mag_9x18_8_57N181S";};
this addItemToUniform "rhs_mag_rgd5";
this addBackpack "rhs_rpg_empty";
for "_i" from 1 to 2 do {this addItemToBackpack "rhs_rpg7_PG7V_mag";};

comment "Add weapons";
this addWeapon "rhs_weap_makarov_pm";
this addWeapon "rhs_weap_rpg7";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";