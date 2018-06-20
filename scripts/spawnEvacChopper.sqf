// _script = [_spawnPos,_type,_rot,_side,_landingPosArray,_exitPos,_evacGroup,_landInHotLZ] execVM "scripts\spawnEvacChopper.sqf";
if(!isServer)exitWith{};
//private ["_evacTask","_spawnPos","_type","_rot","_chopperSide","_landingPosArray","_exitPos","_evacGroup","_landInHotLZ","_landingPos","_spawnedVehicle","_heli","_heliGroup","_evacGroupLeader","_sideStr","_LZhot","_landLoop","_LZTrigger","_successLoop","_inChopper"];
_spawnPos = _this select 0;
_type = _this select 1;
_rot = _this select 2;
_chopperSide = _this select 3;
_landingPosArray = _this select 4;
_exitPos = _this select 5;
_evacGroup = _this select 6;
_landInHotLZ = _this select 7;

_landingPos = _landingPosArray call BIS_fnc_selectRandom;
_spawnedVehicle = [_spawnPos, _rot, _type, _chopperSide] call BIS_fnc_spawnVehicle;
_heli = _spawnedVehicle select 0;
//_heliCrew = _spawnedVehicle select 1;
_heliGroup = _spawnedVehicle select 2;
_heliGroup setCombatMode "RED";
_heliGroup setBehaviour "AWARE";
{(driver _heli) disableAI _x} forEach ["TARGET","AUTOTARGET","FSM","AUTOCOMBAT"];
{(commander _heli) disableAI _x} forEach ["TARGET","AUTOTARGET","FSM","AUTOCOMBAT"];
//{_heliGroup disableAI _x} forEach ["TARGET","AUTOTARGET","FSM","AUTOCOMBAT"];
_evacGroupLeader = leader _evacGroup;

_sideStr = [(str _chopperSide)," SEIZED"] joinString "";
_LZhot = false;
_inChopper = false;
_landLoop = 1;
_successLoop = 1;

[west,["evac_task_0"],["Wait for extraction, make sure all team members are aboard.","Wait For Evac Helicopter","evac_task_0_marker"],_landingPos, true, 1, true, "takeoff", true] call BIS_fnc_taskCreate;
_evacTask = ["evac_task_0", west, ["Wait for extraction, make sure all team members are aboard.","Wait For Evac Helicopter","task_9_marker"], (_landingPos, "ASSIGNED", 10, true, true, "takeoff", true)] call BIS_fnc_setTask;

if (!_landInHotLZ) then
{
	_LZTrigger = createTrigger ["EmptyDetector", _landingPos, true];
	_LZTrigger setTriggerArea [100, 100, 0, false, 20];
	_LZTrigger setTriggerActivation [_sideStr, "PRESENT", false];
};

wp0Evac = _evacGroup addwaypoint [_landingPos, 0];
wp0Evac setwaypointtype "GETIN";
[_evacGroup, 0] waypointAttachVehicle _heli;

wp0Heli = _heliGroup addwaypoint [_landingPos, 250];
wp0Heli setwaypointtype "MOVE";

if (!_landInHotLZ) then
{
    while {_landLoop == 1} do
    {
        _LZhot = (triggerActivated _LZTrigger);
        if (!_LZhot) then
        {
            _landLoop = 0;
            if (({alive _x} count units _heliGroup > 0) && (alive _evacGroupLeader)) then
            {
                wp1Heli = _heliGroup addwaypoint [_landingPos, 0];
                wp1Heli setwaypointtype "LOAD";
                [_heliGroup, 1] waypointAttachVehicle _evacGroupLeader;
                wp1Heli synchronizeWaypoint [wp0Evac];
        
                wp2Heli = _heliGroup addwaypoint [_exitPos, 500];
                wp2Heli setwaypointtype "MOVE";
            }
            else
            {
                _evacTask = ["evac_task_0", west, ["Wait for extraction, make sure all team members are aboard.","Wait For Evac Helicopter","evac_task_0_marker"], (_landingPos, "FAILED", 10, true, true, "takeoff", true)] call BIS_fnc_setTask;
            };
        };
        sleep 2.0;
    };
}
else
{
    _landLoop = 0;
    if (({alive _x} count units _heliGroup > 0) && (alive _evacGroupLeader)) then
    {
        wp1Heli = _heliGroup addwaypoint [_landingPos, 0];
        wp1Heli setwaypointtype "LOAD";
        [_heliGroup, 1] waypointAttachVehicle _evacGroupLeader;
        wp1Heli synchronizeWaypoint [wp0Evac];
        
        wp2Heli = _heliGroup addwaypoint [_exitPos, 500];
        wp2Heli setwaypointtype "MOVE";
    }
    else
    {
        _evacTask = ["evac_task_0", west, ["Wait for extraction, make sure all team members are aboard.","Wait For Evac Helicopter","evac_task_0_marker"], (_landingPos, "FAILED", 10, true, true, "takeoff", true)] call BIS_fnc_setTask;
    };
};

while {_successLoop == 1} do
{
    //_inChopper = (({alive _x && (vehicle _x) == _x} count allPlayers) == 0;);
    _inChopper = (({!(alive _x) || _x in _heli} count (units _evacGroup)) == count (units _evacGroup));
    if (({alive _x} count units _heliGroup > 0) && _inChopper) then
    {
        _successLoop = 0;
        _evacTask = ["evac_task_0", west, ["Wait for extraction, make sure all team members are aboard.","Wait For Evac Helicopter","evac_task_0_marker"], (_landingPos, "SUCCEEDED", 10, true, true, "takeoff", true)] call BIS_fnc_setTask;
    };
    if (({alive _x} count units _heliGroup < 1) && ({alive _x} count units _evacGroup < 1)) then
    {
        _successLoop = 0;
        _evacTask = ["evac_task_0", west, ["Wait for extraction, make sure all team members are aboard.","Wait For Evac Helicopter","evac_task_0_marker"], (_landingPos, "FAILED", 10, true, true, "takeoff", true)] call BIS_fnc_setTask;
    };
    sleep 1.0;
};

_heli
