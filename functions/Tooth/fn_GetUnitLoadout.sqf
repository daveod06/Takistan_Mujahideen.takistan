private ["_initString"];
params["_classname","_useFlashlights"];
//_classname=(_this select 0);
//_enemyFactionsArray=(_this select 1);
//_pool=(_this select 1);

KK_fnc_fileExists = {
    private ["_ctrl", "_fileExists"];
    disableSerialization;
    _ctrl = findDisplay 0 ctrlCreate ["RscHTML", -1];
    _ctrl htmlLoad _this;
    _fileExists = ctrlHTMLLoaded _ctrl;
    ctrlDelete _ctrl;
    _fileExists
};

// This works with external files too run on server but sadly requires -allowFilePatching to find them.
ToothFunctions_fnc_fileExists =
{
    params ["_filePath"];
    _fileExists = false;
    if !(loadFile _filePath isEqualTo "") then
    {
        _fileExists = true;
    }
    else
    {
    	//diag_log format ["ToothFunctions_fnc_fileExists: WARNING Did not find file: %1 ", _filePath];
    };
    _fileExists
};


if (_classname == "") exitWith {diag_log format["ToothFunctions_fnc_getUnitType _classname is null!!!!!!!!! _this: %1",_this]};

_loadoutsFilePath = "functions\enemyOccupationSystem\loadouts\";
_dotSqf = ".sqf";
_joinArray = [_loadoutsFilePath,_classname,_dotSqf];

_initString="";
_fileName = _joinArray joinString "";
//_fileExists = (_fileName call KK_fnc_fileExists);
_fileExists = [_fileName] call ToothFunctions_fnc_fileExists;

_addFlashlightString = "_flashlightItem = (primaryWeaponItems this) select 1;this removePrimaryWeaponItem _flashlightItem;this addPrimaryWeaponItem ""acc_flashlight"";this addPrimaryWeaponItem ""rhs_acc_2dpZenit"";this addPrimaryWeaponItem ""rhsusf_acc_anpeq15_light"";";
_useFlashLightString = "this enablegunlights ""forceOn"";this unassignItem ""NVGoggles"";this removeItem ""NVGoggles"";this unassignItem ""NVGoggles_OPFOR"";this removeItem ""NVGoggles_OPFOR"";";
//_initString = "";

if (_fileExists) then
{
    diag_log format ["ToothFunctions_fnc_getUnitLoadout: Found matching %1 loadout file for: %2",_classname,_fileName];

    _initString = preprocessFileLineNumbers _fileName; 
    if (_useFlashlights) then
    {  
        _flashLightArray = [_initString,_addFlashlightString,_useFlashLightString];
        _initString = _flashLightArray joinString "";
    };
}
else
{
    //diag_log format ["ToothFunctions_fnc_getUnitLoadout: WARNING did not find matching %1 loadout file: %2",_classname,_fileName];
    if (_useFlashlights) then
    {  
        _flashLightArray = [_initString,_addFlashlightString,_useFlashLightString];
        _initString = _flashLightArray joinString "";
    };
};

//hint _initString;
_initString;
