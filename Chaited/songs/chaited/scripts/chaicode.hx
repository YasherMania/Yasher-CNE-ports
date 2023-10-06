importScript('data/scripts/subtitles');
var imshitting:FlxSprite;

function create() {
    imshitting = new FlxSprite().makeGraphic(1280,720, 0xFF000000);
    imshitting.cameras = [camHUD];
    imshitting.scrollFactor.set(0,0);
    add(imshitting);
}

function postCreate() {
    iconP2.alpha = 0.000001;
}

function onSongStart() {
    FlxTween.tween(imshitting, {alpha: 0}, 7 ,{ease:FlxEase.linear});
}

function update() {
    if (curBeat >= 62 && curBeat <= 238) {
        iconP2.alpha = 1;
    }

    if (curBeat == 912 ) {
        FlxTween.tween(strumLines.members[3].characters[0], {alpha: 0.00001}, 1 , {ease:FlxEase.cubeIn});
        gf.alpha = 0;
        FlxTween.tween(iconP2, {alpha: 0.00001}, 1, {ease:FlxEase.cubeIn});
    }
}

function onDadHit(event) {
    if (health > 0.1) event.healthGain += 0.02;
}

function stepHit() {
    var goldenColor = (strumLines.members[3].characters[0] != null && strumLines.members[3].characters[0].xml != null && strumLines.members[3].characters[0].xml.exists("color")) ? CoolUtil.getColorFromDynamic(strumLines.members[3].characters[0].xml.get("color")) : 0xFFFF0000;
    var dadColor = (dad != null && dad.xml != null && dad.xml.exists("color")) ? CoolUtil.getColorFromDynamic(dad.xml.get("color")) : 0xFFFF0000;
    var tangleColor = (gf != null && gf.xml != null && gf.xml.exists("color")) ? CoolUtil.getColorFromDynamic(gf.xml.get("color")) : 0xFFFF0000;
    switch (curStep) {
        case 380:
            subtitles("BO", FlxColor.WHITE, null);
        case 384:
            subtitles("BORING", FlxColor.WHITE, null);
        case 389:
            subtitles(" ", FlxColor.WHITE, null);
        case 600:
            subtitles("PLAY", FlxColor.WHITE, null);
        case 604:
            subtitles("PLAY-TIME", FlxColor.WHITE, null);
        case 609:
            subtitles(" ", FlxColor.WHITE, null);
        case 767:
            dad.alpha = 0.00001;
            FlxG.camera.flash(FlxColor.WHITE, 2);
            strumLines.members[3].visible = true;
            strumLines.members[3].characters[0].visible = true;
            iconP2.loadGraphic(Paths.image('icons/gsoner'), true, 150, 150);
            iconP2.animation.add("char", [for(i in 0...iconP1.frames.frames.length) i], 0, false);
            iconP2.antialiasing = true;
            iconP2.animation.play("char");
            healthBar.createFilledBar(goldenColor,0xFF993399);
            healthBar.updateFilledBar();
            dad.visible = false;
        case 880:
            FlxTween.tween(FlxG.camera, {zoom: 0.9}, 0.5, {ease:FlxEase.sineIn});
            defaultCamZoom = 0.9;
        case 896:
            FlxTween.tween(FlxG.camera, {zoom: 0.85}, 0.1, {ease:FlxEase.sineIn});
            FlxTween.tween(strumLines.members[3].characters[0], {alpha: 0.00001}, 2, {ease:FlxEase.sineOut});
        case 1034:
            strumLines.members[3].visible = false;
            strumLines.members[3].characters[0].visible = false;
            strumLines.members[4].visible = true;
            strumLines.members[4].characters[0].visible = true;
            strumLines.members[3].characters[0].alpha = 1;
            subtitles("Hey!", FlxColor.WHITE, null);
        case 1039:
            subtitles(" ", FlxColor.WHITE, null);
        case 1040:
            FlxG.camera.flash(FlxColor.WHITE, 2);
        case 1420:
            subtitles("STOP", FlxColor.WHITE, null);
        case 1424:
            subtitles("STOP THAT", FlxColor.WHITE, null);
        case 1438:
            subtitles(" ", FlxColor.WHITE, null);
        case 1807:
            FlxG.camera.flash(FlxColor.WHITE, 2);
            FlxTween.tween(FlxG.camera, {zoom: 1}, 0.1, {ease:FlxEase.sineIn});
            defaultCamZoom = 1;
        case 2063:
            FlxG.camera.flash(FlxColor.WHITE, 2);
            FlxTween.tween(FlxG.camera, {zoom: 0.85}, 0.1, {ease:FlxEase.sineIn});
            strumLines.members[4].visible = false;
            strumLines.members[4].characters[0].visible = false;
            strumLines.members[3].visible = true;
            strumLines.members[3].characters[0].visible = true;
            iconP2.loadGraphic(Paths.image('icons/gsoner'), true, 150, 150);
            iconP2.animation.add("char", [for(i in 0...iconP1.frames.frames.length) i], 0, false);
            iconP2.antialiasing = true;
            iconP2.animation.play("char");
            healthBar.createFilledBar(goldenColor,0xFF993399);
            healthBar.updateFilledBar();
        case 2176:
            FlxTween.tween(FlxG.camera, {zoom: 0.9}, 0.5, {ease:FlxEase.sineIn});
            defaultCamZoom = 0.9;
        case 2192:
            FlxTween.tween(FlxG.camera, {zoom: 0.85}, 0.5, {ease:FlxEase.sineIn});
            defaultCamZoom = 0.85;
        case 2210:
            FlxTween.tween(strumLines.members[3].characters[0], {alpha: 0.00001}, 2, {ease:FlxEase.sineOut});
        case 2352:
            FlxG.camera.flash(FlxColor.WHITE, 2);
        case 2360:
            subtitles("CAN", FlxColor.WHITE, null); 
        case 2362:
            subtitles("CAN YOU", FlxColor.WHITE, null);
        case 2364:
            subtitles("CAN YOU HEAR", FlxColor.WHITE, null);
        case 2368:
            subtitles("CAN YOU HEAR ME", FlxColor.WHITE, null);
        case 2375:
            subtitles(" ", FlxColor.WHITE, null);
        case 2756:
            subtitles("TAINGLED", FlxColor.WHITE, null);
        case 2772:
            subtitles("TAINGLED UP", FlxColor.WHITE, null);
        case 2782:
            subtitles(" ", FlxColor.WHITE, null);
        case 2796:
            subtitles("LITTLE", FlxColor.WHITE, null);
        case 2805:
            subtitles(" ", FlxColor.WHITE, null);
        case 2880:
            FlxG.camera.flash(FlxColor.WHITE, 2);
            FlxTween.tween(FlxG.camera, {zoom: 0.85}, 0.1, {ease:FlxEase.sineIn});
            strumLines.members[3].visible = false;
            strumLines.members[3].characters[0].visible = false;
            iconP2.loadGraphic(Paths.image('icons/soner'), true, 150, 150);
            iconP2.animation.add("char", [for(i in 0...iconP1.frames.frames.length) i], 0, false);
            iconP2.antialiasing = true;
            iconP2.animation.play("char");
            healthBar.createFilledBar(dadColor,0xFF993399);
            healthBar.updateFilledBar();
            dad.visible = true;
            strumLines.members[3].characters[0].alpha = 1;
            dad.alpha = 1;
        case 3392:
            FlxG.camera.flash(FlxColor.WHITE, 2);
            strumLines.members[3].visible = true;
            strumLines.members[3].characters[0].visible = true;
            iconP2.loadGraphic(Paths.image('icons/gsoner'), true, 150, 150);
            iconP2.animation.add("char", [for(i in 0...iconP1.frames.frames.length) i], 0, false);
            iconP2.antialiasing = true;
            iconP2.animation.play("char");
            healthBar.createFilledBar(goldenColor,0xFF993399);
            healthBar.updateFilledBar();
            dad.visible = false;
        case 3648:
            FlxG.camera.flash(FlxColor.WHITE, 2);
        case 3676:
            FlxG.camera.flash(FlxColor.BLACK, 20);
    }
}