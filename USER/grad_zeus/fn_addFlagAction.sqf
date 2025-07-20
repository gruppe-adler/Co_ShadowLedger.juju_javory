params ["_object"];

private _onAction = {
	call grad_zeus_fnc_addFlagToInventory;
};

private _condition = { true };



private _action = [
	"grad_zeus_fnc_addFlagToInventory",
	"Take New Flag",
	"",
	_onAction,
	_condition
] call ace_interact_menu_fnc_createAction;

[_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
