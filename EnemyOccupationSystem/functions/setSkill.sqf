_grp=(_this select 0);
_skillArray=(_this select 1);

//_message = format ["SET SKILL: _this: %1 _grp: %2 _skillArray: %3",_this,_grp,_skillArray];
//hint _message; sleep 2.0;

_skillset = server getvariable _skillArray;
//_message = format ["SET SKILL: _skillArray: %1 ",_skillArray];
//hint _message; sleep 2.0;
{
	_unit = _x;
	{
		_skillvalue = (_skillset select _forEachIndex) + (random 0.2) - (random 0.2);
		_unit setSkill [_x,_skillvalue];
	} forEach ["aimingAccuracy","aimingShake","aimingSpeed","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];
			
	if (EOS_DAMAGE_MULTIPLIER != 1) then {_unit removeAllEventHandlers "HandleDamage";_unit addEventHandler ["HandleDamage",{_damage = (_this select 2)*EOS_DAMAGE_MULTIPLIER;_damage}];};
	if (EOS_KILLCOUNTER) then {_unit addEventHandler ["killed", "null=[] spawn EOS_fnc_KillCounter;"]};
	// ADD CUSTOM SCRIPTS TO UNIT HERE
} forEach (units _grp); 
