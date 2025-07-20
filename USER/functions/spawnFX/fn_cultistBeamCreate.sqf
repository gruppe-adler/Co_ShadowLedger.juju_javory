params ["_placeholder", "_position"];

private _allEffects = [];

for "_i" from 1 to 30 do {  

   private _dir = random 360;
   _position set [2, _i];

   private _beam = createSimpleObject ["A3\data_f\VolumeLight_searchLight.p3d", agltoasl _position, true];
   _beam setDir _dir;
   _beam attachTo [_beam];
   [_beam, -90, 0] call BIS_fnc_setPitchBank;

   _beam setObjectScale 0.25;

   _allEffects pushBack _beam;
};

// reset to ground
_position set [2,0];

private _light = createSimpleObject ["\A3\data_f\VolumeLight", agltoasl _position, true];
_light attachTo [_light];
[_light, -90, 0] call BIS_fnc_setPitchBank;
_light setObjectScale 20;
_allEffects pushBack _light;

private _dust = "#particlesource" createvehiclelocal (_position); 
_dust setparticleparams 
    [ 
        ["\A3\data_f\ParticleEffects\Universal\Universal",16,12,13,0], 
        "", 
        "Billboard", 
        2, 
        2, 
        [0,0,1], 
        [0,0,0],//[-0.2,0,-0.1], 
        1, 
        1.275, 
        1, 
        0, 
        [0.08], 
        [[0,0.5,1,0.0],[0,0.5,1,0.8],[1,0.6,1,0.8],[1,0.5,1,0.8],[0,0.5,1,0.0]], 
        [1000.1], 
        1, 
        0, 
        "", 
        "", 
        _position, 
        0, 
        false, 
        0, 
        [[0,1,0,0.0],[0,1,0,0.1],[0,1,0,0.05],[0,1,0,0.1],[0,1,0,0.0]] 
    ]; 

_dust setparticlerandom 
    [ 
        2, 
        [1,1,2], 
        [-0.2,0,0.1], 
        2, 
        0.5, 
        [0.05,0.05,0.05,0.05], 
        0, 
        0, 
        1, 
        0 
    ]; 
_dust setDropInterval 0.01; 
_dust attachto [_dust]; 
_allEffects pushBackUnique _dust;
 
private _effect = createvehicle ["#particlesource",_position,[],0,"can_collide"]; 
_effect attachto [_effect]; 
_effect setParticleParams [ 
    ["\A3\data_f\ParticleEffects\Universal\Refract",1,0,1,0], 
    "", 
    "Billboard", 
    1, 
    1, 
    [0,0,1], 
    [0,0,10], 
    1, 
    1.275, 
    1, 
    0, 
    [1.5], 
    [[0,0,0,0.0],[0,0,0,0.5],[0,0,0,0.0]], 
    [1], 
    0.1, 
    0.05, 
    "", 
    "", 
    "", 
    0, 
    false, 
    0, 
    [] 
    ]; 
_effect setParticleRandom [ 
        1, 
        [0,0,0], 
        [0,0,0], 
        1, 
        0.1, 
        [0,0,0,0], 
        0, 
        0, 
        1, 
        0 
    ]; 
_effect setDropInterval 0.01; 
_effect attachto [_effect]; 
_allEffects pushBackUnique _effect;
 
private _particle_emitter_0 = "#particlesource" createvehiclelocal (_position); 
_particle_emitter_0 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,2,0],"","Billboard",1,3,[0,0,0],[0,0,-0.5],1,1.05,1,0.17,[0.1,0.1,0.1,0.1,0.1,0.08,0.08,0.08,0.08,0],[[0.343086,0.640114,1,-6.5],[1,0.3,0.3,-6],[1,0.3,0.3,-5.5],[1,0.3,0.3,-4.5]],[1000],0.5,0.55,"","","",0,false,0,[[0,0,0,0]]]; 
_particle_emitter_0 setParticleRandom [2.5,[0,0,0.2],[0.2,0.2,1],2,0.04,[0,0.15,0.15,0],0.3,0.15,360,0]; 
_particle_emitter_0 setParticleCircle [0,[0,0,0]]; 
_particle_emitter_0 setParticleFire [0,0,0]; 
_particle_emitter_0 setDropInterval 0.0005; 
_particle_emitter_0 attachto [_particle_emitter_0]; 
_allEffects pushBackUnique _particle_emitter_0;

[{
	params ["_placeholder"];
	isNull _placeholder
},{
	params ["_placeholder", "_allEffects"];
	{ deleteVehicle _x; } forEach _allEffects;
}, [_placeholder, _allEffects]] call CBA_fnc_waitUntilAndExecute;

/*
fn_AIteleportEffect = 
{ 
    params ["_center","_logic"]; //,"_newpos","_oldpos" 
 
    if !(alive _center) exitwith {}; 
    private _dust = "#particlesource" createvehiclelocal (position _center); 
    _dust setparticleparams 
    [ 
        ["\A3\data_f\ParticleEffects\Universal\Universal",16,12,13,0], 
        "", 
        "Billboard", 
        2, 
        2, 
        [0,0,1], 
        [0,0,0],//[-0.2,0,-0.1], 
        1, 
        1.275, 
        1, 
        0, 
        [0.08], 
        [[0,0.5,1,0.0],[0,0.5,1,0.8],[1,0.6,1,0.8],[1,0.5,1,0.8],[0,0.5,1,0.0]], 
        [1000.1], 
        1, 
        0, 
        "", 
        "", 
        _center, 
        0, 
        false, 
        0, 
        [[0,1,0,0.0],[0,1,0,0.1],[0,1,0,0.05],[0,1,0,0.1],[0,1,0,0.0]] 
    ]; 
    _dust setparticlerandom 
    [ 
        2, 
        [1,1,2], 
        [-0.2,0,0.1], 
        2, 
        0.5, 
        [0.05,0.05,0.05,0.05], 
        0, 
        0, 
        1, 
        0 
    ]; 
    _dust setDropInterval 0.01; 
    _dust attachto [_logic,[0,0,0]]; 
 
     private _effect = createvehicle ["#particlesource",getposatl _center,[],0,"can_collide"]; 
    _effect attachto [_center,[0,0,-0.5],"pelvis"]; 
    _effect setParticleParams [ 
    ["\A3\data_f\ParticleEffects\Universal\Refract",1,0,1,0], 
    "", 
    "Billboard", 
    1, 
    0.2, 
    [0,0,1], 
    [1,1,1], 
    1, 
    1.275, 
    1, 
    0, 
    [1.5], 
    [[0,0,0,0.0],[0,0,0,0.5],[0,0,0,0.0]], 
    [1], 
    0.1, 
    0.05, 
    "", 
    "", 
    "", 
    0, 
    false, 
    0, 
    [] 
    ]; 
    _effect setParticleRandom [ 
        1, 
        [0,0,0], 
        [0,0,0], 
        1, 
        0.1, 
        [0,0,0,0], 
        0, 
        0, 
        1, 
        0 
    ]; 
    _effect setDropInterval 0.01; 
    _effect attachto [_logic,[0,0,0]]; 
 
    private _particle_emitter_0 = "#particlesource" createvehiclelocal (position _center); 
    _particle_emitter_0 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,2,0],"","Billboard",1,3,[0,0,0],[0,0,-0.5],1,1.05,1,0.17,[0.1,0.1,0.1,0.1,0.1,0.08,0.08,0.08,0.08,0],[[0.343086,0.640114,1,-6.5],[1,0.3,0.3,-6],[1,0.3,0.3,-5.5],[1,0.3,0.3,-4.5]],[1000],0.5,0.55,"","","",0,false,0,[[0,0,0,0]]]; 
    _particle_emitter_0 setParticleRandom [2.5,[0,0,0.2],[0.2,0.2,1],2,0.04,[0,0.15,0.15,0],0.3,0.15,360,0]; 
    _particle_emitter_0 setParticleCircle [0,[0,0,0]]; 
    _particle_emitter_0 setParticleFire [0,0,0]; 
    _particle_emitter_0 setDropInterval 0.0005; 
    _particle_emitter_0 attachto [_logic,[0,0,0]]; 
 
    waituntil {_center getvariable ["canteleport",false] || !(alive _center)} ; 
    deleteVehicle _particle_emitter_0; 
    sleep 1; 
    {deletevehicle _x} foreach [_dust,_effect]; 
 
}; 
*/