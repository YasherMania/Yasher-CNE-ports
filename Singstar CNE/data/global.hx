import funkin.backend.utils.NativeAPI;

var redirectStates:Map<FlxState, String> = [
    MainMenuState => "CustomMainMenuState",
    StoryMenuState => "CustomStoryMenuState",
];

function preStateSwitch() {
    for (redirectState in redirectStates.keys()) 
        if (Std.isOfType(FlxG.game._requestedState, redirectState)) 
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}

function update(elapsed:Float) {
    if (FlxG.keys.justPressed.F6)
        NativeAPI.allocConsole();
    if (FlxG.keys.justPressed.F5)
        FlxG.resetState();
}