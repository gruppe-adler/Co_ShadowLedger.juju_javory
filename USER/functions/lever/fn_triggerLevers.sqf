if (not isServer) exitWith {};

private _levers = [grad_lever_poi_1, grad_lever_poi_2, grad_lever_poi_3, grad_lever_poi_4, grad_lever_poi_5];

[
	{
		params ["_levers"];
		private _leversPulled = { _x getVariable ["grad_lever_isBeingPulled", false] } count _levers;
		_leversPulled == count _levers
	},
	{
		[] call BP_LEVER_fnc_onAllLeversPulled;
	},
	[_levers]
] call CBA_fnc_waitUntilAndExecute;
