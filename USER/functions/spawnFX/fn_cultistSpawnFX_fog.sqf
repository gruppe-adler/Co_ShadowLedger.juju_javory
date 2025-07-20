params ["_position", ["_duration", 3]];

private _endTime = CBA_missionTime + _duration;
_positionNewScope =+ _position; // to fix outer scope from spawnflash

[{
	params ["_args", "_handle"];
	_args params ["_positionNewScope", "_endTime"];

	if (_endTime < CBA_missionTime) exitWith {
		[_handle] call CBA_fnc_removePerFrameHandler;
	};

	drop ["\A3\data_f\cl_basic",
	"",
	"Billboard",
	1,
	5,
	_positionNewScope,
	[random 0.1, random 0.1, random 0.1],
	0,
	0.2,0.1568,0,[random .1, .1 + random .3, .4 + random .3, .7 + random .3],
	[[1,1,1,0],[1,1,1,.2],[1,1,1,.3],[1,1,1,.3],[1,1,1,.2],[1,1,1,.15],[1,1,1,.05],[1,1,1,0]],
	[0],
	0,0,"", "",""];

}, 0.1, [_positionNewScope, _endTime]] call CBA_fnc_addPerFrameHandler;
