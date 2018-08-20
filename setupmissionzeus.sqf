if (!isServer) exitWith {};
// ******************************************************************************************
// *  *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: setupmissionzeus.sqf
//	@file Author: Domino
//	@file Created: 08/03/2017 10:24
//	@file Args:

missionCuratorsInUse = [];
missionPlayerCurators = [];

"ActivatePlayerZeusMode" addPublicVariableEventHandler {
	private [ "_player", "_curator", "_playerId" ];
	_player = ActivatePlayerZeusMode select 0;

	if (!isNil "_player") then {
		_curator = [] call Get_FreeZeusCurator;
		if (!isNil "_curator") then {
			[_player, _curator] call Assign_PlayerAsCurator;		
		} else {
			_playerId = owner _player;
			NotifyPlayerZeusModeError = [_player, "No free zeus curator available."];
			_playerId publicVariableClient "NotifyPlayerZeusModeError";
			NotifyPlayerZeusModeError = [];
		};
	};
};

"DeactivatePlayerZeusMode" addPublicVariableEventHandler {
	private [ "_player", "_curatorArray", "_curator", "_playerId" ];
	_player = ActivatePlayerZeusMode select 0;

	if (!isNil "_player") then {
		_curatorArray = [_player] call Get_ActivePlayerCurator;
		if (count _curatorArray > 0) then {
			_curator = _curatorArray select 0;
			[_player, _curator] call Remove_PlayerAsCurator;		
		} else {
			_playerId = owner _player;
			NotifyPlayerZeusModeError = [_player, "Zeus not currenly activated."];
			_playerId publicVariableClient "NotifyPlayerZeusModeError";
			NotifyPlayerZeusModeError = [];
		};
	};
};

Get_FreeZeusCurator = {
	private [ "_return" ];
	_return = missionCurators select 0;
	_return
};

Get_ActivePlayerCurator = {
	private [ "_exit", "_player", "_curator", "_curatorPlayerId", "_curatorId" ];
	
	_exit = false;
	_player = if (count _this > 0) then { _this select 0 } else { _exit = true };
	if (_exit) exitWith {[]};
	
	_curator = [];
	
	{
		scopeName "FindPlayerCurator";
		if (!isNil "_x") then {
			_curatorPlayerId = _x select 0;
			_curatorId = _x select 1;
			if (_player == _curatorPlayerId) then {
				_curator = [_curatorId];
				breakOut "FindPlayerCurator";
			};
		};
	} forEach missionPlayerCurators;
		
	_curator
};


Check_PlayerCurator = {


};

Assign_PlayerAsCurator = {
	private [ "_exit", "_player", "_curator", "_validCurator", "_playerId" ];
	
	_exit = false;
	_player = if (count _this > 0) then { _this select 0 } else { _exit = true };
	if (_exit) exitWith {};
	
	_curator = if (count _this > 1) then { _this select 1 } else { _exit = true };
	if (_exit) exitWith {};
	
	_validCurator = false;
	
	{
		scopeName "FindTheCurator";
		if (!isNil "_x") then {
			if (_x == _curator) then {
				_validCurator = true;
				breakOut "FindTheCurator";
			};
		};
	} forEach missionCurators;
	
	if (_validCurator) then {
		_playerCurator = [_player] call Get_ActivePlayerCurator;
		if (count _playerCurator == 0) then {
			missionCurators = missionCurators - [_curator];
			missionPlayerCurators set [count missionPlayerCurators, [_player,_curator]];
			missionCuratorsInUse = missionCuratorsInUse + [_curator];
			
			unassignCurator _curator;
			_player assignCurator _curator; 
			_curator addCuratorEditableObjects [[_player],true];
			_curator addCuratorEditableObjects [allMissionObjects "all",true ];
			
			_playerId = owner _player;
			NotifyPlayerZeusMode = [_player, true];
			_playerId publicVariableClient "NotifyPlayerZeusMode";
			NotifyPlayerZeusMode = [];			
		} else {
			_playerId = owner _player;
			NotifyPlayerZeusMode = [_player, true];
			_playerId publicVariableClient "NotifyPlayerZeusMode";
			NotifyPlayerZeusMode = [];
		};
	} else {
		_playerId = owner _player;
		NotifyPlayerZeusModeError = [_player, "Not a valid zeus curator."];
		_playerId publicVariableClient "NotifyPlayerZeusModeError";
		NotifyPlayerZeusModeError = [];
	};
};

Remove_PlayerAsCurator = {
	private [ "_exit", "_player", "_curator", "_validCurator", "_playerId" ];
	
	_exit = false;
	_player = if (count _this > 0) then { _this select 0 } else { _exit = true };
	if (_exit) exitWith {};
	
	_curator = if (count _this > 1) then { _this select 1 } else { _exit = true };
	if (_exit) exitWith {};
	
	missionCurators = missionCurators + [_curator];
	missionPlayerCurators = missionPlayerCurators - [_this];
	missionCuratorsInUse = missionCuratorsInUse - [_curator];
	
	unassignCurator _curator; 
	objnull assignCurator _curator; 
	_curator removeCuratorEditableObjects [[_player],false];
	
	_playerId = owner _player;
	NotifyPlayerZeusMode = [_player, false];
	_playerId publicVariableClient "NotifyPlayerZeusMode";
	NotifyPlayerZeusMode = [];	
};
