if (!isServer) exitWith {};

// curator infos
["missionControl_curatorInfo", {
    params ["_unit", "_type", "_text"];

    private _message = "";
    private _color = [0,0,0,1];

    switch (_type) do {
        case ("unconscious"): {
            _message = format ["%1 was knocked out.", [_unit, false, true] call ace_common_fnc_getName];
            _color = [0.5,0.1,0.1,1];

            [_unit, false] remoteExec ["allowDamage", _unit];
        };
        case ("revived"): {
            _message = format ["%1 got revived.", [_unit, false, true] call ace_common_fnc_getName];
            _color = [0.1,0.5,0.5,1];

             [_unit, true] remoteExec ["allowDamage", _unit];
        };
        case ("respawned"): {
            _message = format ["%1 respawned.", [_unit, false, true] call ace_common_fnc_getName];
            _color = [0.1,0.5,0.1,1];
        };
        case ("killed"): {
            _message = format ["%1 killed.", [_unit, false, true] call ace_common_fnc_getName];
            _color = [0.7,0.1,0.1,1];
        };
        case ("segmentintel"): {
            _message = format ["%1 got segment intel: %2", [_unit, false, true] call ace_common_fnc_getName, _text];
            _color = [0.7,0.1,0.1,1];
        };
        case ("customintel"): {
            _message = format ["%1 got private intel: %2", [_unit, false, true] call ace_common_fnc_getName, _text];
            _color = [0.7,0.1,0.1,1];
        };
        case ("susvalue"): {
            _message = format ["%1 : %2", [_unit, false, true] call ace_common_fnc_getName, _text];
            _color = [0.7,0.1,0.1,1];
        };
        default {
            _message = format ["%1 got input intel: %2", [_unit, false, true] call ace_common_fnc_getName, _text];
            _color = [0.7,0.1,0.1,1];
        };
    };

    // send message to all curators
    {
        private _playerAsZeus = getAssignedCuratorUnit _x;
        if (!isNull _playerAsZeus) then {
            [_message, _color] remoteExec ["grad_zeus_fnc_curatorShowFeedbackMessage", _playerAsZeus];
        };
    } forEach allCurators;
}] call CBA_fnc_addEventHandler;


["GRAD_intel_upload_completed", {

    // send message to all curators
    {
        private _playerAsZeus = getAssignedCuratorUnit _x;
        if (!isNull _playerAsZeus) then {
            private _color = [0.1,0.5,0.1,1];
            ["INTEL UPLOAD COMPLETE!", _color] remoteExec ["grad_zeus_fnc_curatorShowFeedbackMessage", _playerAsZeus];
        };
    } forEach allCurators;
}] call CBA_fnc_addEventHandler;


["GRAD_submarine_countdown_stopped", {

    // send message to all curators
    {
        private _playerAsZeus = getAssignedCuratorUnit _x;
        if (!isNull _playerAsZeus) then {
            private _color = [0.1,0.5,0.1,1];
            ["COUNTDOWN SUBMARINE STOPPED!", _color] remoteExec ["grad_zeus_fnc_curatorShowFeedbackMessage", _playerAsZeus];
        };
    } forEach allCurators;
}] call CBA_fnc_addEventHandler;


["GRAD_playersCaptive", {

    // send message to all curators
    {
        private _playerAsZeus = getAssignedCuratorUnit _x;
        if (!isNull _playerAsZeus) then {
            private _color = [0.1,0.5,0.1,1];
            ["KRAKEN HQ is enemy", _color] remoteExec ["grad_zeus_fnc_curatorShowFeedbackMessage", _playerAsZeus];
        };
    } forEach allCurators;
}] call CBA_fnc_addEventHandler;


["GRAD_krakenhq_disableAI", {

    // send message to all curators
    {
        private _playerAsZeus = getAssignedCuratorUnit _x;
        if (!isNull _playerAsZeus) then {
            private _color = [1,0.5,0.1,1];
            ["KRAKEN HQ is disabled", _color] remoteExec ["grad_zeus_fnc_curatorShowFeedbackMessage", _playerAsZeus];
        };
    } forEach allCurators;
}] call CBA_fnc_addEventHandler;



["GRAD_krakenhq_enableAI", {

    // send message to all curators
    {
        private _playerAsZeus = getAssignedCuratorUnit _x;
        if (!isNull _playerAsZeus) then {
            private _color = [0.1,1,0.1,1];
            ["KRAKEN HQ is enabled", _color] remoteExec ["grad_zeus_fnc_curatorShowFeedbackMessage", _playerAsZeus];
        };
    } forEach allCurators;
}] call CBA_fnc_addEventHandler;





["GRAD_intelDestroyed1", {

    // send message to all curators
    {
        private _playerAsZeus = getAssignedCuratorUnit _x;
        if (!isNull _playerAsZeus) then {
            private _color = [0.1,1,0.1,1];
            ["Intel 1 destroyed", _color] remoteExec ["grad_zeus_fnc_curatorShowFeedbackMessage", _playerAsZeus];
        };
    } forEach allCurators;
}] call CBA_fnc_addEventHandler;


["GRAD_intelDestroyed2", {

    // send message to all curators
    {
        private _playerAsZeus = getAssignedCuratorUnit _x;
        if (!isNull _playerAsZeus) then {
            private _color = [0.1,1,0.1,1];
            ["Intel 2 destroyed", _color] remoteExec ["grad_zeus_fnc_curatorShowFeedbackMessage", _playerAsZeus];
        };
    } forEach allCurators;
}] call CBA_fnc_addEventHandler;


["GRAD_astronautKilled", {

    // send message to all curators
    {
        private _playerAsZeus = getAssignedCuratorUnit _x;
        if (!isNull _playerAsZeus) then {
            private _color = [0.1,1,0.1,1];
            ["Astronaut was killed", _color] remoteExec ["grad_zeus_fnc_curatorShowFeedbackMessage", _playerAsZeus];
        };
    } forEach allCurators;
}] call CBA_fnc_addEventHandler;


["GRAD_traptriggered", {

    // send message to all curators
    {
        private _playerAsZeus = getAssignedCuratorUnit _x;
        if (!isNull _playerAsZeus) then {
            private _color = [1,0,0.1,1];
            ["Trap was triggered", _color] remoteExec ["grad_zeus_fnc_curatorShowFeedbackMessage", _playerAsZeus];
        };
    } forEach allCurators;
}] call CBA_fnc_addEventHandler;


