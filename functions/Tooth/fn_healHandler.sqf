params ["_injured","_healer"];
diag_log format ["HandleHeal: injured: %1 healer: %2",_injured,_healer];

private _items = items _healer;
private _return = false;

// check if healer has Medikit
private _hasMediKit = false;
if ("Medikit" in _items) then
{
    _hasMediKit = true;
};
diag_log format ["HandleHeal: healer has Medikit: %1",_hasMediKit];

// check if healer has FAK
private _hasFirstAidKit = false;
if ("FirstAidKit" in _items) then
{

    _hasFirstAidKit = true;
};
diag_log format ["HandleHeal: healer has FAK: %1",_hasFirstAidKit];

// check if injured is local
private _injuredLocal = false;
private _damage = 0.0;
if (local _injured) then
{
    _injuredLocal = true;
    _damage = damage _injured;
}
else
{
    _damage = [_injured] remoteExec ["damage [_this select 0]", _injured, false];
};
diag_log format ["HandleHeal: injured is local: %1 damage: %2",_injuredLocal,_damage];

// check if healer is local
private _healerLocal = false;
if (local _healer) then
{
    _healerLocal = true;
};
diag_log format ["HandleHeal: healer is local: %1",_healerLocal];




if (_injuredLocal) then
{
    //waitUntil 
    //{
    //    damage _injured < _damage;
    //    true;
    //};
    if (_hasMediKit) then
    {
        _injured setDamage 0;
    }
    else
    {
        if (_hasFirstAidKit) then
        {
            _injured setDamage 0.5;
        }
        else
        {
            _injured setDamage _damage;
        };
    };
}
else
{
    //waitUntil 
    //{
    //    ([_injured] remoteExec ["damage (_this select 0)", _injured, false]) < _damage;
    //    true;
    //};
    if (_hasMediKit) then
    {
        [_injured] remoteExec ["[_this select 0] setDamage 0.0", _injured, false];
    }
    else
    {
        if (_hasFirstAidKit) then
        {
            [_injured] remoteExec ["[_this select 0] setDamage 0.5", _injured, false];
        }
        else
        {
            [_injured,_damage] remoteExec ["(_this select 0) setDamage (_this select 1)", _injured, false];
        };
    };
};
_return = true;
_return
