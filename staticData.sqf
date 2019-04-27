if (!isServer) exitWith {};
 
waitUntil {!isNil "ALiVE_STATIC_DATA_LOADED"};

[ALIVE_factionDefaultTransport, "SovietArmy_OKSVA", ["OKSVA_GAZ66","OKSVA_GAZ66_Open","OKSVA_Ural","OKSVA_Ural_Open"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "SovietArmy_OKSVA", ["OKSVA_MI8MT","OKSVA_Mi8MTV3"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "SovietArmy_OKSVA", ["Soviet_Ammmo_70s_80s","Soviet_Basic_Weapons_70s_80s","Soviet_Special_Weapons_70s_80s","Soviet_Launchers_70s_80s","Soviet_Equipment_70s_80s"]] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultTransport, "LOP_TKA", ["LOP_TKA_Ural","LOP_TKA_Ural_open"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultAirTransport, "LOP_TKA", ["LOP_TKA_Mi8MT_Cargo"]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultSupplies, "LOP_TKA", ["Soviet_Ammo_50s_60s","Soviet_Basic_Weapons_50s_60s","Soviet_Special_Weapons_50s_60s","Soviet_Launchers_50s_60s"]] call ALIVE_fnc_hashSet;

ALiVE_PLACEMENT_CUSTOM_UNITBLACKLIST = ["LOP_TKA_Infantry_Pilot","OKSVA_Helicopter_Pilot_FA","OKSVA_Pilot_VVS","OKSVA_Fighter_Pilot_VVS","OKSVA_Aircrew_VVS","OKSVA_Aircrew_armored_FA","OKSVA_Helicopter_Pilot_armored_FA","OKSVA_Aircrew_FA"];
ALiVE_MIL_CQB_CUSTOM_UNITBLACKLIST = ALiVE_PLACEMENT_CUSTOM_UNITBLACKLIST;
ALIVE_autoGeneratedTasks = ["MilAssault","MilDefence","CivAssault","Assassination","DestroyVehicles","DestroyInfantry","SabotageBuilding","InsurgencyPatrol","InsurgencyDestroyAssets","Rescue"];
