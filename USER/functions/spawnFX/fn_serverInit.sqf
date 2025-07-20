
if (!isServer) exitWith {};

 private _spawnPositions = [
        getMarkerPos "mrk_spawner_1",
        getMarkerPos "mrk_spawner_2",
        getMarkerPos "mrk_spawner_3",
        getMarkerPos "mrk_spawner_4"
];

missionNameSpace setVariable ["grad_spawner_positions", _spawnPositions, true];

private _infectedClassnames = [
    "Zombie_O_Crawler_Civ",
    "Zombie_O_RC_Civ",
    "Zombie_O_Shambler_Civ",
    "Zombie_O_RA_Civ",
    "Zombie_O_Walker_Civ"
];

[{
    params ["_args", "_handle"];
    _args params ["_infectedClassnames"];

    private _maxUnitCount = missionNameSpace getVariable ["grad_infected_maxUnitCount", 100];
    private _currentUnitCount = count (allUnits select { side _x == east});
    private _spawnPositions = missionNameSpace getVariable ["grad_spawner_positions", [[0,0,0]]];
    
    if (_currentUnitCount < _maxUnitCount) then {
        private _classname = selectRandom _infectedClassnames;
        private _spawnPos = selectRandom _spawnPositions;

        private _unit = (createGroup east) createUnit [_classname, _spawnPos, [], 0, "CAN_COLLIDE"];
        [_spawnPos] remoteExec ["grad_spawnFX_fnc_SpawnFX_local"];
        _unit setDir random 360;

        // private _nearestEnemy = allPlayers select { _x distance _unit < 150};

        diag_log format ["_currentUnitCount %1 - _maxUnitCount %2", _currentUnitCount, _maxUnitCount];
    } else {
        diag_log format ["Current unit count %1 exceeds max unit count %2, not spawning new units.", _currentUnitCount, _maxUnitCount];
    };


    if (missionNameSpace setVariable ["grad_allLeversPulled", false]) then {
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

}, 1, [_infectedClassnames]] call CBA_fnc_addPerFrameHandler;

