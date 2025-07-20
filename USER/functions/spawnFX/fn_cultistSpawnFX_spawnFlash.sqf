params ["_position"];

[_position, 3] call grad_cultist_fnc_cultistSpawnFX_fog;
 _position set [2,3];
 
private _light = "#lightpoint" createVehiclelocal _position; 
_light setLightColor [0,0.541741,1]; 
_light setLightAmbient [0,0,0]; 
_light setLightIntensity 2000; 
_light setLightUseFlare true; 
_light setLightFlareSize 10; 
_light setLightFlareMaxDistance 1000; 
_light setLightDayLight true; 
_light setLightAttenuation [0,1,0,5]; 



private _arrow = "#particlesource" createVehicleLocal [0,0,0]; 
_arrow setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,2,0],"","Billboard",1,2,[0,0,0],[0,0,0.1],0.5,1,0.5,0, 
[0.02,0.02,0.02,0.02,0.02,0.02,0.02,0.02,0.02,0,0], // Size 
[[1,0.653615,0.905638,-6.5],[1,0.653615,0.905638,-6.5],[1,0.653615,0.905638,-6.5],[1,0.653615,0.905638,-6.5],[0,0,0,0],[0,0,0,0]],[1000,0,0],0.5,0.55,"","","",0,false,0,[[0,0,0,0],[0,0,0,0],[0,0,0,0]]]; //[0,0.653615,0.905638,-6.5] 
_arrow setParticleRandom [0,[0,0,0.01],[0.1,0.1,0],2,0.5,[0,0.15,0.15,0],0.3,0.15,360,0]; 
//_arrow setParticleCircle [0.25,[0,0,0.1]]; 
_arrow setParticleFire [0,0,0]; 
_arrow setDropInterval 0.035; 

private _light2 = "#lightpoint" createVehiclelocal [0,0,0]; 
_light2 setLightColor [1,0.541741,0.8]; 
_light2 setLightAmbient [0,0,0]; 
_light2 setLightIntensity 1000; 
_light2 setLightUseFlare true; 
_light2 setLightFlareSize 1; 
_light2 setLightFlareMaxDistance 1000; 
_light2 setLightDayLight true; 
_light2 setLightAttenuation [0,1,0,5]; 



[_arrow, _position] spawn {
	params ["_arrow", "_position"];

	private _n = 200;//569 
	private _stepUhel = (360)/_n; 
	private _stepvyska = 1.65/(2*_n); 
	private _uhel = 0; 
	private _z = 0.3; 
	for "_i" from 0 to (2*_n) do 
	{ 
		_n = _n + 1; 
		_z = _z + _stepvyska; 
		_uhel = _uhel + _stepUhel; 

		_arrow setPos [_position#0+(cos _uhel)*0.5,_position#1+(sin _uhel)*0.5,_z]; 
		sleep 0.0001;//0.0005 
	}; 
};


[{
	params ["_light", "_arrow"];
	
	deletevehicle _light;
	deleteVehicle _arrow;

}, [_light, _arrow], 0.5] call CBA_fnc_waitAndExecute;

[{
	params ["_light2"];
	
	deleteVehicle _light2; 

}, [_light2], 2] call CBA_fnc_waitAndExecute;

