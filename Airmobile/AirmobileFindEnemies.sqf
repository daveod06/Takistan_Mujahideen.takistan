// determine destination & num helipads
// determine spawn area and create helipads if on ground




//if (!isServer) exitWith {};
//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

({alive _x && side _x == east} count thisList) <= ((({alive _x && side _x == east} count thisList))*0.5);
({not alive _x && side _x == east} count thisList) <= ((({alive _x && side _x == east} count thisList))*0.5);