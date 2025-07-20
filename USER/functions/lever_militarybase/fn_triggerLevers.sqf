if (not isServer) exitWith {};

private _levers = [grad_lever_militarybase_1, grad_lever_militarybase_2, grad_lever_militarybase_3, grad_lever_militarybase_4];

[
	{
		params ["_levers"];
		private _leversPulled = { _x getVariable ["grad_lever_isBeingPulled_militarybase", false] } count _levers;
		_leversPulled == count _levers
	},
	{
		[] call BP_LEVER_fnc_onAllLeversPulled;
	},
	[_levers]
] call CBA_fnc_waitUntilAndExecute;
