import funkin.backend.system.github.GitHub;
import funkin.backend.MusicBeatGroup;
import funkin.backend.utils.XMLUtil;
import flixel.util.typeLimit.OneOfThree;
import flixel.util.typeLimit.OneOfTwo;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.sound.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import funkin.backend.system.Conductor;
import openfl.Assets;
import haxe.xml.Access;
import flixel.addons.display.FlxBackdrop;

function create() {
    var coolBackdrop = new FlxBackdrop(Paths.image('menus/titlescreen/BGS'));
    //coolBackdrop.scale.set(2.5,2.5);
    coolBackdrop.velocity.set(-500, 0); // you can adjust the values to make the scrolling faster or slower
    add(coolBackdrop);
    trace(coolBackdrop);
}