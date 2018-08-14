// INFANTRY SKILL
_INFskillSet = [
0.25,        // aimingAccuracy
0.45,        // aimingShake
0.5,        // aimingSpeed
0.4,         // spotDistance
0.3,        // spotTime
1,        // courage
1,        // reloadSpeed
1,        // commanding
1        // general
];

// HELICOPTER SKILL
_AIRskillSet = [
0.25,        // aimingAccuracy
0.45,        // aimingShake
0.6,        // aimingSpeed
0.4,         // spotDistance
0.4,        // spotTime
1,        // courage
1,        // reloadSpeed
1,        // commanding
1        // general
];

// VEHICLE SKILL
_VEHskillSet = [
0.25,        // aimingAccuracy
0.45,        // aimingShake
0.6,        // aimingSpeed
0.4,         // spotDistance
0.4,        // spotTime
1,        // courage
1,        // reloadSpeed
1,        // commanding
1        // general
];

WaveINFskill = _INFskillSet;
WaveAIRskill = _AIRskillSet;
WaveVEHskill = _VEHskillSet;

server setvariable ["WaveINFskill",_INFskillSet];
server setvariable ["WaveAIRskill",_AIRskillSet];
server setvariable ["WaveVEHskill",_VEHskillSet];
