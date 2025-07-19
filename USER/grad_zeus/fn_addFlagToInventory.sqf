
private _customgroup = player getVariable ["grad_customGroup", "none"];

private _flagItems =[
    "ace_flags_yellow",
    "ace_flags_green",
    "ace_flags_red"
];

{
    if (_x in items player) then {
        hint "You already have a flag, dont be greedy!";
    };
} forEach _flagItems;


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
