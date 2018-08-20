if !(isServer) exitWith {};
_player = _this select 0;
//_player = player;



// if this doesn't work, un-comment zeus code in initserver.sqf
_curator = CuratorLogicGroup createunit ["ModuleCurator_F", [0, 90, 90],[],0.5,"NONE"];    
_curator setvariable ["text","_curator"];     
_curator setvariable ["Addons",3,true];//3: allow all addons with proper use of CfgPatches
_curator setvariable ["owner","objnull"];  
_curator setvariable ["vehicleinit","_this setvariable ['Addons',3,true]; _this setvariable ['owner','objnull'];"]; 
unassignCurator _curator;
sleep 1.0;
objnull assignCurator _curator;
missionCurators pushBack _curator;

[] execVM "setupmissionzeus.sqf";

