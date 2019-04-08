params ["_player", "_didJIP"];


diag_log format["initPlayerServer run for %1", name _player];

if(name _player == "HC1") then 
{
    diag_log format ["%1 present.",name _player];
    A3E_HC_ID = owner _player;
    if(A3E_HC_ID==0) exitwith {
         diag_log "Getting HC1 ID failed!";
    };
}
/*
elif (name _player == "HC2") then 
{
    diag_log format ["%1 present.",name _player];
    A3E_HC_ID = owner _player;
    if(A3E_HC_ID==0) exitwith {
         diag_log "Getting HC2 ID failed!";
    };
}
elif (name _player == "HC3") then 
{
    diag_log format ["%1 present.",name _player];
    A3E_HC_ID = owner _player;
    if(A3E_HC_ID==0) exitwith {
         diag_log "Getting HC3 ID failed!";
    };
}
*/
else 
{
};
_player setvariable["A3E_PlayerInitializedServer",true,true];
