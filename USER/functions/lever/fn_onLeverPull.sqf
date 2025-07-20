/*
* Code to execute when a lever gets pulled.
* Is executed in the unscheduled enviroment, client local.
*/

params ["_lever"];

systemChat format["Pulled Lever %1!", _lever];

private _source = _lever say3D "lever_pull";

[{
	params ["_lever", "_source"];

	// if all levers were NOT pulled, cancel sound and replace with dododo that was nothing sound
	if (!missionNamespace getVariable ["grad_allLeversPulled", false]) exitWith {
		deleteVehicle _source;

		_lever say3D "lever_dismissed";

	};
}, [_lever, _source], 5] call CBA_fnc_waitAndExecute;