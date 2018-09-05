/*
 * If you want the ambient infantry to be handled by a headless client other than the server, then
 * specify its name in the variable below. For execution on the server, set the value to an empty
 * string ("").
 */

//if (!isServer) exitWith {};
//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

if HC3Present then
{
	Engima_Traffic_HeadlessClientName = "HC3";
}
else
{
	if HC2Present then
	{
		Engima_Traffic_HeadlessClientName = "HC2";
	}
	else
	{
		if HC1Present then
		{
			Engima_Traffic_HeadlessClientName = "HC3";
		}
		else
		{
			Engima_Traffic_HeadlessClientName = "";
		};
	};
};