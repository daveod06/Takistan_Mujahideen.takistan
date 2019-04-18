class CfgSounds
{
    sounds[] = {Soviet_National_Anthem,Back_In_The_USSR,Who_Will_Save_The_World,Afghan_Music,Yugo_Soviet_Pop};
	class Soviet_National_Anthem
	{
		name = "Soviet_National_Anthem";
		sound[] = {"\sounds\Soviet_National_Anthem.ogg", 5.0, 1, 150};
		titles[] = {1, ""};
	};
    class Back_In_The_USSR
	{
		name = "Back_In_The_USSR";
		sound[] = {"\music\Back_In_The_USSR.ogg", 5.0, 1, 150};
		titles[] = {1, ""};
	};
    class Who_Will_Save_The_World
	{
		name = "Who_Will_Save_The_World";
		sound[] = {"\sounds\Who_Will_Save_The_World.ogg", 5.0, 1, 150};
		titles[] = {1, ""};
	};
    class Afghan_Music
	{
		name = "";
		sound[] = {"\sounds\Afghan_Music.ogg", 5.0, 1, 150};
		titles[] = {1, ""};
	};
    class Yugo_Soviet_Pop
	{
		name = "Yugo_Soviet_Pop";
		sound[] = {"\sounds\Yugo_Soviet_Pop.ogg", 5.0, 1, 150};
		titles[] = {1, ""};
	};
    class Soviet_Thrash_Metal
    {
        name = "Soviet_Thrash_Metal";
        sound[] = {"\sounds\Soviet_Thrash_Metal.ogg", 5.0, 1, 150};
        titles[] = {1, ""};
    };
};

class CfgSFX
{
    sounds[] = {Soviet_National_Anthem_SFX,Back_In_The_USSR_SFX};
    class Soviet_National_Anthem_SFX
    {
        name = "Soviet_National_Anthem_SFX";
        sound0[] = {"\sounds\Soviet_National_Anthem.ogg", db-1, 1.0, 150, 1, 0, 0, 0};
        sounds[] = {sound0};
        empty[] = {"", 0, 0, 0, 0, 0, 0, 0};
    };
    class Back_In_The_USSR_SFX
    {
        name = "Back_In_The_USSR_SFX";
        sound0[] = {"\music\Back_In_The_USSR.ogg", db-1, 1.0, 150, 1, 0, 0, 0};
        sounds[] = {sound0};
        empty[] = {"", 0, 0, 0, 0, 0, 0, 0};
    };
    class Who_Will_Save_The_World_SFX
    {
        name = "Who_Will_Save_The_World_SFX";
        sound0[] = {"\sounds\Who_Will_Save_The_World.ogg", db-1, 1.0, 150, 1, 0, 0, 0};
        sounds[] = {sound0};
        empty[] = {"", 0, 0, 0, 0, 0, 0, 0};
    };
    class Afghan_Music_SFX
    {
        name = "Afghan_Music_SFX";
        sound0[] = {"\sounds\Afghan_Music.ogg", db-1, 1.0, 150, 1, 0, 0, 0};
        sounds[] = {sound0};
        empty[] = {"", 0, 0, 0, 0, 0, 0, 0};
    };
    class Yugo_Soviet_Pop_SFX
    {
        name = "Yugo_Soviet_Pop_SFX";
        sound0[] = {"\sounds\Yugo_Soviet_Pop.ogg", db-1, 1.0, 150, 1, 0, 0, 0};
        sounds[] = {sound0};
        empty[] = {"", 0, 0, 0, 0, 0, 0, 0};
    };
    class Soviet_Thrash_Metal_SFX
    {
        name = "Soviet_Thrash_Metal_SFX";
        sound0[] = {"\sounds\Soviet_Thrash_Metal.ogg", db-1, 1.0, 150, 1, 0, 0, 0};
        sounds[] = {sound0};
        empty[] = {"", 0, 0, 0, 0, 0, 0, 0};
    };
};

class CfgVehicles
{
    class Soviet_National_Anthem_SFXSound // class name to be used with createSoundSource
    {
        sound = "Soviet_National_Anthem_SFX"; // reference to CfgSFX class
    };
    class Back_In_The_USSR_SFXSound // class name to be used with createSoundSource
    {
        sound = "Back_In_The_USSR_SFX"; // reference to CfgSFX class
    };
    class Who_Will_Save_The_World_SFXSound // class name to be used with createSoundSource
    {
        sound = "Who_Will_Save_The_World_SFX"; // reference to CfgSFX class
    };
    class Afghan_Music_SFXSound // class name to be used with createSoundSource
    {
        sound = "Afghan_Music_SFX"; // reference to CfgSFX class
    };
    class Yugo_Soviet_Pop_SFXSound // class name to be used with createSoundSource
    {
        sound = "Yugo_Soviet_Pop_SFX"; // reference to CfgSFX class
    };
    class Soviet_Thrash_Metal_SFXSound // class name to be used with createSoundSource
    {
        sound = "Soviet_Thrash_Metal_SFX"; // reference to CfgSFX class
    };
};
