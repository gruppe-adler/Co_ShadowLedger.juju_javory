params ["_player", "_bodies"];

{
	private _position = position _x;
	[{
		params ["_args", "_handle"];
		_args params ["_position", "_player"];

		if (!(_player getVariable ["cultist_manaDrain", false])) exitWith {
			[_handle] call CBA_fnc_removePerFrameHandler;
		};

		drop ["\A3\data_f\cl_basic",
		"",
		"Billboard",
		1,
		5,
		_position,
		[random 0.1, random 0.1, 0.1 + random 0.1],
		5,
		0.2,0.1568,0,[random .1, .1 + random .3, .4 + random .3, .7 + random .3],
		[[1,1,1,0],[1,1,1,.3],[1,1,1,.4],[1,1,1,.3],[1,1,1,.3],[1,1,1,.15],[1,1,1,.05],[1,1,1,0]],
		[0],
		0,0,"", "",""];

		/*
		drop ["\A3\data_f\ParticleEffects\Universal\Meat_ca.p3d", 1, 0, 1], "", "SpaceObject",
		1,
		5,
		_position,
		[random 0.1, random 0.1, 0.1 + random 0.1],
		5,
		0.2,0.1568,0,[random .5, 0],
		[[1,1,1,0],[1,1,1,.3],[1,1,1,.4],[1,1,1,.3],[1,1,1,.3],[1,1,1,.15],[1,1,1,.05],[1,1,1,0]],
		[0],
		0,0,"", "",""];
		*/

	}, 0.2, [_position, _player]] call CBA_fnc_addPerFrameHandler;

} forEach _bodies;
