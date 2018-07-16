comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;

this addItemToUniform "FirstAidKit";
for "_i" from 1 to 6 do {this addItemToUniform "rhsgref_5Rnd_762x54_m38";};


comment "Add weapons";
this addWeapon "rhs_weap_m38";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";

