import openfl.Lib;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxGroup;

var bopAnimStop:Bool = false; // stops the bop anim

var coolBackdrop = new FlxBackdrop(Paths.image('menus/titlescreen/backdrop'));
var bg = new FlxSprite(0, -100).loadGraphic(Paths.image('menus/titlescreen/bg'));
var logo = new FlxSprite(50, -110);
var bar1 = new FlxSprite(0, -30).makeSolid(FlxG.width * 2, 100, 0xFF000000);
var bar2 = new FlxSprite(-640, 660).makeSolid(FlxG.width * 2, 100, 0xFF000000);
var boppers = new FlxSprite(-450, -70);
var funni = new FlxSprite().loadGraphic(Paths.image('menus/titlescreen/BGS'));

function postCreate() {
    funni.alpha = 0.0001;
    remove(titleText);
    boppers.scale.set(0.6,0.6);
    boppers.frames = Paths.getSparrowAtlas('menus/titlescreen/bopboys'); // Remember if you are using addByIndices, make sure to use Paths.getSparrowAtlas not getFrames lmfao
    boppers.animation.addByIndices("bop", "boppers", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], "", 24, false);
    boppers.animation.addByIndices("bopawake", "boppers", [11,12,13], "", 24, false);
    boppers.animation.addByPrefix("awake", "boppers awaken", 24, false);
    boppers.animation.play("bop");
    
    logo.scale.set(0.65,0.65);
    logo.frames = Paths.getFrames('menus/titlescreen/logoBumpin');
    logo.animation.addByPrefix("bump", "logo bumpin", 24, true);
    logo.animation.play("bump");

    coolBackdrop.scale.set(0.7,0.7);
    coolBackdrop.alpha = 0.2;
    coolBackdrop.velocity.set(-200, 0);
    add(bg);
    add(coolBackdrop);
    add(funni);
    add(bar1);
    add(bar2);
    add(boppers);
    add(logo);
    add(titleText);
    if (curBeat < 16) {
        for (i in [bg, coolBackdrop, funni, bar1, bar2, boppers,logo,titleText]) {
            i.visible = false;
            //trace("FUCK THIS WORKS");
        }
    }
    titleText.y = 570;
    Lib.application.window.title = "Friday Night Funkin' - SingStar Challenge";
}

function update(elapsed:Float) {
    if (FlxG.keys.justPressed.ENTER && transitioning && skippedIntro) {
        bopAnimStop = true;
        FlxTween.tween(funni, {alpha: 1}, 0.8, {ease:FlxEase.easeOut});
        //boppers.animation.play("bopawake");
        boppers.animation.play("awake", true);
    }
    if (curBeat == 16 || skippedIntro) {
        for (i in [bg, coolBackdrop, funni, bar1, bar2, boppers,logo,titleText]) {
            i.visible = true;
            //trace("it works lmfao");
        }
    }
}

function stepHit() {
    if (curStep % 2 && !bopAnimStop) {
        boppers.animation.play("bop");
    }
}