if (didJIP) then {
    [player] remoteExec ["grad_common_fnc_addJipToZeus",2,false];
};

["InitializePlayer", [player,true]] call BIS_fnc_dynamicGroups;
grad_template_ratingEH = player addEventHandler ["HandleRating",{0}];

// set captive for kraken-units on spawn
if (player getVariable ["grad_iskraken", false]) then {
    player setCaptive true;
};

if ((typeOf player) isNotEqualTo "B_Helipilot_F") then {
    sleep 20;
    [] call BP_LOADOUT_fnc_addLoadoutAction;
    [] execVM "user\scripts\addTrackerAction.sqf";
    [] execVM "user\scripts\startCountdown.sqf";
};
