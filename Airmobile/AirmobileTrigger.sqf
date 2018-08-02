// auto find flat spots and place helipads within marker area
// determine destination & num helipads
// determine spawn area and create helipads if on ground
// spawn n helicopters with crew
// group helicopters
// spawn n squads
// group squads
// try to put squads in helicopter cargo depending on size of each helicopter cargo, delete extra troops
// give helicopters take off waypoints???\
// create get out waypoint for troops at LZ, set to careless
// give helicopters a move waypoint 1km out from LZ
// slow down helicopters and limit speed, lower alt, set behavior
// make intermediate waypoint, slow and lower more
// transport unload waypoint
// sleep for a few seconds
// give troops patrol waypoint to nearest threat, set to aware
// give helicopters limited alt and speed to get away from LZ
// send helicopters back to takeoff points
// delete helicopters

//if (!isServer) exitWith {};
//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

fnc_AirmobileTrigger =
{

	//_message = format ["fnc_AirmobileTrigger input: %1",_this];
	//hint _message;
	//sleep 3.0;
	//_message = format ["fnc_AirmobileTrigger _this[0]: %1",_this select 0];
	//hint _message;
	//sleep 3.0;
	private _input = _this select 0;

	private _lzHelipads = _input select 0;
	private _baseHelipads = _input select 1;
	private _lzHelipadsArray = _lzHelipads;
	private _baseHelipadsArray = _baseHelipads;
	private _side = east;
	private _faction = "SovietArmy_OKSVA";
	private _category = "SpecOps";
	private _transportType = "OKSVA_MI8MT";
	private _attackType = selectRandom ["OKSVA_Mi8MTV3","OKSVA_Mi24P"];
	private _squadType = selectRandom ["SovietArmy_OKSVA_specops_vdv_company_hq_section","SovietArmy_OKSVA_specops_vdv_rifle_squad","SovietArmy_OKSVA_specops_vdv_rifle_squad","SovietArmy_OKSVA_specops_vdv_rifle_squad"];
	private _spawnAttackHelis = true;
	private _spawnInAir = true;
	private _dustoff = false;
	[_lzHelipadsArray,_baseHelipadsArray,_side,_faction,_category,_transportType,_attackType,_squadType,_spawnAttackHelis,_spawnInAir,_dustoff] spawn Saber_fnc_AirmobileMaster;
};

//_this = [_lzTriggerArray,_baseTriggerArray,_side,_faction,_category,_transportType,_attackType,_squadType,_spawnAttackHelis,_spawnInAir,_dustoff]
if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
{
    //hint "Calling fnc_AirmobileTrigger.";
    //sleep 1.0;
    [_this] call fnc_AirmobileTrigger;
}
else
{
    if(isServer) then
    {
        //hint "Calling fnc_AirmobileTrigger.";
        //sleep 1.0;
        [_this] call fnc_AirmobileTrigger;
    };
};

