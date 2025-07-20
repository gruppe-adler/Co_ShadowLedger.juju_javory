params ["_customGroup"];

private _penalty1 = -1000;
private _penalty2 = -2000;
private _penalty3 = -3000;

sleep 15 + random 10;

switch (_customGroup) do {
    case "reaper": {
        private _count = missionNameSpace getVariable ["grad_blueonblue_reaper", 0];
        private _penalty = missionNameSpace getVariable ["grad_penalty_reaper", _penalty1];

        _count = _count + 1;
        // PENALTY 1
        if (_count == 1) then {
            [
                ["Who the hell was that?! I just saw one of the other blues go down under friendly fire! You blind, deaf, or just plain stupid? That's a thousand credits GONE. If I find out who pulled that trigger, they're gonna be eating their own boots!", 
                    "reaper_blueonblue_1", 
                    18,
                    "reaper"
            ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];

        } else 
        { 
            if (_count == 5) then {
            // PENALTY 2
            missionNameSpace setVariable ["grad_penalty_reaper", _penalty2, true];
            [
                ["Alright, listen up, you pack of brain-dead idiots! The government just upped the ante. Anyone caught with their finger on the trigger, hitting a friendly, is now out TWO THOUSAND CREDITS! Yeah, you heard me! Two grand! You wanna gamble with my money, you better be ready to lose a lot more than that.", 
                    "reaper_blueonblue_2", 
                    25,
                    "reaper"
            ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"]; 

        } else {
            if (_count == 10) then {
            // PENALTY 3
            missionNameSpace setVariable ["grad_penalty_reaper", _penalty3, true];
             [
                ["You pathetic excuses for mercenaries! News just came down: Blue on Blue now costs THREE THOUSAND CREDITS! If you're too damn incompetent to tell a friendly from a target, then you're too damn incompetent to be out here! I'll personally make sure every last credit of that fine comes straight out of your pay, and then some!", 
                    "reaper_blueonblue_3", 
                    30,
                    "reaper"
            ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];
            };
        };
        };
        
        grad_victorypoints_reaper = grad_victorypoints_reaper + _penalty;
        missionNameSpace setVariable ["grad_victorypoints_reaper", grad_victorypoints_reaper, true];
    };


    case "crawler": {
        private _count = missionNameSpace getVariable ["grad_blueonblue_crawler", 0];
        private _penalty = missionNameSpace getVariable ["grad_penalty_crawler", _penalty1];

        _count = _count + 1;
        // PENALTY 1
        if (_count == 1) then {
            [
                ["Who the hell was that?! I just saw one of the other blues go down under friendly fire! You blind, deaf, or just plain stupid? That's a thousand credits GONE. If I find out who pulled that trigger, they're gonna be eating their own boots!", 
                    "crawler_blueonblue_1", 
                    20,
                    "crawler"
            ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"]; 

        } else {
            if (_count == 5) then {
            // PENALTY 2
            missionNameSpace setVariable ["grad_penalty_crawler", _penalty2, true];
            [
                ["Alright, listen up, you pack of brain-dead idiots! The government just upped the ante. Anyone caught with their finger on the trigger, hitting a friendly, is now out TWO THOUSAND CREDITS! Yeah, you heard me! Two grand! You wanna gamble with my money, you better be ready to lose a lot more than that.", 
                    "crawler_blueonblue_2", 
                    32,
                    "crawler"
            ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"]; 
            } else {
            if (_count == 10) then {
            // PENALTY 3
            missionNameSpace setVariable ["grad_penalty_crawler", _penalty3, true];
             [
                ["You pathetic excuses for mercenaries! News just came down: Blue on Blue now costs THREE THOUSAND CREDITS! If you're too damn incompetent to tell a friendly from a target, then you're too damn incompetent to be out here! I'll personally make sure every last credit of that fine comes straight out of your pay, and then some!", 
                    "crawler_blueonblue_3", 
                    42,
                    "crawler"
            ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];
            };
        };
        };
        grad_victorypoints_crawler = grad_victorypoints_crawler + _penalty;
        missionNameSpace setVariable ["grad_victorypoints_crawler", grad_victorypoints_crawler, true];
    };



    case "blades": {
        private _count = missionNameSpace getVariable ["grad_blueonblue_blades", 0];
        private _penalty = missionNameSpace getVariable ["grad_penalty_blades", _penalty1];

        _count = _count + 1;
        // PENALTY 1
        if (_count == 1) then {
            [
                ["Who the hell was that?! I just saw one of the other blues go down under friendly fire! You blind, deaf, or just plain stupid? That's a thousand credits GONE. If I find out who pulled that trigger, they're gonna be eating their own boots!", 
                    "blades_blueonblue_1", 
                    15,
                    "blades"
            ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];

        } else {
            if (_count == 5) then {
                // PENALTY 2
                missionNameSpace setVariable ["grad_penalty_blades", _penalty2, true];
                [
                    ["Alright, listen up, you pack of brain-dead idiots! The government just upped the ante. Anyone caught with their finger on the trigger, hitting a friendly, is now out TWO THOUSAND CREDITS! Yeah, you heard me! Two grand! You wanna gamble with my money, you better be ready to lose a lot more than that.", 
                        "blades_blueonblue_2", 
                        24,
                        "blades"
                ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"]; 
        } else {
            if (_count == 10) then {
            // PENALTY 3
            missionNameSpace setVariable ["grad_penalty_blades", _penalty3, true];
             [
                ["You pathetic excuses for mercenaries! News just came down: Blue on Blue now costs THREE THOUSAND CREDITS! If you're too damn incompetent to tell a friendly from a target, then you're too damn incompetent to be out here! I'll personally make sure every last credit of that fine comes straight out of your pay, and then some!", 
                    "blades_blueonblue_3", 
                    23,
                    "blades"
            ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];
            };
         };
        };
        grad_victorypoints_blades = grad_victorypoints_blades + _penalty;
        missionNameSpace setVariable ["grad_victorypoints_blades", grad_victorypoints_blades, true];
    };
 
    default {
        diag_log format ["Unknown custom group: %1", _customGroup];
    };
};