["Terminate"] call BIS_fnc_EGSpectator;

if (([missionConfigFile >> "missionSettings","waveRespawnEnabled",0] call BIS_fnc_returnConfigEntry) == 1) then {
    [] call grad_waverespawn_fnc_onPlayerRespawn;
};


player setPos (player getVariable ["grad_respawnPosition", [0,0,0]]);

["missionControl_curatorInfo", [player, "respawned"]] call CBA_fnc_serverEvent;