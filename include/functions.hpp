class CfgFunctions
{
    class ToothFunctions
	{
		class Tooth
		{
			#include "..\functions\Tooth\Functions.hpp"
			class preinit {
                preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
                postInit = 0; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
                recompile = 0; // 1 to recompile the function upon mission start
            };
            class postinit {
                preInit = 0; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
                postInit = 1; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
                recompile = 0; // 1 to recompile the function upon mission start
            };
        };
	};
    class ATR
	{
		class Revive
		{
			#include "..\functions\revive\revive.hpp"
		};
	};
	class ATHSC
	{
		class HSC
		{
			#include "..\functions\HSC\hsc.hpp"
		};
	};
    #include "..\functions\AIS\Functions.hpp"
	#include "..\functions\aiArtillery\functions.hpp"
	#include "..\functions\aiConvoys\functions.hpp"
	#include "..\functions\airmobileOps\functions.hpp"
	#include "..\functions\enemyOccupationSystem\functions.hpp"
	#include "..\functions\civiliansAndTraffic\Engima\Civilians\functions.hpp"
	#include "..\functions\civiliansAndTraffic\Engima\Traffic\functions.hpp"
	#include "..\functions\saberCommonScripts\functions.hpp"
	#include "..\functions\waveDefense\functions.hpp"
};
