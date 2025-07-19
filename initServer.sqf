["Initialize"] call BIS_fnc_dynamicGroups;


// Kraken Captive Handler
[
    {
		params ["_args", "_handle"];

		private _krakenUnits = allPlayers select { _x getvariable ["grad_iskraken", false] };
		if (missionNamespace getVariable ["GRAD_disableKrakenCaptive", false]) exitWith {
			{
				[_x, false] remoteExec ["setCaptive", _x];
			} forEach _krakenUnits;
			[_handle] call CBA_fnc_removePerFrameHandler;
		};		
		{
			private _isAwake = [_x] call ace_common_fnc_isAwake;
			private _isInArea = _x inArea trg_kraken_hq;
			if (_isInArea) then {
				// systemChat "setting Captive";
				[_x, true] remoteExec ["setCaptive", _x];
			} else {
				if (_isAwake) then {
					// systemChat "setting not Captive";
					[_x, false] remoteExec ["setCaptive", _x];
				};
			};
		} forEach _krakenUnits;
	},
    5,
    []
] call CBA_fnc_addPerFrameHandler;
