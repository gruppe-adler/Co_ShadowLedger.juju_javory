if (!hasInterface) exitWith {};

params ["_position"];

private _lightPoint = "#lightpoint" createvehiclelocal _position;
_lightPoint setLightDayLight true;_lightPoint setLightUseFlare true;
_lightPoint setLightFlareSize 5; _lightPoint setLightFlareMaxDistance 5000;
_lightPoint setLightAmbient[0.5,0.5,1]; _lightPoint setLightColor[0.5,0.7,0.9];
_lightPoint setLightAttenuation [0, 0, 0, 0, 0, 4000];
_lightPoint setLightBrightness 10;


private _sparksColumn = "#particlesource" createVehicleLocal _position;
_sparksColumn setParticleCircle [1,[0,0,0]];
_sparksColumn setParticleRandom [10,[0,0,0],[0,0,1],0,0,[0,0,0,0],1,0];
// _sparksColumn setParticleParams [["\A3\data_f\kouleSvetlo",1,0,1],"","Billboard",1,120,[0,0,.5],[0,0,5],13,9.999,7.9,0.005,[.1,15,20,40],[[1,1,1,1],[0,1,0,1],[0,0.3,0.7,0.5],[0.9,0,0.7,1],[0.4,0,0.2,0]],[0.08],1,1,"","",_sparksColumn];
_sparksColumn setParticleParams [["\A3\data_f\kouleSvetlo",1,0,1],"","Billboard",1,10,[0,0,.5],[0,0,5],13,9.999,7.9,0.005,[.01,.01,.01,.1],[[1,.5,0,1],[1,0,0,1],[0,0.3,0.7,0.5],[0.9,0,0.7,1],[0.4,0,0.2,0]],[0.08],1,0.1,"","",_sparksColumn,0,true,1,[[200,100,0,10],[200,000,0,1]]];
_sparksColumn setDropInterval 0.05;
_sparksColumn setPos _position;

private _sparksRandom = "#particlesource" createVehicleLocal _position;
_sparksRandom setParticleCircle [1,[0,0,0]];
_sparksRandom setParticleRandom [10,[0,0,0],[0,0,1],0,0,[0,0,0,0],1,0];
// _sparksRandom setParticleParams [["\A3\data_f\kouleSvetlo",1,0,1],"","Billboard",1,120,[0,0,.5],[0,0,5],13,9.999,7.9,0.005,[.1,15,20,40],[[1,1,1,1],[0,1,0,1],[0,0.3,0.7,0.5],[0.9,0,0.7,1],[0.4,0,0.2,0]],[0.08],1,1,"","",_sparksColumn];
_sparksRandom setParticleParams [["\A3\data_f\kouleSvetlo",1,0,1],"","Billboard",1,10,[0,0,.5],[0,0,5],13,9.999,7.9,0.005,[.01,.01,.1,0],[[1,.5,0,1],[1,0,0,1],[1,0,0,0]],[0.08],1,1,"","",_sparksRandom,0,true,1,[[200,100,0,10],[200,000,0,1]]];
_sparksRandom setDropInterval 0.05;
_sparksRandom setPos _position;

for "_i" from 100 to 1 do {
    [{
        params ["_lightpoint"];

        _lightpoint setLightBrightness (_i);
    }, [_lightpoint] ,_i/10] call CBA_fnc_waitAndExecute;
};



[{
    params ["_sparksColumn", "_sparksRandom", "_lightpoint"];

    { deleteVehicle _x; } forEach [_sparksColumn, _sparksRandom, _lightpoint];

}, [_sparksColumn, _sparksRandom, _lightpoint], 1] call CBA_fnc_waitAndExecute;
