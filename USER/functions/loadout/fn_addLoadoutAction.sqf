private _onAction = {
	[] call BP_LOADOUT_fnc_changeLoadout;
};

private _condition = { typeOf (vehicle player) in (missionNamespace getVariable ["GRAD_BP_vehicle_types_action", []]) };

private _action = [
	"GRAD_changeLoadout",
	"Umziehen",
	"",
	_onAction,
	_condition
] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;
