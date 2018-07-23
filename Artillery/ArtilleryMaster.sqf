//if (!isServer) exitWith {};
//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};


fnc_selectTarget = {
	private _targetGroupsArray = _this select 0;
    private _targetUnit = objNull;
    if (count _targetGroupsArray > 0) then // if target array is not empty
    {
	    _targetGroup = selectRandom _targetGroupsArray;
        //private _targetGroupSize = count (units _targetGroup);
        
        _message = format["_targetGroupsArray: %1 _targetGroup: %2 _targetGroupSize:  _targetUnit: %4 ",_targetGroupsArray,_targetGroup,_targetUnit];
        hint _message;
        private _targetGroupSize = count (units _targetGroup);
        
        if ((!isNull _targetGroup) && (_targetGroupSize > 0)) then  // if target group is not null and has units
        {
            _targetUnit = selectRandom (units _targetGroup);
        };
    };
    _targetUnit;
};


fnc_artilleryAliveCheck = {
	private _artillery = _this select 0;
	private _artilleryOk = false;
	if (!(isNull _artillery)) then
	{
    	if (alive _artillery) then
		{
			if (!(isNull (gunner _artillery))) then
			{
				if (alive (gunner _artillery)) then
				{
					_artilleryOk = true;
				};
			};
		};
	};
	_artilleryOk;
};

fnc_setAiFireAware = {
	private _artillery = _this select 0;
	private _forceFire = _this select 1;
	private _targetUnit = _this select 2;
    private _artilleryOk = false;
    private _awareness = 0.0;
    _artilleryOk = [_artillery] call fnc_artilleryAliveCheck;

    if (_artilleryOk) then
    {
        private _gunner = gunner _artillery;
        _gunner enableAI "TARGET";
        _gunner enableAI "AUTOTARGET";
        _gunner enableAI "WEAPONAIM";
        _gunner reveal [_targetUnit,4.0];
        // look in direction of target
        // reveal
        // 

        //if (_forceFire) then
		//{
        //    _gunner enableAI "TARGET";
        //    _gunner enableAI "AUTOTARGET";
        //    _gunner enableAI "WEAPONAIM";
		//}
		//else
		//{
		//	_gunner disableAI "TARGET";
		//	_gunner disableAI "AUTOTARGET";
		//	_gunner disableAI "WEAPONAIM";
		//};
		_awareness = _gunner knowsAbout _targetUnit;
    };
    _awareness;
};

fnc_artilleryDoArtilleryFire =
{
    private _targetPos = _this select 0;
    private _artillery = _this select 1;
    private _errorRadius = _this select 2;
    private _delay = _this select 3;
    //private _targetPos = getPosAtl _targetUnit;
    private _ammo = getArtilleryAmmo [_artillery] select 0;
    private _correctedTargetPos = [(_targetPos select 0) - _errorRadius + (2 * random _errorRadius), (_targetPos select 1) - _errorRadius + (2 * random _errorRadius), 0];

    private _canFire = _correctedTargetPos inRangeOfArtillery [[_artillery], _ammo];
    if (_canFire) then
    {
        private _eta = _artillery getArtilleryETA [_correctedTargetPos, _ammo];
        private _message = format ["Artillery target in range with %1 ammunition. ETA %2 seconds.",_ammo,_eta];
        hint _message;
        _artillery doArtilleryFire [_correctedTargetPos, _ammo, 1];
    }
    else
    {
        private _message = format ["Artillery target not in range with %1 ammunition.",_ammo];
        hint _message;
    };
    sleep _delay;
};


//[10,bm21_2,[group player],50,60,10,true] spawn Saber_fnc_Artillery
fnc_artilleryFireMaster =
{

	//_input = _this select 0;
    _input = _this;
	_message = format ["fnc_artilleryFireMaster input: %1",_input];
	hint _message;
	sleep 3.0;

    private _numRounds = _input select 0; // number of round to shoot
    private _artillery = _input select 1; // artillery object
    private _targetGroupsArray = _input select 2; // array of possible target units
    private _errorRadius = _input select 3; // self explanatory
    private _initialDelay = _input select 4; // seconds delay before shooting starts
    private _shotDelay = _input select 5; // seconds delay between shots
    private _forceFire = _input select 6; // command to fire instead of letting AI figure it out
    private _targetUnit = objNull;
    private _awareness = 0.0;

    private _artilleryOk = [_artillery] call fnc_artilleryAliveCheck;
    if (_artilleryOk) then
    {
        _targetUnit = [_targetGroupsArray] call fnc_selectTarget;
        _awareness = [_artillery,_forceFire,_targetUnit,_shotDelay] call fnc_setAiFireAware;
    }
    else
    {   _targetUnit = objNull;
        _awareness = 0.0;
    };
    if (isNull _targetUnit) exitWith {
        hint "Artillery target is null!";
    };

    private _targetPos = getPosAtl _targetUnit;
    sleep _initialDelay;

    if (_forceFire) then
    {
        for [{_i=0}, {_i<_numRounds}, {_i=_i+1}] do 
        {   
            _artilleryOk = [_artillery] call fnc_artilleryAliveCheck;
            if (_artilleryOk) then
            {
                [_targetPos,_artillery,_errorRadius,_shotDelay] call fnc_artilleryDoArtilleryFire;
            };
        };
    };
};

//_this = [_numRounds,_artillery,_targetGroupsArray,_errorRadius,_shotDelay,_forceFire]
if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
{
    //hint "Calling fnc_artilleryFireMaster.";
    //sleep 1.0;
    _this call fnc_artilleryFireMaster;
}
else
{
    if(isServer) then
    {
        //hint "Calling fnc_artilleryFireMaster.";
        //sleep 1.0;
        _this call fnc_artilleryFireMaster;
    };
};
