if (!isServer || !canSuspend) exitWith { _this remoteExec [_fnc_scriptName, 2]; };

private _heli1Arr = [[random 300, random 300, 200 + random 100], 0, "UK3CB_ION_O_Urban_Bell412_FLIR", east] call BIS_fnc_spawnVehicle;
_heli1Arr params ["_heli1", "_heli1CrewObjects", "_heli1Crew"];
_heli1 allowDamage false;
_heli1Crew setBehaviour "CARELESS";

sleep 0.5;

private _heli2Arr = [[random 300, random 300, 200 + random 100], 0, "UK3CB_ION_O_Urban_Bell412_FLIR", east] call BIS_fnc_spawnVehicle;
_heli2Arr params ["_heli2", "_heli2CrewObjects", "_heli2Crew"];
_heli2 allowDamage false;
_heli2Crew setBehaviour "CARELESS";

sleep 0.5;

[_heli1] call BP_ambush_fnc_playLanding_N;
sleep 0.5;
[_heli2] call BP_ambush_fnc_playLanding_W;
sleep 0.5;

private _heli1Waypoint = _heli1Crew addWaypoint [[9541.41,7121.64,0], 0];
_heli1Waypoint setWaypointType "SCRIPTED";
_heli1Waypoint setWaypointScript "A3\functions_f\waypoints\fn_wpLand.sqf";
private _unloadWP1 = _heli1Crew addWaypoint [[9509.35,7116.81,0], 1];
_unloadWP1 setWaypointType "TR UNLOAD";

private _heli2Waypoint = _heli2Crew addWaypoint [[9294.04,6846.49,0], 0];
_heli2Waypoint setWaypointType "SCRIPTED";
_heli2Waypoint setWaypointScript "A3\functions_f\waypoints\fn_wpLand.sqf";
private _unloadWP2 = _heli2Crew addWaypoint [[9304.17,6843.61,0], 1];
_unloadWP2 setWaypointType "TR UNLOAD";

// HANDLE TRANSPORT
private _groups = [];
private _tempGroups = [];
{
	private _currentHeli = _x;
	_tempGroups = [];		
	private _unitArr = ["UK3CB_ION_O_Urban_SL", "UK3CB_ION_O_Urban_TL", "UK3CB_ION_O_Urban_MD", "UK3CB_ION_O_Urban_RIF_1", "UK3CB_ION_O_Urban_LAT", "UK3CB_ION_O_Urban_RIF_1", "UK3CB_ION_O_Urban_ENG", "UK3CB_ION_O_Urban_DEM", "UK3CB_ION_O_Urban_MG"];
	private _grp = createGroup east;
	_tempGroups pushBack _grp;
	{
		private _unit = _grp createUnit [_x, [random 25, random 25, 0], [], 0, "NONE"];
		_unit assignAsCargo _currentHeli;
		_unit moveInCargo _currentHeli;
		sleep 0.5;
	} forEach _unitArr;
	_groups pushBack _tempGroups;
} forEach [_heli1, _heli2];

_groups params ["_infHeli1", "_infHeli2"];

// Inf-Waypoints Heli 1 (N)
private _attackWP1 = (_infHeli1 # 0) addWaypoint [[9476.94,6935.91,0], 1];
_attackWP1 setWaypointSpeed "FULL";

// Inf-Waypoints Heli 2 (W)
_attackWP1 = (_infHeli2 # 0) addWaypoint [[9460.94,6926.63,0], 1];
_attackWP1 setWaypointSpeed "FULL";


_heli1 allowDamage true;
_heli2 allowDamage true;


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
				1,
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
					private _newCrew = createVehicleCrew _heli;
					
					switch (_index) do {
						case 0: { [_heli] call BP_ambush_fnc_playRTB_N; };
						case 1: { [_heli] call BP_ambush_fnc_playRTB_W; };
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
						73
					] call CBA_fnc_waitAndExecute;
				},
				[_heli, _groups, _index]
			] call CBA_fnc_waitUntilAndExecute;
		},
		[_heli, _groups, _foreachIndex, _crew],
		300
	] call CBA_fnc_waitUntilAndExecute;
} forEach [[_heli1, _infHeli1, _heli1CrewObjects], [_heli2, _infHeli2, _heli2CrewObjects]];
