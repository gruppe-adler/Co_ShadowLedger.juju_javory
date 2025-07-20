params ["_player", "_placeholder", "_type", "_sound", "_owner", "_isResurrect"];

if (_owner && !_isResurrect && (_type != "sense")) then {
	[_placeholder, getPos _placeholder] call grad_cultist_fnc_cultistBeamCreate; // beam + spawn FX, gets deleted when !manaDrain
};

