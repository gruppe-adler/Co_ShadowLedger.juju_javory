
private _customgroup = player getVariable ["grad_customGroup", "none"];

if (_customgroup == "crawler") then {
    player addItem "ace_flags_yellow";
    hint "Flag taken";
};

if (_customgroup == "reaper") then {
    player addItem "ace_flags_green";
    hint "Flag taken";
};

if (_customgroup == "blades") then {
    player addItem "ace_flags_red";
    hint "Flag taken";
};
