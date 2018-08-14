// INFANTRY SKILL
_InfskillSet = [
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


server setvariable ["AirmobileINFskill",_InfskillSet];
server setvariable ["AirmobileAIRskill",_AIRskillSet];
