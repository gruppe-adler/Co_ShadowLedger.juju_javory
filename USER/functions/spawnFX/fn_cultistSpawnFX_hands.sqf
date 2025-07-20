params ["_player", "_type"];

private _colorLight = [0,0.541741,1];

switch (_type) do {
	case "demon": { _colorLight = [1,0.231213,0]; };
	case "zombie": { _colorLight = [0,1,0.541741]; };
    case "spider": { _colorLight = [0.5,1,0.541741]; };
    case "walker": { _colorLight = [1,1,0.541741]; };
	default { };
};

private _allSources = [];
{
	private _sparks = "#particlesource" createVehicleLocal [0,0,0]; 
	_sparks setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,2,0],"","Billboard",1,3.5,[0,0,0],[0,0,0.3],1,2,1,0, 
	[0.05,0.05,0.05,0.05,0.05,0.04,0.04,0.04,0.04,0,0], // Size 
	[[0,0.653615,0.905638,-6.5],[0.0145562,0.550105,0.973144,-6],[0.248578,0.716621,0.730122,-5.5],[0,1,0,-4.5],[0,0,0,0],[0,0,0,0]],[1000,0,0],0.5,0.55,"","","",0,false,0,[[0,0,0,0],[0,0,0,0],[0,0,0,0]]]; 
	_sparks setParticleRandom [3.5,[0,0,0.2],[0.1,0.1,0],2,0.9,[0,0.15,0.15,0],0.3,0.15,360,0]; 
	_sparks setParticleCircle [0.5,[0.8,0.8,0.1]]; 
	_sparks setParticleFire [0,0,0]; 
	_sparks setDropInterval 0.01; 
	_sparks attachTo [_player, [0,0,0], _x, true];
	_allSources pushBackUnique _sparks;

	private _smoke = "#particlesource" createVehicleLocal [0,0,0]; 
	_smoke setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,7,48,1],"","Billboard",1,1.2,[0,0,0],[0,0,0.6],0,0.05,0.04,0.22, 
    [0.14,0.4], // Size 
    [[0.1,0.1,0.1,0.03],[0.2,0.2,0.2,0.05],[0.2,0.2,0.2,0.025],[0.3,0.3,0.3,0.01],[0.4,0.4,0.4,0.005]],[1.5,0.5],0.4,0.02,"","","",0,false,0,[[0,0,0,0]]]; 
    _smoke setParticleRandom [0.5,[0.03,0.03,0.03],[1,1,0.5],0,0.1,[0,0,0,0],0.1,0.01,1,0]; 
    _smoke setParticleCircle [2,[1,1,0]]; 
    _smoke setParticleFire [0,0,0]; 
    _smoke setDropInterval 0.01; 
    _smoke attachTo [_player, [0,0,0], _x, true];
	_allSources pushBackUnique _smoke;

} forEach ["lefthand", "righthand"];

// detach _sparks; 

{
	private _light = "#lightpoint" createVehicleLocal [0,0,0]; 
	_light setLightColor _colorLight;
	_light setLightAmbient [0,0,0]; 
	_light setLightIntensity 1000; 
	_light setLightUseFlare true; 
	_light setLightFlareSize 2; 
	_light setLightFlareMaxDistance 1000; 
	_light setLightDayLight true; 
	_light setLightAttenuation [0,1,0,5]; 
	_light attachTo [_player, [0.01,0.01,0], _x, true]; 
	_allSources pushBackUnique _light;
} forEach ["lefthand", "righthand"];


[{
	params ["_player"];
	!alive _player || !(_player getVariable ["cultist_manaDrain", false])
},{
	params ["_player", "_allSources"];
	{ deleteVehicle _x; } forEach _allSources;
    _player setMimic "";
}, [_player, _allSources]] call CBA_fnc_waitUntilAndExecute;


/*
_exSmk = "#particlesource" createVehiclelocal [0,0,0]; 
    _exSmk setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,7,48,1],"","Billboard",1,1.2,[0,0,0],[0,0,0.6],0,0.05,0.04,0.22, 
    [0.14,0.4], // Size 
    [[0.1,0.1,0.1,0.03],[0.2,0.2,0.2,0.05],[0.2,0.2,0.2,0.025],[0.3,0.3,0.3,0.01],[0.4,0.4,0.4,0.005]],[1.5,0.5],0.4,0.02,"","","",0,false,0,[[0,0,0,0]]]; 
    _exSmk setParticleRandom [0.5,[0.03,0.03,0.03],[1,1,0.5],0,0.1,[0,0,0,0],0.1,0.01,1,0]; 
    _exSmk setParticleCircle [2,[1,1,0]]; 
    _exSmk setParticleFire [0,0,0]; 
    _exSmk setDropInterval 0.01; 
    _exSmk attachto [_obj,[0,0,1]]; 
 
    // Sparks upwards 
    _Expsprk = "#particlesource" createVehiclelocal [0,0,0]; 
    _Expsprk setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,2,0],"","Billboard",1,3.5,[0,0,0],[0,0,1.5],1,1.5,1,0.17, 
    [0.05,0.05,0.05,0.05,0.05,0.04,0.04,0.04,0.04,0], // Size 
    [[1,0.3,0.3,-6.5],[1,0.3,0.3,-6],[1,0.3,0.3,-5.5],[1,0.3,0.3,-4.5]],[1000],0.5,0.55,"","","",0,false,0,[[0,0,0,0]]]; 
    _Expsprk setParticleRandom [2.5,[0,0,0.2],[0.1,0.1,0],2,0.04,[0,0.15,0.15,0],0.3,0.15,360,0]; 
    _Expsprk setParticleCircle [2,[1,1,0]]; 
    _Expsprk setParticleFire [0,0,0]; 
    _Expsprk setDropInterval 0.01; 
    _Expsprk attachto [_obj,[0,0,1]]; 
 
    _exLgt = "#lightpoint" createVehiclelocal [0,0,0]; 
    _exLgt setLightColor [1,0.231213,0]; 
    _exLgt setLightAmbient [0,0,0]; 
    _exLgt setLightIntensity 2000; 
    _exLgt setLightUseFlare true; 
    _exLgt setLightFlareSize 0.5; 
    _exLgt setLightFlareMaxDistance 300; 
    _exLgt setLightDayLight false; 
    _exLgt setLightAttenuation [0,1,0,5]; 
    _exLgt lightAttachObject [_obj, [0,0,1]]; 
*/