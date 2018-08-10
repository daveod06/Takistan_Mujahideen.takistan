
_side = _this select 0;
_faction = _this select 1;
_squadType = _this select 2;
_spawnMarker = _this select 3;
_waveNum = _this select 4;
_squadNum = _this select 5;

_category = _squadType select 0;
_squadClassname = _squadType select 1;

// Get side string
if (_side == east) then
{
	_sideStr = "East"
};
if (_side == west) then
{
	_sideStr = "West"
};
if (_side == resistance) then
{
	_sideStr = "Resistance"
};

_spawnedTroopGroups = [];

server setvariable ["WaveINFskill",_InfskillSet];
server setvariable ["WaveAIRskill",_AIRskillSet];

_squadName = "INF_WAVE_" + (str _waveNum) + "_SQUAD_" + (str _squadNum);

_spawnPos = _spawnMarker getPos [(random [0,50,100]), (random [0,180,360])];
_spawnPos = [_spawnPos, 1.0, 150.0, 3.0, 0, 1.0, 0] call BIS_fnc_findSafePos;
_group = [ _spawnPos, _side, (configFile >> "CfgGroups" >> _sideStr >> _faction >> _category >> _squadClassname)] call BIS_fnc_spawnGroup;
_group deleteGroupWhenEmpty true;
_group setGroupId [_squadName];
_group setCombatMode "RED";
_group setFormation "WEDGE";
_group setBehaviour "AWARE";
_group setSpeedMode "FULL";
[_group,WaveINFskill] call Saber_fnc_WaveSetSkill;

_deadTracker = _squadName + "_DEAD";
server setvariable [_deadTracker,0];
// "INF_WAVE_0_SQUAD_0_DEAD";

{
    _x addEventHandler ["killed", 
    {
        _grp = group (_this select 0);
    	if ({ alive _x } count units _grp < 1) then
    	{
    	    hint "All units dead";
    	    server setvariable [_deadTracker,1];
    	};
    }
    ];
} forEach units _group;

_spawnedTroopGroups pushBack _group;
sleep 1.0;

_spawnedTroopGroups
