if (isServer) then {


    private _spawnPositions [
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
        _args params ["_spawnPositions", "_infectedClassnames"];

        private _maxUnitCount = missionNameSpace getVariable ["grad_infected_maxUnitCount", 100];
        private _currentUnitCount = count allUnits select { side _x == east};
        
        if (_currentUnitCount < _maxUnitCount) then {
            private _classname = selectRandom _infectedClassnames;

            private _unit = createUnit [_classname, selectRandom _spawnPositions, [], 0, "CAN_COLLIDE"];
            [_unit] call 

            diag_log format ["_currentUnitCount %1 - _maxUnitCount %2", _currentUnitCount, _maxUnitCount];
        };        


    }, 10, [_spawnPositions, _infectedClassnames]] call CBA_fnc_addPerFrameHandler;



};