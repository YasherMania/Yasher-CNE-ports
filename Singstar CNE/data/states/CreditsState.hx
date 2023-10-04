import funkin.backend.utils.DiscordUtil;
import funkin.backend.scripting.events.DiscordPresenceUpdateEvent;
import discord_rpc.DiscordRpc;
import funkin.menus.MainMenuState;
import funkin.backend.scripting.events.MenuChangeEvent;
import funkin.backend.scripting.events.NameEvent;
import funkin.backend.scripting.EventManager;
import flixel.effects.FlxFlicker;
import funkin.backend.utils.CoolUtil;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import flixel.addons.display.FlxBackdrop;
import flixel.FlxObject;
import funkin.menus.credits.CreditsMain;
import funkin.backend.scripting.events.FreeplayAlphaUpdateEvent;
import funkin.backend.utils.FlxInterpolateColor;
import funkin.menus.FreeplayState.FreeplaySonglist;
import flixel.util.FlxColor;

var iconArray:Array<HealthIcon> = [];
var interpColor:FlxInterpolateColor;
var credits:Array<String> = ["Binej Yeah", "Zibidi", "EJ", "Requiem", "Zavemann", "Kevin Kuntz", "Yasher"];
var creditColours:Array<FlxColor> = ["13553358", "5921370", "16757760", "10254349", "11053224", "8677154", "6431428"];
var creditDesc:Array<String> = ["Main Liquid Artist of Singstar Challenge", "Main Solid Artist of Singstar Challenge", "Main Composer of Singstar Challenge", "Menu/Game Over Composer of Singstar Challenge", "Assistant Composer of Singstar Challenge", "Main Programmer of Singstar Challenge", "Main Programmer for CNE Singstar Challenge port"];
var creditlinks:Array<String> = ["https://binejyeah.newgrounds.com", "https://zibidi.newgrounds.com", "https://twitter.com/ESimplyJ", "https://thereq.newgrounds.com", "https://twitter.com/ZavemannVA","https://kevinkuntz.newgrounds.com", "https://twitter.com/Yashermania"];
var menuItems:FlxTypedGroup<Alphabet>;
var selectedSomethin:Bool = false;
var curSelected:Int = 0;
var canSelect:Bool = true;
var songInstPlaying:Bool = true;

function create() {
    DiscordUtil.changePresence("In the Credits", null);
    CoolUtil.playMenuSong();
    bg = new FlxSprite(-80).loadGraphic(Paths.image('menus/menuDesat'));
    bg.setGraphicSize(FlxG.width, FlxG.height);
    bg.antialiasing = false;
    bg.scrollFactor.set(0, 0);
    //bg.color = 0xFF00FFFF;
    bg.scale.set(1,1.01);
    bg.screenCenter();
    bg.updateHitbox();
    bg.y /= 2;
    bg.x /= 2;
    add(bg);

    magenta = new FlxSprite().loadGraphic(Paths.image('menus/menuDesat'));
    magenta.scrollFactor.set(0, 0);
    magenta.visible = false;
    magenta.color = 0xFFfd719b;
    add(magenta);

    backdro = new FlxBackdrop(Paths.image('menus/titlescreen/backdrop'));
    backdro.scale.set(0.8, 0.8);
    backdro.velocity.set(50 * 2, 65);
    backdro.y = 56 * 2;
    backdro.alpha = 0.27;
    backdro.color = 0xFF000000;
    add(backdro);

    menuItems = new FlxTypedGroup();
    add(menuItems);
    for (i in 0...credits.length) {
        var creditText:Alphabet = new Alphabet(0, (70 * i) + 30, credits[i], true, false);
        creditText.isMenuItem = true;
        creditText.targetY = i;
        menuItems.add(creditText);

        var icon:HealthIcon = new HealthIcon("credits/" + credits[i]);
        icon.sprTracker = creditText;

        iconArray.push(icon);
        add(icon);
    }

    box = new FlxSprite(0, 600);
    box.makeGraphic(1000, 100, FlxColor.BLACK);
    box.scrollFactor.set(0,0);
    box.alpha = 0.6;
    box.screenCenter(FlxAxes.X);
    box.updateHitbox();
    add(box);

    boxtext = new FlxText(0,box.y + 35, FlxG.width ,"?", 32);
    boxtext.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, "center");
    boxtext.screenCenter(FlxAxes.X);
    add(boxtext);

    what = new Alphabet(900, 100, "Credits", true, false);
    add(what);

    changeSelection(0, true);
    interpColor = new FlxInterpolateColor(bg.color);
}

function update(elapsed:Float) {
    if(FlxG.keys.justPressed.ESCAPE) {
        FlxG.switchState(new MainMenuState());
    }
    if (canSelect) {
        changeSelection((controls.UP_P ? -1 : 0) + (controls.DOWN_P ? 1 : 0));
        updateOptionsAlpha();
    }
    if (controls.ACCEPT) {
        select();
    }
    interpColor.fpsLerpTo(creditColours[curSelected], 0.0625);
    bg.color = interpColor.color;
    boxtext.text = creditDesc[curSelected];
}

function select() {
	FlxG.sound.play(Paths.sound('menu/confirm'));
    trace("YAY!");
    CoolUtil.openURL(creditlinks[curSelected]);
}

function changeSelection(change:Int = 0, force:Bool = false) {
	if (change == 0 && !force) return;

	var event = event("onChangeSelection", EventManager.get(MenuChangeEvent).recycle(curSelected, FlxMath.wrap(curSelected + change, 0, credits.length-1), change));
	if (event.cancelled) return;

	curSelected = event.value;
	if (event.playMenuSFX) CoolUtil.playMenuSFX("SCROLL", 0.7);
    trace(bg.color);
}

function updateOptionsAlpha() {
    var event = event("onUpdateOptionsAlpha", EventManager.get(FreeplayAlphaUpdateEvent).recycle(0.6, 0.45, 1, 1, 0.25));
    if (event.cancelled) return;

    var bullShit:Int = 0;

    for (i in 0...iconArray.length)
        iconArray[i].alpha = lerp(iconArray[i].alpha, #if PRELOAD_ALL songInstPlaying ? event.idlePlayingAlpha : #end event.idleAlpha, event.lerp);

    iconArray[curSelected].alpha = #if PRELOAD_ALL songInstPlaying ? event.selectedPlayingAlpha : #end event.selectedAlpha;

    for (item in menuItems.members)
    {
        item.targetY = bullShit - curSelected;
        bullShit++;

        item.alpha = lerp(item.alpha, #if PRELOAD_ALL songInstPlaying ? event.idlePlayingAlpha : #end event.idleAlpha, event.lerp);

        if (item.targetY == 0)
            item.alpha =  #if PRELOAD_ALL songInstPlaying ? event.selectedPlayingAlpha : #end event.selectedAlpha;
    }
}

function onUpdateOptionsAlpha(event) {
    event.idleAlpha = 0.7;
    event.idlePlayingAlpha = 0.7;
}