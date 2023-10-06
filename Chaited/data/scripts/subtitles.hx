//IMPROVED ALOT LOL! - Sup3rZ6
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.text.FlxText;
import flixel.text.FlxTextBorderStyle;
import flixel.util.FlxColor;
import flixel.math.FlxMath;
import funkin.game.HudCamera;
import funkin.game.PlayState;
import funkin.game.Character;
import funkin.game.HealthIcon;
import haxe.io.Path;
import openfl.Lib;

var subtitleText:FlxText;

//Probably a smarter way to do this... but im stupid! - Sup3rZ6
var iconP1DECOY:FlxSprite; //bf
var iconP2DECOY:FlxSprite; //dad
var iconP3DECOY:FlxSprite; //gf

var subtitleWords:String="";

public var scaleInTime:Float=0.2;

//Weird ass Codename Bug so ima use this method for now.
public var dadIcon:String="dad";
public var gfIcon:String="face";

function create(){
    subtitleText = new FlxText(0, 0, FlxG.width, "");
    subtitleText.setFormat(Paths.font('pixelcomicsans.ttf'), 35, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, 0xFF000000);
    subtitleText.screenCenter();
    subtitleText.cameras = [camHUD];
    subtitleText.borderSize = 2;
    subtitleText.alpha = 1;
    add(subtitleText);

    iconP1DECOY = new FlxSprite(0, 0);
    iconP1DECOY.loadGraphic(Paths.image('icons/'+boyfriend.icon), true, 150, 150);
    iconP1DECOY.cameras = [camHUD];
    iconP1DECOY.antialiasing = true;
    iconP1DECOY.flipX = true;
    iconP1DECOY.visible = false;
    iconP1DECOY.scale.x=iconP1DECOY.scale.y=1.1;
    iconP1DECOY.screenCenter();
    iconP1DECOY.y=125;
    add(iconP1DECOY);

    //Can someone explain to me why tf does "dad.icon" & "gf.icon" not work but "boyfriend.icon" does?
    iconP2DECOY = new FlxSprite(0, 0);
    iconP2DECOY.loadGraphic(Paths.image('icons/'+dadIcon), true, 150, 150);
    iconP2DECOY.cameras = [camHUD];
    iconP2DECOY.antialiasing = true;
    iconP2DECOY.flipX = false;
    iconP2DECOY.visible = false;
    iconP2DECOY.scale.x=iconP2DECOY.scale.y=1.1;
    iconP2DECOY.screenCenter();
    iconP2DECOY.y=125;
    add(iconP2DECOY);

    iconP3DECOY = new FlxSprite(0, 0);
    iconP3DECOY.loadGraphic(Paths.image('icons/'+gfIcon), true, 150, 150);
    iconP3DECOY.cameras = [camHUD];
    iconP3DECOY.antialiasing = true;
    iconP3DECOY.flipX = true;
    iconP3DECOY.visible = false;
    iconP3DECOY.scale.x=iconP3DECOY.scale.y=1.1;
    iconP3DECOY.screenCenter();
    iconP3DECOY.y=125;
    add(iconP3DECOY);
}

public function reloadDecoyIcons(){
    iconP1DECOY.loadGraphic(Paths.image('icons/'+boyfriend.icon), true, 150, 150);
    iconP2DECOY.loadGraphic(Paths.image('icons/'+dadIcon), true, 150, 150);
    iconP3DECOY.loadGraphic(Paths.image('icons/'+gfIcon), true, 150, 150);

    iconP1DECOY.screenCenter();
    iconP2DECOY.screenCenter();
    iconP3DECOY.screenCenter();

    iconP1DECOY.y=125;
    iconP2DECOY.y=125;
    iconP3DECOY.y=125;
}

public function subtitles(funnyText:String="", funnyColor:FlxColor=FlxColor.WHITE, iconSinging:String=null){
    subtitleText.color=funnyColor;
    subtitleText.scale.x = 1.2;
    subtitleText.scale.y = 1.2;
    subtitleText.text = funnyText;
    subtitleText.screenCenter();
    subtitleText.y=125;

    iconP1DECOY.scale.x=1.1;
    iconP1DECOY.scale.y=1.1;

    iconP2DECOY.scale.x=1.1;
    iconP1DECOY.scale.y=1.1;

    iconP3DECOY.scale.x=1.1;
    iconP1DECOY.scale.y=1.1;

    //I LOVE CASES I LOVE CASES I LOVE CASES!!
    switch(iconSinging){
        case "P1" | "Player":
            iconP1DECOY.visible=true;
            iconP2DECOY.visible=false;
            iconP3DECOY.visible=false;
        case "P2" | "Oppenent":
            iconP2DECOY.visible=true;
            iconP1DECOY.visible=false;
            iconP3DECOY.visible=false;
        case "P3" | "Additonal":
            iconP3DECOY.visible=true;
            iconP2DECOY.visible=false;
            iconP1DECOY.visible=false;
        case "None" | null:
            iconP1DECOY.visible=false;
            iconP2DECOY.visible=false;
            iconP3DECOY.visible=false;
    }

    FlxTween.tween(iconP1DECOY.scale, {x: 0.7, y: 0.7}, scaleInTime, {ease: FlxEase.circOut});
    FlxTween.tween(iconP2DECOY.scale, {x: 0.7, y: 0.7}, scaleInTime, {ease: FlxEase.circOut});
    FlxTween.tween(iconP3DECOY.scale, {x: 0.7, y: 0.7}, scaleInTime, {ease: FlxEase.circOut});

    FlxTween.tween(subtitleText.scale, {x: 1, y: 1}, scaleInTime, {ease: FlxEase.circOut});
}

//For when u want to change color rapidly or smth.
public function changeSubtitleColor(leColor:FlxColor=WHITE){
    subtitleText.color=leColor;
}