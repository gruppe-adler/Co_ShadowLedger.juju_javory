params ["_lever"];

private _onAction = {
	params ["_lever"];
	_lever setVariable ["grad_lever_isBeingPulled_militarybase", true, true];
	[
		{
			params ["_lever"];
			_lever animate ["lever_rot", 0, 0.6];
			[
				{
					params ["_lever"];
					_lever setVariable ["grad_lever_isBeingPulled_militarybase", false, true];
				},
				[_lever],
				1.3
			] call CBA_fnc_waitAndExecute;
		},
		[_lever],
		5
	] call CBA_fnc_waitAndExecute;
	_lever animate ["lever_rot", 1, 0.6];
	[_lever] call BP_LEVER_fnc_onLeverPull;
};

private _condition = {
	params ["_lever"];
	not (_lever getVariable ["grad_lever_isBeingPulled_militarybase_militarybase", false]) &&
	!(missionNamespace getVariable ["grad_allLeversPulled_militarybase", false])
};

private _action = [
	"GRAD_pullLever",
	"Schalter umlegen",
	"",
	_onAction,
	_condition,
	{},
	[_lever],
	[2.15, 0, 0.58]
] call ace_interact_menu_fnc_createAction;
[_lever, 0, [], _action] call ace_interact_menu_fnc_addActionToObject;
