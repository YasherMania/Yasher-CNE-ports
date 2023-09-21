import openfl.events.KeyboardEvent;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.ui.Keyboard;
import funkin.backend.system.framerate.Framerate;
import funkin.backend.system.framerate.FramerateCounter;
import openfl.system.System;
import openfl.text.TextFormat;
import openfl.Lib;
import flixel.FlxG;
import funkin.options.Options;

var finalFPS:Float = 0;
var memories = Math.abs(FlxMath.roundDecimal(System.totalMemory / 1000000, 1));
var camFPS = null;
var fpsfunniCounter:FlxText;

var cacheCount:Int;
var currentTime:Float;
var times:Array<Float>;

function create() {
    FlxG.cameras.add(camFPS = new HudCamera(), false);
    camFPS.bgColor = 0;
    fpsfunniCounter = new FlxText(10,10, 400, 18);
    fpsfunniCounter.setFormat("_sans", 14, FlxColor.WHITE, "LEFT");
    fpsfunniCounter.antialiasing = false;
    fpsfunniCounter.scrollFactor.set();
    fpsfunniCounter.cameras = [camFPS];
    add(fpsfunniCounter);
    cacheCount = 0;
    currentTime = 0;
    times = [];
    finalFPS = 0;
}

function update(elapsed:Float) {    
    finalFPS = CoolUtil.fpsLerp(finalFPS, FlxG.elapsed == 0 ? 0 : (1 / FlxG.elapsed), 0.25);
    fpsfunniCounter.text = "FPS: " + Std.string(Math.floor(finalFPS)) + "\nMemory: " + memories + " MB";
    if (memories == 3000 || finalFPS <= FlxG.save.data.Framerate / 2) {
            fpsfunniCounter.color = FlxColor.RED;
        }
}