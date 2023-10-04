import funkin.backend.utils.DiscordUtil;
import funkin.backend.scripting.events.DiscordPresenceUpdateEvent;
import discord_rpc.DiscordRpc;
import funkin.menus.MainMenuState;
import funkin.backend.scripting.events.MenuChangeEvent;
import funkin.backend.scripting.events.NameEvent;
import funkin.backend.scripting.EventManager;
import flixel.util.FlxTimer;
import flixel.math.FlxPoint;
import flixel.addons.display.FlxBackdrop;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import funkin.backend.FunkinText;
import flixel.text.FlxText;
import funkin.savedata.FunkinSave;
import haxe.io.Path;

var characters:Map<String, MenuCharacter> = [];
var weeks:Array<WeekData> = [];
var scoreText:FlxText;
var weekTitle:FlxText;
var curDifficulty:Int = 0;
var curWeek:Int = 0;
var weekBG:FlxSprite;
var leftArrow:FlxSprite;
var rightArrow:FlxSprite;
var blackBar:FlxSprite;
var lerpScore:Float = 0;
var intendedScore:Int = 0;
var canSelect:Bool = true;


function create() {
    blackBar = new FlxSprite(0, 0).makeSolid(FlxG.width, 56, 0xFFFFFFFF);
    blackBar.color = 0xFF000000;
    blackBar.updateHitbox();

    scoreText = new FunkinText(10, 680, 0, "WEEK SCORE: 0", 36);
    scoreText.setFormat(Paths.font("vcr.ttf"), 32);

    weekTitle = new FlxText(10, 10, FlxG.width - 20, "", 32);
    weekTitle.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, "right");
    weekTitle.alpha = 0.7;

    weekBG = new FlxBackdrop(Paths.image('menus/titlescreen/backdrop'));
    weekBG.color = 0xFFF9CF51;
    weekBG.velocity.set(90 * 2, 0);
    weekBG.updateHitbox();

    for(e in [blackBar, weekTitle, weekBG, scoreText]) {
        e.scrollFactor.set();
        add(e);
    }
}


function update(elapsed:Float) {
    if(FlxG.keys.justPressed.ESCAPE) {
        FlxG.switchState(new MainMenuState());
    }
}
