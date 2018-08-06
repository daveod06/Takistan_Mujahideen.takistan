// AKS-74U
comment "Exported from Arsenal by SaberSnack";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeBackpack this;


comment "Add containers";
for "_i" from 1 to 2 do {this addItemToUniform "FirstAidKit";};
this addItemToUniform "rhs_mag_rgd5";
for "_i" from 1 to 2 do {this addItemToUniform "hlc_75Rnd_762x39_m_rpk";};

comment "Add weapons";
this addWeapon "hlc_rifle_rpk";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";