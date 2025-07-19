if (!isServer || !canSuspend) exitWith { _this remoteExec [_fnc_scriptName, 2]; };

private _heli1Arr = [[random 200, random 200, 100 + random 100], 0, "RHS_Mi8mt_vdv", east] call BIS_fnc_spawnVehicle;
_heli1Arr params ["_heli1", "_heli1CrewObjects", "_heli1Crew"];
_heli1 allowDamage false;
_heli1Crew setBehaviour "CARELESS";

sleep 0.5;

private _heli2Arr = [[random 200, random 200, 100 + random 100], 0, "RHS_Mi8mt_vdv", east] call BIS_fnc_spawnVehicle;
_heli2Arr params ["_heli2", "_heli2CrewObjects", "_heli2Crew"];
_heli2 allowDamage false;
_heli2Crew setBehaviour "CARELESS";

sleep 0.5;

private _heli3Arr = [[random 200, random 200, 100 + random 100], 0, "RHS_Mi8mt_vdv", east] call BIS_fnc_spawnVehicle;
_heli3Arr params ["_heli3", "_heli3CrewObjects", "_heli3Crew"];
_heli3 allowDamage false;
_heli3Crew setBehaviour "CARELESS";

sleep 0.5;

[_heli1] call BP_obj2_fnc_playLanding_NW;
[_heli2] call BP_obj2_fnc_playLanding_E;
[_heli3] call BP_obj2_fnc_playLanding_W;

_heli1 allowDamage true;
_heli2 allowDamage true;
_heli3 allowDamage true;

private _heli1Waypoint = _heli1Crew addWaypoint [[9488.98,4171.18,0], 0];
_heli1Waypoint setWaypointType "SCRIPTED";
_heli1Waypoint setWaypointScript "A3\functions_f\waypoints\fn_wpLand.sqf";
private _unloadWP1 = _heli1Crew addWaypoint [[9496.47,4155.28,0], 1];
_unloadWP1 setWaypointType "TR UNLOAD";

private _heli2Waypoint = _heli2Crew addWaypoint [[10110.4,4023.79,0], 0];
_heli2Waypoint setWaypointType "SCRIPTED";
_heli2Waypoint setWaypointScript "A3\functions_f\waypoints\fn_wpLand.sqf";
private _unloadWP2 = _heli2Crew addWaypoint [[10091.9,4023.86,0], 1];
_unloadWP2 setWaypointType "TR UNLOAD";

private _heli3Waypoint = _heli3Crew addWaypoint [[9355.87,3741.11,3.67567], 0];
_heli3Waypoint setWaypointType "SCRIPTED";
_heli3Waypoint setWaypointScript "A3\functions_f\waypoints\fn_wpLand.sqf";
private _unloadWP3 = _heli3Crew addWaypoint [[9374.59,3733.42,0], 1];
_unloadWP3 setWaypointType "TR UNLOAD";

// HANDLE TRANSPORT
private _groups = [];
private _tempGroups = [];
{
	private _currentHeli = _x;
	_tempGroups = [];
	for "_i" from 1 to 2 do {		
		private _unitArr = ["rhs_vdv_recon_sergeant", "rhs_vdv_recon_efreitor", "rhs_vdv_recon_arifleman", "rhs_vdv_recon_machinegunner_assistant", "rhs_vdv_recon_rifleman_lat", "rhs_vdv_recon_grenadier", "rhs_vdv_recon_rifleman"];
		private _grp = createGroup east;
		_tempGroups pushBack _grp;
		{
			private _unit = _grp createUnit [_x, [random 25, random 25, 0], [], 0, "NONE"];
			_unit assignAsCargo _currentHeli;
			_unit moveInCargo _currentHeli;
			sleep 0.5;
		} forEach _unitArr;
	};
	_groups pushBack _tempGroups;
} forEach [_heli1, _heli2, _heli3];

_groups params ["_infHeli1", "_infHeli2", "_infHeli3"];

// Inf-Waypoints Heli 1 (NW)
private _attackWP1 = (_infHeli1 # 0) addWaypoint [[9682.87,3863.84,0], 1];
_attackWP1 setWaypointSpeed "FULL";
private _attackWP2 = (_infHeli1 # 1) addWaypoint [[9702.84,3965.13,0], 1];
_attackWP2 setWaypointSpeed "FULL";

// Inf-Waypoints Heli 2 (E)
_attackWP1 = (_infHeli2 # 0) addWaypoint [[9773.38,3896.11,0], 1];
_attackWP1 setWaypointSpeed "FULL";
_attackWP2 = (_infHeli2 # 1) addWaypoint [[9723.14,3905.93,0], 1];
_attackWP2 setWaypointSpeed "FULL";

// Inf-Waypoints Heli 3 (W)
_attackWP1 = (_infHeli3 # 0) addWaypoint [[9744.65,3959.66,0], 1];
_attackWP1 setWaypointSpeed "FULL";
_attackWP2 = (_infHeli3 # 1) addWaypoint [[9709.77,3906.68,0], 1];
_attackWP2 setWaypointSpeed "FULL";


// STOP BOUNCE

{
	_x params ["_heli", "_groups", "_crew"];
	
	[
		{
			params ["_heli"];
			(isTouchingGround _heli) && (alive _heli)
		},
		{
			params ["_heli", "_groups", "_index", "_crew"];
			
			[
				{
					params ["_heli", "_crew"];

					{
						deleteVehicle _x;
					} forEach _crew;

					[
						{
							params ["_args", "_handle"];
							_args params ["_heli", "_time"];

							if ((CBA_missionTime - _time) > 5) exitWith {
								[_handle] call CBA_fnc_removePerFrameHandler;
							};
							
							private _vel = velocity _heli;
							_heli setVelocity [_vel # 0, _vel # 1, -1];
						},
						0,
						[_heli, CBA_missionTime]
					] call CBA_fnc_addPerFrameHandler;
				},
				[_heli, _crew],
				3
			] call CBA_fnc_waitAndExecute;
			
			
			private _handle = 
			[
				{
					params ["_args", "_handle"];
					_args params ["_heli", "_groups"];

					private _units = [];
					{
						_units = _units + (units _x);
					} forEach _groups;
					
					if (((_units select { !(isNull (objectParent _x)) }) isEqualTo [])) exitWith {
						[_handle] call CBA_fnc_removePerFrameHandler;
					};

					if !(isEngineOn _heli) then {
						_heli engineOn true;
					};
				},
				0,
				[_heli, _groups]
			] call CBA_fnc_addPerFrameHandler;


			[
				{
					params ["_heli", "_groups"];
					private _units = [];
					{
						_units = _units + (units _x);
					} forEach _groups;
					(_units select { !(isNull (objectParent _x)) }) isEqualTo []
				},
				{
					params ["_heli", "_groups", "_index"];
					private _units = [];
					{
						_units = _units + (units _x);
					} forEach _groups;

					if !(alive _heli) exitWith { };
					// private _driver = (createGroup independent) createUnit ["rhs_pilot_transport_heli", [-10, -10, 0], [], 0, "NONE"];
					// _driver assignAsDriver _heli;
					// _driver moveInDriver _heli;
					private _newCrew = createVehicleCrew _heli;
					
					switch (_index) do {
						case 0: { [_heli] call BP_obj2_fnc_playRTB_NW; };
						case 1: { [_heli] call BP_obj2_fnc_playRTB_E; };
						case 2: { [_heli] call BP_obj2_fnc_playRTB_W; };
					};

					[
						{
							params ["_heli"];
							
							if (!(alive _heli) || (isNull _heli)) exitWith {};
							
							{
								deleteVehicle _x;							
							} forEach (crew _heli) + [_heli];
						},
						[_heli],
						100
					] call CBA_fnc_waitAndExecute;
				},
				[_heli, _groups, _index]
			] call CBA_fnc_waitUntilAndExecute;
		},
		[_heli, _groups, _foreachIndex, _crew],
		300
	] call CBA_fnc_waitUntilAndExecute;
} forEach [[_heli1, _infHeli1, _heli1CrewObjects], [_heli2, _infHeli2, _heli2CrewObjects], [_heli3, _infHeli3, _heli3CrewObjects]];
