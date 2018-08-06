//onplayerConnected {[] execVM "scripts\eos\Functions\EOS_Markers.sqf";};
["JIP_id", "onplayerConnected", {[] spawn  execVM EOS_fnc_Markers;}] call BIS_fnc_addStackedEventHandler;
/* EOS 1.98 by BangaBob 
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

fnc_master =
{
    GROUP SIZES
     0 = 1
     1 = 2,4
     2 = 4,8
     3 = 8,12
     4 = 12,16
     5 = 16,20
    
    EXAMPLE CALL - EOS
     null = [["MARKERNAME","MARKERNAME2"],[2,1,70],[0,1],[1,2,30],[2,60],[2],[1,0,10],[1,0,250,WEST]] call EOS_Spawn;
     null=[["M1","M2","M3"],[HOUSE GROUPS,SIZE OF GROUPS,PROBABILITY],[PATROL GROUPS,SIZE OF GROUPS,PROBABILITY],[LIGHT VEHICLES,SIZE OF CARGO,PROBABILITY],[ARMOURED VEHICLES,PROBABILITY], [STATIC VEHICLES,PROBABILITY],[HELICOPTERS,SIZE OF HELICOPTER CARGO,PROBABILITY],[FACTION,MARKERTYPE,DISTANCE,SIDE,HEIGHTLIMIT,DEBUG]] call EOS_Spawn;
    
    EXAMPLE CALL - BASTION
     null = [["BAS_zone_1"],[3,1],[2,1],[2],[0,0],[0,0,EAST,false,false],[10,2,120,TRUE,TRUE]] call EOS_fnc_Bastion_Spawn;//Bastion_Spawn;
     null=[["M1","M2","M3"],[PATROL GROUPS,SIZE OF GROUPS],[LIGHT VEHICLES,SIZE OF CARGO],[ARMOURED VEHICLES],[HELICOPTERS,SIZE OF HELICOPTER CARGO],[FACTION,MARKERTYPE,SIDE,HEIGHTLIMIT,DEBUG],[INITIAL PAUSE, NUMBER OF WAVES, DELAY BETWEEN WAVES, INTEGRATE EOS, SHOW HINTS]] call Bastion_Spawn;
    */
    VictoryColor="colorGreen";	// Colour of marker after completion
    hostileColor="colorRed";	// Default colour when enemies active
    bastionColor="colorOrange";	// Colour for bastion marker
    EOS_DAMAGE_MULTIPLIER=1;	// 1 is default
    EOS_KILLCOUNTER=false;		// Counts killed units
    EOS_USE_FLASHLIGHTS=false;   // Attempts to make spawned units use flashlights
    EOS_SUICIDE_CHANCE=0.0;     // Attemps to % of units as suicide bombers 0.0 -1.0
    
    null = [["EOSzone_1"],[4,2,80],[5,2,60],[2,1,60],[1,50],[1,50],[0,0],[7,1,1000,EAST,TRUE]] call EOS_fnc_Spawn;//EOS_Spawn;
    null = [["EOSzone_2"],[2,2,60],[1,1,75],[0,0],[0],[0],[0,0],[7,1,400,EAST,TRUE]] call EOS_fnc_Spawn;//EOS_Spawn;
    null = [["EOSzone_3"],[2,1,80],[1,2,80],[0,0],[0],[0],[0,0],[7,2,1000,EAST,TRUE]] call EOS_fnc_Spawn;//EOS_Spawn;
    null = [["EOSzone_4"],[2,1,80],[1,2,80],[0,0],[0],[0],[0,0],[7,2,1000,EAST,TRUE]] call EOS_fnc_Spawn;//EOS_Spawn;
    null = [["EOSzone_5"],[2,1,80],[1,2,80],[0,0],[0],[0],[0,0],[7,2,1000,EAST,TRUE]] call EOS_fnc_Spawn;//EOS_Spawn;
    null = [["EOSzone_6"],[0,0,0],[4,1,100],[0,0,0],[0],[2,100],[0,0],[8,1,1000,Independent,TRUE]] call EOS_fnc_Spawn;//EOS_Spawn;
    //null = [["EOSzone_1"],["BAS_spawn_0",5],[4,3,80],[1,1,80],[0],[0,0],[8,0,Independent],[10*60,2,5*60,FALSE,TRUE]] call EOS_fnc_Bastion_Spawn;//Bastion_Spawn;
    //null = [["EOSmot_1","EOSmot_2"],[0,0],[0,0],[3,1,90],[2,60],[0],[1,0,90],[0,0,350,EAST,FALSE]] call EOS_fnc_Spawn;//EOS_Spawn;
    //null = [["BAS_zone_1"],[0,1],[0,2],[0],[1,2],[0,0,EAST,TRUE],[0,2,120,TRUE,FALSE]] call EOS_fnc_Bastion_Spawn;//Bastion_Spawn;
};


// Enemy Occupation System (EOS) Setup
if HC3Present then
{
	//EOS Dynamic Combat System
	[] spawn fnc_master;
}
else
{
	if HC2Present then
	{
		//EOS Dynamic Combat System
        [] spawn fnc_master;
	}
	else
	{
		if HC1Present then
		{
			//EOS Dynamic Combat System
            [] spawn fnc_master;
		}
		else
		{
			//EOS Dynamic Combat System
            [] spawn fnc_master;
		};
	};
};
