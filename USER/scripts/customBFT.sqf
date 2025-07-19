if (isServer) then {
	
	ace_map_BFT_Enabled = false;
	publicVariable "ace_map_BFT_Enabled";
	/*
	{ 
		_x setVariable ["ace_map_hideBlueForceMarker", false, true]; 
	} forEach (allUnits);
	*/

};

if (hasInterface) then {

	[{
		private _playerGroupIdentifier = player getVariable ["grad_customGroup", "none"];

		if (_playerGroupIdentifier == "zeus") exitWith {
			// diag_log "PANIC: no custom group set!";
			// hint "PANIC: no custom group set!";
		};

		if (!isNil "GRAD_custom_bft_markers") then {
			{
				deleteMarkerLocal _x;
			} forEach GRAD_custom_bft_markers;
		};

		GRAD_custom_bft_markers = []; // local cache

		{
			// sp testable isplayer
			if (
				(leader _x) in (playableUnits + switchableUnits) && 
				(isNull (getAssignedCuratorLogic player) || !isMultiplayer)
			) then {

				private _groupIdentifier = (leader _x) getVariable ["grad_customGroup", "none"];
				
				if (_playerGroupIdentifier == _groupIdentifier && _groupIdentifier != "none") then {
					
					private _name = _x getVariable ["ACE_name", ""];
					private _markername = (groupId _x) + _name + "_custom_bft_marker";
					if (isNil _markername) then {
						_markername = createMarkerLocal [_markername, getPos _x];
					};
					private _markerType = [_x] call ace_common_fnc_getMarkerType;
					private _colour = format ["Color%1", side _x];
					_markername setMarkerTypeLocal _markerType;
					_markername setMarkerColorLocal _colour;
					_markername setMarkerTextLocal (_playerGroupIdentifier + " - " + _name);
					_markername setMarkerPosLocal (getPos _x);
					GRAD_custom_bft_markers pushBack _markername;
				};
			};
		} forEach (playableUnits + switchableUnits);

	}, 1, []] call CBA_fnc_addPerFrameHandler;

};