/*
*   Wird zum Missionsstart auf Server und Clients ausgeführt.
*   Funktioniert wie die init.sqf.
*/


// add custom BFT, disable ace BFT
[] execVM "user\scripts\customBFT.sqf";
[] execVM "user\scripts\markerManagerServer.sqf";

if (hasInterface) then {
    // add custom BFT to client
    [] execVM "user\scripts\transferRadiosAcrossRespawn.sqf";

    ["Man", "init", {      
            (_this select 0) setVariable ["lambs_danger_disableAI", true, true];
    }, true, [], true] call CBA_fnc_addClassEventHandler;
};

if (isServer) then {

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