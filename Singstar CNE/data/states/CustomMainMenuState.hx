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
import funkin.options.OptionsMenu;
import funkin.menus.credits.CreditsMain;
import funkin.editors.EditorPicker;
import Sys;

var optionShit:Array<String> = ["story","freeplay", "options", "credits","quit"];
var curSelected:Int = 0;
var menuItems:FlxTypedGroup<FlxSprite>;
var menuItems = new FlxTypedGroup();
var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
var selectedSomethin:Bool = false;
var camFollowPos:FlxObject;
public var canAccessDebugMenus:Bool = true;

function create() {

    camFollow = new FlxObject(0, 0, 1, 1);
    camFollowPos = new FlxObject(0, 0, 1, 1);
    add(camFollow);
    add(camFollowPos);

    DiscordUtil.changePresence("In the Menus", null);
    CoolUtil.playMenuSong();
    bg = new FlxSprite(-80).loadGraphic(Paths.image('menus/mMBG'));
    bg.setGraphicSize(FlxG.width, FlxG.height);
    bg.antialiasing = false;
    bg.scrollFactor.set(0, 0);
    bg.scale.set(0.75, 0.75);
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
    backdro.scale.set(0.7, 0.7);
    backdro.velocity.set(90 * 2, 0);
    backdro.y = 56 * 2;
    backdro.alpha = 0.27;
    backdro.color = 0xFF000000;
    add(backdro);

    add(menuItems);
    for (i in 0...optionShit.length) {
        var option = optionShit[i];
        var offset:Float = 218 - (Math.max(optionShit.length, 4) - 4) * 80;
        var menuItem = new FlxSprite((i * 350) + offset, i);
        menuItem.frames = Paths.getFrames('menus/mainmenu/' + option);
        menuItem.animation.addByPrefix('idle', optionShit[i] + " static", 24);
        menuItem.animation.addByPrefix('selected', optionShit[i] + " selected", 24);
        menuItem.setGraphicSize(Std.int(bg.width * 0.37));
        menuItem.animation.play('idle');
        menuItem.scale.set(0.7,0.7);
        menuItem.ID = i;
        menuItems.add(menuItem);
        menuItem.scrollFactor.set();
        menuItem.antialiasing = true;
        menuItem.updateHitbox();
    }

    FlxG.camera.follow(camFollowPos, null, 1);

    var logo:FlxSprite = new FlxSprite(720, 10);
    logo.frames = Paths.getFrames('menus/logo');
    logo.animation.addByPrefix('idle', "logo bumpin", 24, true);
    logo.animation.play('idle');
    logo.centerOrigin();
    logo.scale.x = 0.6;
    logo.scale.y = 0.6;
    logo.scrollFactor.set(0, 0);
    logo.updateHitbox();
    logo.antialiasing = true;
    add(logo);

    changeItem();
}


function update(elapsed:Float) {
    var lerpVal:Float = FlxMath.bound(elapsed * 7.5, 0, 1);
    camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));
    if(FlxG.keys.justPressed.ESCAPE) {
        FlxG.switchState(new TitleState());
    }
    if (FlxG.sound.music.volume < 0.8)
        FlxG.sound.music.volume += 0.5 * elapsed;
    if (!selectedSomethin) {
        if (canAccessDebugMenus) {
            if (FlxG.keys.justPressed.SEVEN) {
                persistentUpdate = false;
                persistentDraw = true;
                openSubState(new EditorPicker());
            }
        }
        if (controls.LEFT_P)
            changeItem(-1);

        if (controls.RIGHT_P)
            changeItem(1);

        if (controls.ACCEPT)
        {
            selectItem();
        }
    }
    menuItems.forEach(function(spr:FlxSprite)
		{
			if (spr.ID <= 1) {
				spr.screenCenter(FlxAxes.Y);
				spr.y += 50;
			} else {
				switch(spr.ID) {
                    case 1:
                        spr.y = 800;
					case 2:
						spr.y = 200;
					case 3:
						spr.y = 200 * 1.8;
						spr.x = 838 * 1;
					case 4:
						spr.x = 838 * 1.050;
						spr.y = 250 * 2;
				}	
			}
		});
}

function selectItem() {
    selectedSomethin = true;

	FlxG.sound.play(Paths.sound('menu/confirm'));
    
    menuItems.forEach(function(spr:FlxSprite) {
        if (curSelected != spr.ID)
            {
                FlxTween.tween(spr, {alpha: 0}, 0.8, {
                    ease: FlxEase.quadOut,
                    onComplete: function(twn:FlxTween)
                    {
                        spr.kill();
                    }
                });
            }
    });

    if (Options.flashingMenu) FlxFlicker.flicker(magenta, 1.1, 0.15, false);

    FlxFlicker.flicker(menuItems.members[curSelected], 1, Options.flashingMenu ? 0.06 : 0.15, false, false, function(flick:FlxFlicker)
    {
        var daChoice:String = optionShit[curSelected];

        var event = event("onSelectItem", EventManager.get(NameEvent).recycle(daChoice));
        if (event.cancelled) return;
        switch (daChoice) 
        {
            case 'story':
                FlxG.switchState(new StoryMenuState());
                trace("Story Mode Selected");

            case 'freeplay':
                FlxG.switchState(new FreeplayState());
                trace("Freeplay Selected");

            case 'options':
                FlxG.switchState(new OptionsMenu());
                trace("Options Selected");
            case 'credits':
                FlxG.switchState(new CreditsMain());
                trace("Credits Selected");
            case 'quit':
                Sys.exit(0);
                trace("Quit Selected");
        }
    });
}

function changeItem(huh:Int = 0) {
    var event = event("onChangeItem", EventManager.get(MenuChangeEvent).recycle(curSelected, FlxMath.wrap(curSelected + huh, 0, menuItems.length-1), huh, huh != 0));
    if (event.cancelled) return;

    curSelected = event.value;

    if (event.playMenuSFX)
        CoolUtil.playMenuSFX("SCROLL", 0.7);

    menuItems.forEach(function(spr:FlxSprite) {
    spr.animation.play('idle');
        
    if (spr.ID == curSelected) {
        spr.animation.play('selected');
        var mid = spr.getGraphicMidpoint();
        camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
        mid.put();
    }

    spr.updateHitbox();
    spr.centerOffsets();
});
}