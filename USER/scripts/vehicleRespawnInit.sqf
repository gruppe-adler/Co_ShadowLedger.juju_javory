/*
*   Safe Vehicle Respawn Initialization
*   This script automatically finds and sets up respawn for all vehicles
*   that have been marked for respawn in the editor.
*/

if (!isServer) exitWith {};

diag_log "grad-vehicleRespawn: Starting vehicle respawn initialization (step 1)...";

// Wait for mission to be fully loaded
waitUntil { 
    sleep 0.1;
    time > 3 && !isNil "CBA_fnc_addPerFrameHandler" 
};

diag_log "grad-vehicleRespawn: CBA loaded (step 2)...";

// Wait for the vehicle respawn functions to be available
waitUntil { 
    sleep 0.1;
    !isNil "GRAD_simpleVehicleRespawn_fnc_add" 
};

diag_log "grad-vehicleRespawn: Vehicle respawn functions loaded (step 3)...";

// Small additional delay to ensure everything is ready
sleep 2;

diag_log "grad-vehicleRespawn: Starting safe vehicle respawn initialization...";

// Find all vehicles that should respawn
private _respawnVehicles = [];

// Method 1: Find vehicles by variable (recommended)
// In the editor, set vehicles' init to: this setVariable ["respawnEnabled", true];
{
    if (_x getVariable ["respawnEnabled", false]) then {
        _respawnVehicles pushBack _x;
    };
} forEach vehicles;

// Method 2: If no vehicles found with respawnEnabled, try to respawn all vehicles except certain types
if (count _respawnVehicles == 0) then {
    diag_log "grad-vehicleRespawn: No vehicles marked with 'respawnEnabled', checking all vehicles...";
    {
        // Skip certain vehicle types that shouldn't respawn
        private _vehType = typeOf _x;
        private _skip = false;
        
        // Skip if it's a static weapon, empty vehicle, or certain other types
        if (_vehType in [
            "", 
            "Logic", 
            "ModuleGeneric_F",
            "Land_HelipadEmpty_F"
        ]) then {
            _skip = true;
        };
        
        // Skip if it's a man/unit
        if (_x isKindOf "Man") then {
            _skip = true;
        };
        
        if (!_skip) then {
            _respawnVehicles pushBack _x;
            diag_log format ["grad-vehicleRespawn: Found vehicle: %1 (%2)", typeOf _x, _x];
        };
    } forEach vehicles;
};

diag_log format ["grad-vehicleRespawn: Found %1 vehicles for respawn initialization", count _respawnVehicles];

// Initialize respawn for each vehicle with error handling
private _successCount = 0;
private _failCount = 0;

{
    private _vehicle = _x;
    private _vehicleType = typeOf _vehicle;
    private _displayName = getText(configFile >> "CfgVehicles" >> _vehicleType >> "displayName");
    
    try {
        // Call the function safely
        [_vehicle] call GRAD_simpleVehicleRespawn_fnc_add;
        _successCount = _successCount + 1;
        diag_log format ["grad-vehicleRespawn: ✓ Successfully initialized respawn for %1 (%2)", _displayName, _vehicle];
    } catch {
        _failCount = _failCount + 1;
        diag_log format ["grad-vehicleRespawn: ✗ ERROR - Failed to initialize respawn for %1: %2", _displayName, _exception];
    };
    
    // Small delay between vehicles to prevent overload
    sleep 0.1;
    
} forEach _respawnVehicles;

diag_log format ["grad-vehicleRespawn: Vehicle respawn initialization completed. Success: %1, Failed: %2", _successCount, _failCount];
