import lime.ui.Window;
import flixel.FlxCamera;
import openfl.display.Stage;
import openfl.Lib;

var window = Window;
var stagepath:String = "stages/fatal/";
var ofs:Int = 30;
var winOfsX:Int = 0;
var winOfsY:Int = 0;
var ogWindowY:Int = 0;
var ogWindowX:Int = 0;
var zoomies:Float = 0;

function create() {
    FlxG.resizeWindow(1000, 750);
    FlxG.scaleMode.width = 1280;
    FlxG.scaleMode.height = 960;
    gf.visible = false;
    remove(boyfriend);
    remove(dad);

    defaultCamZoom = 1.2;

    bg = new FlxSprite(-780, -133).loadGraphic(Paths.image(stagepath + "bg"));
    bg.antialiasing = true;
    bg.scrollFactor.set(1.5, 0.1);
    add(bg);

    floor = new FlxSprite(-22, 314).loadGraphic(Paths.image(stagepath + "floor"));
    floor.updateHitbox();
    floor.antialiasing = true;
    floor.scrollFactor.set(0.8, 0.8);
    floor.active = false;
    add(floor);

    bar1 = new FlxSprite(0, -90).makeSolid(FlxG.width * 2, 300, 0xFF000000);
    bar1.updateHitbox();
    bar1.angle = 4;
    bar1.scrollFactor.set(0, 0.2);
    bar1.antialiasing = true;
    add(bar1);

    bar2 = new FlxSprite(0, -90).makeSolid(FlxG.width * 2, 300, 0xFF000000);
    bar2.scrollFactor.set(0, 0.2);
    bar2.updateHitbox();
    bar2.angle = 2;
    bar2.antialiasing = true;
    add(bar2);

    icon = new FlxSprite(423, -195).loadGraphic(Paths.image(stagepath + "icon"));
    icon.updateHitbox();
    icon.antialiasing = true;
    icon.scrollFactor.set(1,1);
    icon.active = false;
    add(icon);

    add(dad);
    add(boyfriend);
    changePlayerSkin("fatalnotes");
}

var strumY:Int = -69;

function postCreate() {
    if (downscroll) {
        strumY = 670;
    }

    for (i in 0...cpuStrums.length) {
        cpuStrums.members[i].screenCenter(FlxAxes.X);
        if (downscroll) {
            cpuStrums.members[i].x = -150;
            cpuStrums.members[i].angle = 90;
        } else {
            cpuStrums.members[i].x = 1300;
            cpuStrums.members[i].angle = 90;
        }
    }

    for (i in 0...playerStrums.length) {
       // playerStrums.members[i].x = Std.int(Window.x / 2) + ((i - (4 / 2)) * Note.swagWidth);
        playerStrums.members[i].x = Std.int(1280 / 2) + ((i - (4 / 2)) * Note.swagWidth);
        trace(playerStrums.members[i].x);
        //playerStrums.members[i].y = strumY;
    }

    dad.x = 582;
	dad.y = -45;

    ogWindowX = Lib.application.window.x;
	ogWindowY = Lib.application.window.y;

    healthBar.visible = false;
	healthBarBG.visible = false;
	iconP2.visible = false;
	iconP1.visible = false;
	scoreTxt.visible = false;
    accuracyTxt.visible = false;
    missesTxt.visible = false;

    boyfriend.scrollFactor.set(2, 1.5);
    dad.scrollFactor.set(0.8, 0.8);
    changePlayerSkin();
}

function changePlayerSkin() {
	frames = Paths.getSparrowAtlas("game/notes/fatalnotes");

	for (strum in cpuStrums) {
		strum.frames = frames;
		strum.animation.addByPrefix("static", "arrowUP");
		strum.animation.addByPrefix("blue", "arrowDOWN");
		strum.animation.addByPrefix("purple", "arrowLEFT");
		strum.animation.addByPrefix("red", "arrowRIGHT");

		strum.antialiasing = true;
		strum.setGraphicSize(Std.int(frames.width * 0.7));

		var animPrefix = cpuStrums.strumAnimPrefix[strum.ID % cpuStrums.strumAnimPrefix.length];
		strum.animation.addByPrefix("static", "arrow" + animPrefix.toUpperCase());
		strum.animation.addByPrefix("pressed", animPrefix + " press", 24, false);
		strum.animation.addByPrefix("confirm", animPrefix + " confirm", 24, false);

		strum.updateHitbox();
		strum.playAnim("static");
	}

	for (note in cpuStrums.notes) {
		note.frames = frames;

		switch (note.noteData % 4) {
			case 0:
				note.animation.addByPrefix("scroll", "purple0");
				note.animation.addByPrefix("hold", "purple hold piece");
				note.animation.addByPrefix("holdend", "pruple end hold");
			case 1:
				note.animation.addByPrefix("scroll", "blue0");
				note.animation.addByPrefix("hold", "blue hold piece");
				note.animation.addByPrefix("holdend", "blue hold end");
			case 2:
				note.animation.addByPrefix("scroll", "green0");
				note.animation.addByPrefix("hold", "green hold piece");
				note.animation.addByPrefix("holdend", "green hold end");
			case 3:
				note.animation.addByPrefix("scroll", "red0");
				note.animation.addByPrefix("hold", "red hold piece");
				note.animation.addByPrefix("holdend", "red hold end");
		}

		note.scale.set(0.7, 0.7);
		note.antialiasing = true;
		note.updateHitbox();

		if (note.isSustainNote) {
			note.animation.play("holdend");
			note.updateHitbox();

			if (note.nextSustain != null)
				note.animation.play('hold');
		} else
			note.animation.play("scroll");
	}
}

function postUpdate() {
    PlayState.instance.comboGroup.cameras = [camHUD];
    PlayState.instance.comboGroup.scale.set(0.5,0.5);
    PlayState.instance.comboGroup.visible = false;
    add(PlayState.instance.comboGroup);
}

function windowMovement(cum) {
	
	var curWindowY:Int = 0;
	var nextWindowY:Int = 0;
	var windowY:Int = 0;

	var curWindowX:Int = 0;
	var nextWindowX:Int = 0;
	var windowX:Int = 0;

	curWindowY = window.y;
	nextWindowY = ogWindowY + winOfsY;
	windowY = FlxMath.lerp(curWindowY, nextWindowY, cum);

	curWindowX = window.x;
	nextWindowX = ogWindowX + winOfsX;
	windowX = FlxMath.lerp(curWindowX, nextWindowX, cum);

	//window.move(windowX, windowY);
    Lib.application.window.move(windowX, windowY);
    //trace(windowX);

	switch(dad.animation.curAnim.name) {
		case "singLEFT":
				winOfsX = -30;
				winOfsY = 0;
                Lib.application.window.title = "Friday Night Funkin' - Left";
		case "singRIGHT":
				winOfsX = 30;
				winOfsY = 0;
                Lib.application.window.title = "Friday Night Funkin' - Right";
		case "singUP":
				winOfsX = 0;
				winOfsY = -30;
                Lib.application.window.title = "Friday Night Funkin' - Up";
		case "singDOWN":
				winOfsX = 0;
				winOfsY = 30;
                Lib.application.window.title = "Friday Night Funkin' - Down";
        case "idle":
				winOfsX = 0;
				winOfsY = 0;
                Lib.application.window.title = "Friday Night Funkin' - Fatal Error";
	}
}

function update(elapsed:Float) {
    zoomies = camGame.zoom / 0.57;
    windowMovement(1);
    autoCamZooming = false;
    boyfriend.scale.set(zoomies * 0.5, zoomies * 0.5);
    boyfriend.x = -755 / zoomies;
	boyfriend.y = -250 / zoomies;
    bg.scale.set(zoomies * 0.5, zoomies * 0.5);

    if (!curCameraTarget) {
        camFollow.setPosition(400, 120);
        defaultCamZoom = 1.2;

        switch(boyfriend.animation.curAnim.name) {
                case "singLEFT":
                        camFollow.x = camFollow.x - ofs;
                case "singRIGHT":
                        camFollow.x = camFollow.x + ofs;
                case "singUP":
                        camFollow.y = camFollow.y - ofs;
                case "singDOWN":
                        camFollow.y = camFollow.y + ofs;
            }
} else {
        camFollow.setPosition(550, 127);
        defaultCamZoom = 1.6;

        switch(dad.animation.curAnim.name) {
                case "singLEFT":
                        camFollow.x = camFollow.x - ofs;
                case "singRIGHT":
                        camFollow.x = camFollow.x + ofs;
                case "singUP":
                        camFollow.y = camFollow.y - ofs;
                case "singDOWN":
                        camFollow.y = camFollow.y + ofs;
            }
}

}


function beatHit(curBeat) {
	if (curBeat % 2 == 0){
        camHUD.zoom += 0.03;
	}
}


function destroy() {
    FlxG.resizeWindow(1280, 720);
    FlxG.scaleMode.width = 1280;
    FlxG.scaleMode.height = 720;
}