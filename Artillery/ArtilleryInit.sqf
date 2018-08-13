// ConvoyInit.sqf
// v.2.5 MARCH 2016 - Devastator_cm

RydFFE_NoControl = []; // each arty group (battery) held inside this array will be excluded from FAW control
RydFFE_ArtyShells = 7; // positive integer. Multiplier of default magazines loadout per kind per each artillery piece
//RydFFE_Interval = 30; // time gap (in seconds) between each “seek for targets cycle (each cycle each not busy battery on map looks for new fire mission opportunity)
RydFFE_Debug = true; // if set as true, will be shown map markers that allows user to watch, what is going on. See DEBUG MARKERS chapter for details;
RydFFE_ShellView = true;
RydFFE_FOClass = [
"OKSVA_Spotter_MSV",
"OKSVA_Senior_Technician_MSV",
"OKSVA_Senior_Officer_MSV",
"OKSVA_Officer_MSV",
"OKSVA_Junior_Officer_MSV",
"OKSVA_Officer_VDV",
"OKSVA_Senior_Officer_VDV",
"OKSVA_Junior_Officer_VDV",
"OKSVA_Senior_Technician_VDV",
"OKSVA_Officer_Spetsnaz",
"OKSVA_Rifleman_Spetsnaz",
"OKSVA_Rifleman_Spetsnaz_AKS74U",
"OKSVA_Rifleman_GP_25_Spetsnaz",
"OKSVA_Machine_Gunner_RPK_74_Spetsnaz",
"OKSVA_Grenadier_RPG_7V_Spetsnaz",
"OKSVA_Grenadier_Assistant_RPG_7V_Spetsnaz",
"OKSVA_AT_Operator_RPG_26_Spetsnaz",
"OKSVA_Machine_Gunner_PKM_Spetsnaz",
"OKSVA_Machine_Gunner_Assistant_PKM_Spetsnaz",
"OKSVA_Marksman_Spetsnaz",
"OKSVA_Engineer_Spetsnaz",
"OKSVA_Medic_Spetsnaz"
]; // if this array is set as not empty (even with objNull), limited spotting modebecomes active, so only members of groups, which names are inside this array or whichleaders are of proper class (see below), will have ability of spotting targets for batteries.
//RydFFE_FO = [objNull];
RydFFE_Amount = 3; // this holds number of shells, that in summary should be fired in each fire mission. CLUSTER and GUIDED salvo amount is always divided by 3 (rounded up);
RydFFE_Acc = 2; // multiplier of whole salvo drift radius. The bigger value, the bigger radius;
RydFFE_Safe = 60; // salvo will be not planned for coordinates located within this radius (in meters) around any allied group leader;
RydFFE_Monogamy = false; // by default each enemy group can be a target for only one battery at the time. If set to false, there is no such limitation, so one target can be shelled by any number of batteries at the time;
RydFFE_Add_SPMortar = []; // here you can list classnames of custom SP mortar units, that should be controlled by ;
RydFFE_Add_Mortar = ["OKSVA_2B14"]; // here you can list classnames of custom mortar units, that should be controlled by ;
RydFFE_Add_Rocket = ["oksva_bm21"]; // here you can list classnames of custom rocket artillery units, that should be controlled by ;
RydFFE_Add_Other = []; // here you can list classnames of other custom artillery units (lowercase only!), that should be controlled by , if are using custom magazines (classes added here shouldn't be added to any other array). Format:
//RydFFE_Add_Other =
//[
//[["rds_d30_fia","rds_d30_aaf","rds_d30_csat"],["RDS_30Rnd_122mmHE_D30
//","RDS_30Rnd_122mmWP_D30","RDS_30Rnd_122mmLASER_D30","RDS_30Rnd_122mm
//SMOKE_D30","RDS_30Rnd_122mmILLUM_D30"]],
//[["rds_m119_aaf"],["RDS_30Rnd_105mmHE_M119","RDS_30Rnd_105mmWP_M119",
//"RDS_30Rnd_105mmLASER_M119","RDS_30Rnd_105mmSMOKE_M119","RDS_30Rnd_10
//5mmILLUM_M119"]]
//];

//RydFFE_Add_Other =
//[
//[["oksva_bm21"],["rhs_mag_40Rnd_122mm_rockets"]]
//];

[] call compile preprocessFile "scripts\common\CommonInit.sqf";
Saber_fnc_Artillery          = Compile preprocessFileLineNumbers "Artillery\ArtilleryMaster.sqf";

[] call compile preprocessFile "Artillery\FFE_fnc.sqf";
FFE_fnc_Shellview = compile preprocessFile "Artillery\Shellview.sqf";
FFE_fnc_Master = compile preprocessFile "Artillery\FFEMaster.sqf";

if (true) then {hint "ARTY INIT DONE!!!!!!!!!!!";};