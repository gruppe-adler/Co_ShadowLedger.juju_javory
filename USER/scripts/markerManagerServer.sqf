if (!isServer) exitWith {};

private _triggerArray = [
    trg_poi_1,
    trg_poi_2,
    trg_poi_3,
    trg_poi_4,
    trg_poi_5
];

grad_victorypoints_raiders = 0;
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

    _x setVariable ["poi_marker", _markerName, true];
} forEach _triggerArray;

private _manageTrigger = {
    params ["_trigger"];
    
    private _raiderCount = 0; // green
    private _crawlerCount = 0; // yellow
    private _bladesCount = 0; // red

    private _highestColor = "ColorBlack";

    private _marker = _trigger getVariable ["poi_marker", ""];

    {
        if (_x inAreaArray _trigger) then {
            if (_x isKindOf "ace_flags_carrier_green") then {
                _raiderCount = _raiderCount + 1;
            };
            if (_x isKindOf "ace_flags_carrier_yellow") then {
                _crawlerCount = _crawlerCount + 1;
            };
            if (_x isKindOf "ace_flags_carrier_yellow") then {
                _bladesCount = _bladesCount + 1;
            };
        };
        // Determine the actual highest value first
        private _highestValue = _raiderCount max _crawlerCount max _bladesCount;

        // Now, check which variables match that highest value
        if (_raiderCount == _highestValue) then {
            _highestVarNames pushBack "raider";
            _highestColor = "ColorGreen";
            grad_victorypoints_raiders = grad_victorypoints_raiders + 1;
        };
        if (_crawlerCount == _highestValue) then {
            _highestVarNames pushBack "crawler";
            _highestColor = "ColorYellow";
            grad_victorypoints_crawler = grad_victorypoints_crawler + 1;
        };
        if (_bladesCount == _highestValue) then {
            _highestVarNames pushBack "blades";
             _highestColor = "ColorRed";
             grad_victorypoints_blades = grad_victorypoints_blades + 1;
        };
        if (count _highestVarNames > 1) then {
           _highestColor = "ColorBlack"; // multiple highest, set to black
        };

        diag_log format ["victorypoints: raiders %1, crawlers %2, blades %3, highest color: %4", 
            grad_victorypoints_raiders, 
            grad_victorypoints_crawler, 
            grad_victorypoints_blades, 
            _highestColor];

        _marker setMarkerColor _highestColor;
    } forEach entities;
};

[{
    params ["_args", "_handle"];
    _args params ["_triggerArray", "_manageTrigger"];
    
    {
        [_x] call _manageTrigger;
    } forEach _triggerArray;

}, 1, [_triggerArray, _manageTrigger]] call CBA_fnc_addPerFrameHandler;