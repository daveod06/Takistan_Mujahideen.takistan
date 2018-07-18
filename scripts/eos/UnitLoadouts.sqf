private ["_initString"];
_type=(_this select 0);
_enemyFactionsArray=(_this select 1);
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


_loadoutsFilePath = "scripts\eos\loadouts\";
_dotSqf = ".sqf";
_joinArray = [_loadoutsFilePath,_type,_dotSqf];
_initString="";
_fileName = _joinArray joinString "";
_fileExists = (_fileName call KK_fnc_fileExists);

_addFlashlightString = "_flashlightItem = (primaryWeaponItems this) select 1;this removePrimaryWeaponItem _flashlightItem;this addPrimaryWeaponItem ""acc_flashlight"";this addPrimaryWeaponItem ""rhs_acc_2dpZenit"";this addPrimaryWeaponItem ""rhsusf_acc_anpeq15_light"";";
_useFlashLightString = "this enablegunlights ""forceOn"";this unassignItem ""NVGoggles"";this removeItem ""NVGoggles"";this unassignItem ""NVGoggles_OPFOR"";this removeItem ""NVGoggles_OPFOR"";";
_suicideBomberString = "[this,_enemyFactionsArray,""grenadeHand"",20,TRUE,_temp] execVM ""scripts\suicideBomber.sqf"";";
_initString = "";

if (_fileExists) then
{
    _initString = preprocessFileLineNumbers _fileName; 
    if (EOS_USE_FLASHLIGHTS) then
    {  
        _flashLightArray = [_initString,_addFlashlightString,_useFlashLightString];
        _initString = _flashLightArray joinString "";
    };
    if (random 1.0 <= EOS_SUICIDE_CHANCE) then
    {  
        _suicideBomberArray = [_initString,_suicideBomberString];
        _initString = _suicideBomberArray joinString "";
    };
}
else
{
    if (EOS_USE_FLASHLIGHTS) then
    {  
        _flashLightArray = [_initString,_addFlashlightString,_useFlashLightString];
        _initString = _flashLightArray joinString "";
    };
    if (random 1.0 <= EOS_SUICIDE_CHANCE) then
    {  
        _suicideBomberArray = [_initString,_suicideBomberString];
        _initString = _suicideBomberArray joinString "";
    };
};

//hint _initString;
_initString;
