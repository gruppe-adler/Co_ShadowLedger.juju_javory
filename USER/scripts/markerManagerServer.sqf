if (!isServer) exitWith {};

private _triggerArray = [
    trg_poi_1,
    trg_poi_2,
    trg_poi_3,
    trg_poi_4,
    trg_poi_5
];

grad_victorypoints_reaper = 0;
grad_victorypoints_crawler = 0;
grad_victorypoints_blades = 0;

{
    // create markers for the POIs
    private _markerName = format ["%1_marker", _x];
    if (isNil _markerName) then {
        _markerName = createMarker [_markerName, getPosATL _x];
    };
    private _index = _foreachIndex + 1;
    _markerName setMarkerType "loc_move";
    _markerName setMarkerColor "ColorBlack";
    _markerName setMarkerText ("POI " + str _index);
    _markerName setMarkerPos (getPosATL _x);
} forEach _triggerArray;

grad_fnc_manageTrigger = {
    params ["_trigger"];

    private _reaperCount = 0; // green
    private _crawlerCount = 0; // yellow
    private _bladesCount = 0; // red
    private _highestVarNames = []; // to store the names of the highest variables

    private _highestColor = "ColorBlack";

    private _marker = str _trigger + "_marker";
    // diag_log ("checking " + _marker);

    if (_marker == "") then { continue }; // skip if no marker found

    {
        private _relevant = _x isKindOf "ace_flags_carrier_green" || 
                            _x isKindOf "ace_flags_carrier_yellow" || 
                            _x isKindOf "ace_flags_carrier_red";
        if (!_relevant) then { continue }; // skip if no flag found

        // hint ("found a flag " + str _x);

        if (count ([_x] inAreaArray _trigger) > 0) then {
            if (_x isKindOf "ace_flags_carrier_green") then {
                _reaperCount = _reaperCount + 1;
            };
            if (_x isKindOf "ace_flags_carrier_yellow") then {
                _crawlerCount = _crawlerCount + 1;
            };
            if (_x isKindOf "ace_flags_carrier_red") then {
                _bladesCount = _bladesCount + 1;
            };
        };
       
    } forEach allMissionObjects "";

     // Determine the actual highest value first
        private _highestValue = _reaperCount max _crawlerCount max _bladesCount;

        // Now, check which variables match that highest value
        if (count _highestVarNames > 1) then {
           _highestColor = "ColorBlack"; // multiple highest, set to black
        } else {
            if (_reaperCount == _highestValue && _highestValue != 0) then {
                _highestVarNames pushBack "reaper";
                _highestColor = "ColorGreen";
                grad_victorypoints_reaper = grad_victorypoints_reaper + 1;
                missionNameSpace setVariable ["grad_victorypoints_reaper", grad_victorypoints_reaper, true];
            };
            if (_crawlerCount == _highestValue && _highestValue != 0) then {
                _highestVarNames pushBack "crawler";
                _highestColor = "ColorYellow";
                grad_victorypoints_crawler = grad_victorypoints_crawler + 1;
                missionNameSpace setVariable ["grad_victorypoints_crawler", grad_victorypoints_crawler, true];
            };
            if (_bladesCount == _highestValue && _highestValue != 0) then {
                _highestVarNames pushBack "blades";
                _highestColor = "ColorRed";
                grad_victorypoints_blades = grad_victorypoints_blades + 1;
                missionNameSpace setVariable ["grad_victorypoints_blades", grad_victorypoints_blades, true];
            };
        };

        /* diag_log format ["victorypoints: reaper %1, reaper %2, blades %3, highest color: %4", 
            grad_victorypoints_reaper, 
            grad_victorypoints_crawler, 
            grad_victorypoints_blades, 
            _highestColor];
        */

        _marker setMarkerColor _highestColor;
};

[{
    params ["_args", "_handle"];
    _args params ["_triggerArray"];
    
    {
        [_x] call grad_fnc_manageTrigger;
    } forEach _triggerArray;


    if (missionNameSpace getVariable ["grad_flagGameOver", false]) then {
        {
            private _marker = str _x + "_marker";
            _marker setMarkerColor "ColorWhite";
        } forEach _triggerArray;

        [_handle] call CBA_fnc_removePerFrameHandler;
    };

}, 1, [_triggerArray]] call CBA_fnc_addPerFrameHandler;
