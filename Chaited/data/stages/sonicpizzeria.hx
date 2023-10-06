import flixel.util.FlxColor;

function create() {
    defaultCamZoom = 1.2;
    gf.scale.set(0.95,0.95);
    boyfriend.x = 570;
    boyfriend.y = 90;
    dad.x = -200;
    dad.y = 50;
    gf.x = 0;
    gf.y = -120;
    if (curSong == "chaited") {
        gf.visible = false;
        dad.visible = false;
        remove(strumLines.members[4].characters[0]);
        remove(strumLines.members[3].characters[0]);
        strumLines.members[3].characters[0].visible = false;
        strumLines.members[3].visible = false;
        strumLines.members[4].characters[0].visible = false;
        strumLines.members[4].visible = false;
        strumLines.members[3].characters[0].y = dad.y + 160;
        strumLines.members[3].characters[0].x = dad.x;
    }
    remove(dad);
    remove(boyfriend);
    bgpeople1 = new FlxSprite(-400, 0);
    bgpeople1.frames = Paths.getFrames("stages/chaited/bg_chara_left");
    bgpeople1.animation.addByPrefix("idle", "bg charac left", 24);
    bgpeople1.scrollFactor.set(1,1);

    bgpeople2 = new FlxSprite(900, -100);
    bgpeople2.frames = Paths.getFrames("stages/chaited/bg_chara_right");
    bgpeople2.animation.addByPrefix("idle", "bg charac right", 24);
    bgpeople2.scrollFactor.set(1,1);

    wall = new FlxSprite(-350, -140).loadGraphic(Paths.image("stages/chaited/wall"));
    wall.scrollFactor.set(0.9,0.9);
    wall.scale.set(1.2,1.2);

    floor = new FlxSprite(-400, 80).loadGraphic(Paths.image("stages/chaited/floor"));
    floor.scrollFactor.set(1,1);
    floor.scale.set(1.15,1.15);

    table = new FlxSprite(-350, 450).loadGraphic(Paths.image("stages/chaited/table"));
    table.scrollFactor.set(1.3,1.3);
    table.scale.set(1.2,1.2);

    add(wall);
    add(bgpeople1);
    bgpeople1.animation.play("idle");
    add(bgpeople2);
    bgpeople2.animation.play("idle");
    add(floor);
    add(dad);
    add(boyfriend);
    if (curSong == "chaited") {
        add(strumLines.members[4].characters[0]);
        add(strumLines.members[3].characters[0]);
        bgpeople1.visible = false;
        bgpeople2.visible = false;
    }
    add(table);
}

function update() {
    if (curSong == "chaited") {
        var toadColor = (strumLines.members[4].characters[0] != null && strumLines.members[4].characters[0].xml != null && strumLines.members[4].characters[0].xml.exists("color")) ? CoolUtil.getColorFromDynamic(strumLines.members[4].characters[0].xml.get("color")) : 0xFFFF0000;
        var goldenColor = (strumLines.members[3].characters[0] != null && strumLines.members[3].characters[0].xml != null && strumLines.members[3].characters[0].xml.exists("color")) ? CoolUtil.getColorFromDynamic(strumLines.members[3].characters[0].xml.get("color")) : 0xFFFF0000;
        var tangleColor = (gf != null && gf.xml != null && gf.xml.exists("color")) ? CoolUtil.getColorFromDynamic(gf.xml.get("color")) : 0xFFFF0000;
        if (curBeat == 578) {
            FlxTween.tween(gf, {y: -680}, 1 , {ease:FlxEase.cubeIn});
        }
        if (curBeat >= 64 && curBeat <= 238) {
            bgpeople1.visible = true;
            bgpeople2.visible = true;
            gf.visible = true;
            dad.visible = true;
        }
        if (curBeat == 240) {
            FlxTween.tween(strumLines.members[3].characters[0], {alpha: 0.00001}, 1, {ease:FlxEase.cubeIn});
            FlxTween.tween(iconP2, {alpha: 0.00001}, 1, {ease:FlxEase.cubeIn});
        }
        if (curBeat == 585) {
            remove(gf);
            gf.scale.set(1.1,1.1);
            insert(members.indexOf(boyfriend), gf);
            FlxTween.tween(gf, {y: -190}, 1, {ease:FlxEase.cubeOut});
            iconP2.loadGraphic(Paths.image('icons/taing'), true, 150, 150);
            iconP2.animation.add("char", [for(i in 0...iconP1.frames.frames.length) i], 0, false);
            iconP2.antialiasing = true;
            iconP2.animation.play("char");
            healthBar.createFilledBar(tangleColor,0xFF993399);
            healthBar.updateFilledBar();
        }
        if(curBeat >= 584 && curBeat <= 716) {
            defaultCamZoom = 1.1;
        } else (defaultCamZoom = 0.9);
        if (curBeat == 912) {
            FlxTween.tween(dad, {alpha: 0.00001}, 1, {ease:FlxEase.cubeIn});
            FlxTween.tween(iconP2, {alpha: 0.00001}, 1, {ease:FlxEase.cubeIn});
            bgpeople1.visible = false;
            bgpeople2.visible = false;
            gf.visible = false;
        }
        if (curStep == 1034) {
            dad.visible = false;
            strumLines.members[4].characters[0].x = -1000;
            FlxTween.tween(strumLines.members[4].characters[0], {x: -190}, 0.5, {ease:FlxEase.cubeOut});
            iconP2.loadGraphic(Paths.image('icons/btoa'), true, 150, 150);
            iconP2.animation.add("char", [for(i in 0...iconP1.frames.frames.length) i], 0, false);
            iconP2.antialiasing = true;
            iconP2.animation.play("char");
            healthBar.createFilledBar(toadColor,0xFF993399);
            healthBar.updateFilledBar();
            iconP2.alpha = 1;
            dad.alpha = 1;
        }
    }
}

function beatHit() {
    switch (curBeat) {
        case 0:
            FlxTween.tween(FlxG.camera, {zoom: 1.2}, 0.1, {ease: FlxEase.sineInOut});
        case 1:
            FlxTween.tween(FlxG.camera, {zoom: 0.85}, 10, {ease: FlxEase.sineInOut});
        case 64:
            FlxG.camera.flash(FlxColor.WHITE, 2);
        case 55:
            defaultCamZoom = 0.85;
    }
}


function postUpdate() {
    PlayState.instance.comboGroup.cameras = [camHUD];
    PlayState.instance.comboGroup.scale.set(0.5,0.5);
    PlayState.instance.comboGroup.visible = false;
    add(PlayState.instance.comboGroup);
}