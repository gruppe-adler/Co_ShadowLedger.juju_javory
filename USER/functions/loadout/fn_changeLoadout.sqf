private _currentLoadout = getUnitLoadout player;
private _currentLoadoutType = player getVariable ["GRAD_BP_current_Loadout_Type", ""];

if (_currentLoadoutType isEqualTo "NORMAL") then {
	player setVariable ["GRAD_BP_normal_Loadout", _currentLoadout, true];
	private _diveLoadout = player getVariable ["GRAD_BP_dive_Loadout", []];
	player setUnitLoadout [_diveLoadout, false];
	player setVariable ["GRAD_BP_current_Loadout_Type", "DIVE", true];
} else {
	player setVariable ["GRAD_BP_dive_Loadout", _currentLoadout, true];
	private _normalLoadout = player getVariable ["GRAD_BP_normal_Loadout", []];
	player setUnitLoadout [_normalLoadout, false];
	player setVariable ["GRAD_BP_current_Loadout_Type", "NORMAL", true];
};