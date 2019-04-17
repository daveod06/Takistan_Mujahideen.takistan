class Params
{
	class Param_Spacer0
    {
            title = "==================== Difficulty Settings ====================";
            values[] = {0};
            texts[] = {""};
            default = 0;
	};
    class Param_EnemySkill
	{
            title = "Enemy Skill";
            values[] = {0, 1, 2, 3, 4};
            texts[] = {"Cadet", "Easy", "Normal", "Hard", "Extreme"};
            default = 0;
	};
    class Param_EnemySpawnDistance
	{
		title="Enemy Spawn Distance";
		values[]={500,800,1050,1300};
		texts[]={"Super Short (for shitty servers)", "Short (better performance)", "Medium", "Far (for good rigs)"};
		default = 1050;
	};
    class Param_Spacer1
    {
            title = "==================== Environment Settings ====================";
            values[] = {0};
            texts[] = {""};
            default = 0;
	};
    class Param_TimeOfDay	
	{	
	    title="Time Of Day";
		values[]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26};
		texts[]={"00:00","01:00","02:00","03:00","04:00","05:00","06:00","07:00","08:00","09:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00","Random","Daytime","Nighttime"};
		default = 9;
		//function = "A3E_fnc_paramDaytime"; // (Optional) Function called when player joins, selected value is passed as an argument
	};
    class Param_TimeMultiplier	
	{	
	    title="Time Multiplier (Fasttime)";
		values[]={1,6,12,24,36};
		texts[]={"1:1 (Normal)","1:6 (Day = 4 Hours)","1:12 (Day = 2 Hours)","1:24 (Day = 1 Hour)","1:36 (Day = 40 Minutes)"};
		default = 6;
	};
    class Param_Weather {
		title="Weather";
		values[] = {0,1,2,3,4,-1};
		texts[] = {"Clear","Overcast","Rain","Fog","Storm","Random"};
		default = -1;
	};
    class Param_UseCustomWeather {
		title="Use Custom Weather";
		values[] = {0,1};
		texts[] = {"Use mission default weather","Use custom weather"};
		default = 0;
	};
    class Param_Spacer2
    {
            title = "==================== Graphics/Rendering Settings ====================";
            values[] = {0};
            texts[] = {""};
            default = 0;
	};
    class Param_Grass
	{	
		title="Grass Visibility (setTerrainGrid)";
        // Low = 50 (NoGrass)
        // Standard = 25
        // High = 12.5
        // Very High = 6.25
        // Ultra = 3.125
		values[]={16,8,4,2,1};
		texts[]={"No Grass (50.0)", "Proximity (25.0)", "Normal (12.5)", "Far (6.25)", "Very Far (3.125)"};
		default = 1;
	};
    class Param_ViewDistance
	{	
		title="View Distance (setViewDistance)";
		values[]={2000,4000,6000,10000};
		texts[]={"Close (2000)", "Normal (4000)", "Far (6000)", "Very Far (10000)"};
		default = 6000;
	};
    class Param_ObjectViewDistance
	{	
		title="Object View Distance (setObjectViewDistance)";
		values[]={1000, 1750, 2500,4000,5000};
		texts[]={"Super Close (1000)", "Close (1750)","Normal (2500)", "Far (4000)", "Very Far (5000)"};
		default = 4000;
	};
	class Param_ShadowViewDistance
	{	
		title="Shadow Draw Distance (setObjectViewDistance)";
		values[]={50,75,100,150,200,500};
		texts[]={"Super Close (50)", "Close (75)","Normal (100)", "Far (150)", "Very Far (200)", "Insane (500)"};
		default = 200;
	};
    class Param_DetailBlend
	{	
		title="Detail Blend Distance (setDetailMapBlendPars)";
		values[]={12,25,50,100,200};
		texts[]={"Super Close (12)","Close (25)", "Normal (50)", "Far (100)", "Very Far (200)"};
		default = 25;
	};
    class Param_Spacer3
    {
            title = "==================== Debug Settings ====================";
            values[] = {0};
            texts[] = {""};
            default = 0;
	};
	class Param_Debug
	{
		title="Debug";
		values[]={0,1};
		texts[]={"Off","On"};
		default = 0;
	};
};
