
if (!isServer) exitWith {};

 private _spawnPositions = [
        getMarkerPos "mrk_spawner_1",
        getMarkerPos "mrk_spawner_2",
        getMarkerPos "mrk_spawner_3",
        getMarkerPos "mrk_spawner_4"
];

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

    private _isPaused = missionNamespace getVariable ["grad_pause_spawn_loop", false] || diag_fps < 45;
    if (isPaused) exitWith {};

    private _maxUnitCount = missionNameSpace getVariable ["grad_infected_maxUnitCount", 100];
    private _currentUnitCount = count (allUnits select { side _x == east});
    private _relevantPlayers = [allPlayers, allPlayers select { isNull (getAssignedCuratorLogic _x) }] select isDedicated;
    private _viableSpawnAreas = [grad_spawn_area_poi_1, grad_spawn_area_poi_2, grad_spawn_area_poi_3, grad_spawn_area_poi_4, grad_spawn_area_poi_5] select {
        private _trigger = _x;
        private _playersInArea = _relevantPlayers select { _x inArea _trigger };
        count _playersInArea > 0
    };    

    if (count _viableSpawnAreas <= 0) exitWith {};
    
    if (_currentUnitCount >= _maxUnitCount) exitWith {
      //  diag_log format ["Current unit count %1 exceeds max unit count %2, not spawning new units.", _currentUnitCount, _maxUnitCount];
    };

    private _classname = selectRandom _infectedClassnames;
    private _spawnArea = selectRandom _viableSpawnAreas;
    private _spawnPos = [_spawnArea, 0, 100, 3, 0, 0, 0, [], []] call BIS_fnc_findSafePos;
    if (count _spawnPos == 2) then {
        _spawnPos append [0];
    };

    private _grp = createGroup east;
    private _unit = _grp createUnit [_classname, _spawnPos, [], 0, "CAN_COLLIDE"];
    [_spawnPos] remoteExec ["grad_spawnFX_fnc_SpawnFX_local"];
    // systemChat format["Spawned unit %1", _unit];
    _unit setDir random 360;

    private _nearestPlayer = selectRandom _relevantPlayers;
    private _nearestPlayerDist = _nearestPlayer distance2D _spawnPos;
    {
        private _currentDist = _x distance2D _spawnPos;
        if (_currentDist < _nearestPlayerDist) then {
            _nearestPlayer = _x;
            _nearestPlayerDist = _currentDist;
        }            
    } forEach _relevantPlayers;

    [_grp, _nearestPlayer, 0, "MOVE", "AWARE", "YELLOW", "FULL"] call CBA_fnc_addWaypoint;

    diag_log format ["_currentUnitCount %1 - _maxUnitCount %2", _currentUnitCount, _maxUnitCount];


}, 4, [_infectedClassnames]] call CBA_fnc_addPerFrameHandler;



private _mutantClassnames = [
    "Zombie_Special_OPFOR_Leaper_1",
    "Zombie_Special_OPFOR_Leaper_2",
    "Zombie_Special_OPFOR_Screamer",
    "WBK_SpecialZombie_Corrupted_3",
    "Zombie_Special_OPFOR_Boomer"
];

[{
    params ["_args", "_handle"];
    _args params ["_mutantClassnames"];

    private _isPaused = missionNamespace getVariable ["grad_pause_spawn_loop_militarybase", true] || diag_fps < 45;
    if (isPaused) exitWith {};

    private _maxUnitCount = missionNameSpace getVariable ["grad_infected_maxUnitCount", 100];
    private _currentUnitCount = count (allUnits select { side _x == east});
    private _relevantPlayers = [allPlayers, allPlayers select { isNull (getAssignedCuratorLogic _x) }] select isDedicated;
    private _viableSpawnAreas = [grad_spawn_area_militarybase_1, grad_spawn_area_militarybase_2] select {
        private _trigger = _x;
        private _playersInArea = _relevantPlayers select { _x inArea _trigger };
        count _playersInArea > 0
    };

    if (count _viableSpawnAreas <= 0) exitWith {};
    
    if (_currentUnitCount >= _maxUnitCount) exitWith {
       // diag_log format ["Current unit count %1 exceeds max unit count %2, not spawning new units.", _currentUnitCount, _maxUnitCount];
    };

    private _classname = selectRandom _mutantClassnames;
    private _spawnArea = selectRandom _viableSpawnAreas;
    private _spawnPos = [_spawnArea, 0, 100, 3, 0, 0, 0, [], []] call BIS_fnc_findSafePos;
    if (count _spawnPos == 2) then {
        _spawnPos append [0];
    };

    private _grp = createGroup east;
    private _unit = _grp createUnit [_classname, _spawnPos, [], 0, "CAN_COLLIDE"];
    [_spawnPos] remoteExec ["grad_spawnFX_fnc_SpawnFX_local"];
    // systemChat format["Spawned unit %1", _unit];
    _unit setDir random 360;

    private _nearestPlayer = selectRandom _relevantPlayers;
    private _nearestPlayerDist = _nearestPlayer distance2D _spawnPos;
    {
        private _currentDist = _x distance2D _spawnPos;
        if (_currentDist < _nearestPlayerDist) then {
            _nearestPlayer = _x;
            _nearestPlayerDist = _currentDist;
        }            
    } forEach _relevantPlayers;

    [_grp, _nearestPlayer, 0, "MOVE", "AWARE", "YELLOW", "FULL"] call CBA_fnc_addWaypoint;

    diag_log format ["_currentUnitCount %1 - _maxUnitCount %2", _currentUnitCount, _maxUnitCount];


}, 4, [_mutantClassnames]] call CBA_fnc_addPerFrameHandler;
