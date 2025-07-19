/*
*   Wird zum Missionsstart auf Server und Clients ausgeführt.
*   Funktioniert wie die init.sqf.
*/


// add custom BFT, disable ace BFT
[] execVM "user\scripts\customBFT.sqf";
[] execVM "user\scripts\markerManagerServer.sqf";

if (hasInterface) then {
    // add custom BFT to client
    [] call grad_zeus_fnc_transferRadiosAcrossRespawn;
};

if (isServer) then {

        missionNameSpace setVariable ["grad_killcount_reaper", 0, true];
        missionNameSpace setVariable ["grad_killcount_crawler", 0, true];
        missionNameSpace setVariable ["grad_killcount_blades", 0, true];

        missionNameSpace setVariable ["grad_penalty_reaper", 0, true];
        missionNameSpace setVariable ["grad_penalty_crawler", 0, true];
        missionNameSpace setVariable ["grad_penalty_blades", 0, true];

        missionNameSpace setVariable ["grad_blueonblue_reaper", 0, true];
        missionNameSpace setVariable ["grad_blueonblue_crawler", 0, true];
        missionNameSpace setVariable ["grad_blueonblue_blades", 0, true];
        

        // kill tracker for Zs
        ["Man", "init", {      
                params ["_unit"];
                _unit setVariable ["lambs_danger_disableAI", true, true];

                if (side _unit != east) exitWith {};

                 _unit addMPEventHandler ["MPKilled", {
                        params ["_unit", "_killer", "_instigator", "_useEffects"];
                        
                        // hint ("killed pre server" + str _unit);

                        if (!isServer) exitWith {};

                        private _points = 60;

                        if (_unit isKindOf "WBK_SpecialZombie_Smasher_3") then {
                           _points = 1000;
                        };

                        if (_unit isKindOf "WBK_Goliaph_3") then {
                           _points = 2000;
                        };

                        if (_unit isKindOf "Zombie_Special_OPFOR_Screamer") then {
                           _points = 200;
                        };

                        if (_unit isKindOf "Zombie_Special_OPFOR_Leaper_1") then {
                           _points = 200;
                        };

                         if (_unit isKindOf "Zombie_Special_OPFOR_Leaper_2") then {
                           _points = 200;
                        };

                        if (_unit isKindOf "WBK_SpecialZombie_Corrupted_3") then {
                           _points = 200;
                        };

                         if (_unit isKindOf "Zombie_Special_OPFOR_Boomer") then {
                           _points = 200;
                        }; 

                        ["missionControl_curatorInfo", [_unit, "killed"]] call CBA_fnc_serverEvent;

                        private _killerGroup = _killer getVariable ["grad_customGroup", "none"];

                        // hint ("_killerGroup" + _killerGroup);
                        if (_killerGroup == "reaper") then {
                            grad_victorypoints_reaper = grad_victorypoints_reaper + _points;
                            grad_killcount_reaper = grad_killcount_reaper + 1;
                            missionNameSpace setVariable ["grad_killcount_reaper", grad_killcount_reaper, true];
                        };
                        if (_killerGroup == "crawler") then {
                            grad_victorypoints_crawler = grad_victorypoints_crawler + _points;
                            grad_killcount_crawler = grad_killcount_crawler + 1;
                            missionNameSpace setVariable ["grad_killcount_crawler", grad_killcount_crawler, true];
                        };
                        if (_killerGroup == "blades") then {
                            grad_victorypoints_blades = grad_victorypoints_blades + _points;
                            grad_killcount_blades = grad_killcount_blades + 1;
                            missionNameSpace setVariable ["grad_killcount_blades", grad_killcount_blades, true];
                        };
                }];
    }, true, [], true] call CBA_fnc_addClassEventHandler;


     ["missionControl_curatorInfo", {
        params ["_unit", "_type"];

        private _message = "";
        private _color = [0,0,0,1];

        switch (_type) do {
            case ("spectating"): {
                _message = format ["%1 choose spectator.", [_unit, false, true] call ace_common_fnc_getName];
                _color = [0.5,0.1,0.1,1];
            };
            case ("unconscious"): {
                _message = format ["%1 was knocked out.", [_unit, false, true] call ace_common_fnc_getName];
                _color = [0.5,0.1,0.1,1];
            };
            case ("respawned"): {
                _message = format ["%1 respawned.", [_unit, false, true] call ace_common_fnc_getName];
                _color = [0.1,0.5,0.1,1];
            };
            case ("wokeup"): {
                _message = format ["%1 woke up.", [_unit, false, true] call ace_common_fnc_getName];
                _color = [0.1,0.5,0.1,1];
            };
            case ("killed"): {
                _message = format ["%1 killed.", [_unit, false, true] call ace_common_fnc_getName];
                _color = [0.7,0.1,0.1,1];
            };
            default {};
        };

        // send message to all curators
        {
            private _playerAsZeus = getAssignedCuratorUnit _x;
            if (!isNull _playerAsZeus) then {
                [_message, _color] remoteExec ["grad_zeus_fnc_curatorShowFeedbackMessage", _playerAsZeus];
            };
        } forEach allCurators;
    }] call CBA_fnc_addEventHandler;


    {
        private _unit = _x;
        _unit addMPEventHandler ["MPKilled", {
        params ["_unit", "_killer", "_instigator", "_useEffects"];
            
            if (!isServer) exitWith {};

            ["missionControl_curatorInfo", [_unit, "killed"]] call CBA_fnc_serverEvent;

            if (side _killer == west) then {

                if (_killer getVariable ["grad_customGroup", "none"] == "reaper") then {
                        ["reaper"] spawn grad_zeus_fnc_setPenalty;
                };

                if (_killer getVariable ["grad_customGroup", "none"] == "crawler") then {
                        ["crawler"] spawn grad_zeus_fnc_setPenalty;
                };

                if (_killer getVariable ["grad_customGroup", "none"] == "blades") then {
                        ["blades"] spawn grad_zeus_fnc_setPenalty;
                };

            };
        }];

    } forEach (playableUnits + switchableUnits);

    ["ace_flags_carrier_yellow", "init", {
            
            private _flag = (_this select 0);
            
            _flag forceFlagTexture "data\crawler.paa";

    }, true, [], true] call CBA_fnc_addClassEventHandler;


    ["ace_flags_carrier_red", "init", {
            
            private _flag = (_this select 0);
            
            _flag forceFlagTexture "data\blades.paa";

    }, true, [], true] call CBA_fnc_addClassEventHandler;


    ["ace_flags_carrier_green", "init", {
            
            private _flag = (_this select 0);
            
            _flag forceFlagTexture "data\reaper.paa";

    }, true, [], true] call CBA_fnc_addClassEventHandler;

};