// ConvoyEnd.sqf
// © v.2.5 MARCH 2016 - Devastator_cm

private _convoyArray	= _this select 0; // All vehicles which are still in convoy
private _all_groups		= _this select 1; // All groups which are still in convoy
private _ConvoyID		= _this select 2; // In case there are multiple convoys, this parameter can be used to find out which one reached the final marker and do the necessary custom code branch easily
private _LastMarker		= _this select 3; // Last marker which convoy reached

{
	_x setSpeedMode  "NORMAL"; // Used to set the speed mode when convoy reaches last marker
    _x setCombatMode "YELLOW"; // Used to set the combat mode when convoy reaches last marker
    _x setBehaviour  "SAFE";   // Used to set the behaviour when convoy reaches last marker
} 	foreach _all_groups;

///////             CUSTOM CODE CAN BE USED FROM THIS POINT ON           ///////////
// From this point on, you can add the logic which you want to happen when convoy arrives to final point (i.e. calling your own scripts).
// You can use the _ConvoyID to choose different actions based on the convoy which arrived in case there are multiple convoys in your scenario.
// Another possibility is to create patrol behaviour by calling the initial script once more from this point.
// For example if you have a circular path where the convoy is driving calling the Saber_fnc_ConvoyMove again from here by using the _convoyArray and the initial marker array will let convoy to make a circular patrol
// In case you have a more linear path setup you can reverse the markers before calling Saber_fnc_ConvoyMove which will let your convoy to return back

// Patrol Example 1
// Convoy ID 3 needs to make a patrol by following a linear cyle logic
// Let's say initial marker array is ["marker_1", "marker_2","marker_3"]. Following code will let it to return back each and every time when it arrives to final marker
// In this example important point is to remove the last marker when it needs to return back otherwise convoy will stuck and will not move
/*if(_ConvoyID == 3 && _LastMarker == "marker_1") then {_handle = [["marker_2","marker_3"],[v_1, v_2], 25, 500, 3, "NORMAL", "SAFE"] spawn Saber_fnc_ConvoyMove;};
  if(_ConvoyID == 3 && _LastMarker == "marker_3") then {_handle = [["marker_2","marker_1"],[v_1, v_2], 25, 500, 3, "NORMAL", "SAFE"] spawn Saber_fnc_ConvoyMove;};*/

// Patrol Example 2
// Convoy ID 2 has a circular path so we just want to keep driving in same direction to do patrol
// Let's say initial marker array is ["marker_1", "marker_2","marker_3"]. Following code will let it to return back each and every time when it arrives to final marker
//if(_ConvoyID == 2) then {_handle = [["marker_1", "marker_2","marker_3"],[v_1, v_2], 25, 500, 3, "NORMAL", "SAFE"] spawn Saber_fnc_ConvoyMove;};

// Patrol Example 3
// So a hybrid example where there are multiple convoys. One of them has linear path (ConvoyID 3) which it needs to reverse direction and other convoy has circular path (ConvoyID 2) 
// Convoy 1 will call a custom script let's say XYZ_Script.sqf
/*if(_ConvoyID == 3 && _LastMarker == "marker_1") then {_handle = [["marker_2","marker_3"],[v_1, v_2], 25, 500, 3, "NORMAL", "SAFE"] spawn Saber_fnc_ConvoyMove;};
  if(_ConvoyID == 3 && _LastMarker == "marker_3") then {_handle = [["marker_2","marker_1"],[v_1, v_2], 25, 500, 3, "NORMAL", "SAFE"] spawn Saber_fnc_ConvoyMove;};
  if(_ConvoyID == 2) then {_handle = [["marker_1", "marker_2","marker_3"],[v_1, v_2], 25, 500, 3, "NORMAL", "SAFE"] spawn Saber_fnc_ConvoyMove;};
  if(_ConvoyID == 1) then {_handle = [] spawn "XYZ_Script.sqf";};
*/
