_player = player;
//_player = _this select 0;
//_loadout = _player getVariable "respawnLoadout";
//if (!isNil "_loadout") then {
//	_player setUnitLoadout _loadout;
//	/*
//	if (count (_player getVariable "respawnPWeapon") > 0) then {
//		if (count (primaryWeapon _player) == 0) then {		
//			_player addWeapon ((_player getVariable "respawnPWeapon") select 0);
//			{
//				[_player, _x] call addWeaponItemEverywhere;
//			} forEach ((_player getVariable "respawnPWeapon") select 1);		
//		};
//	};
//	*/
//};

removeAllWeapons _player;
removeAllItems _player;
removeAllAssignedItems _player;
_player addItemToUniform "FirstAidKit";
for "_i" from 1 to 8 do {_player addItemToUniform "rhsgref_5Rnd_762x54_m38";};

_player addWeapon "rhs_weap_m38";

_player linkItem "ItemMap";
_player linkItem "ItemCompass";
_player linkItem "ItemWatch";

if (!isNil "respawnTime") then {
	setplayerRespawnTime respawnTime;	
};
//_handler = (_this select 0) addEventHandler ["HandleDamage", rev_handleDamage];
deleteVehicle (_this select 1);
	

