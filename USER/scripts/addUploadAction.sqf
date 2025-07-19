params ["_computer"];

[ 
 _computer, 
 "Upload Intel", 
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
 "_this distance _target < 3 && !(_target getVariable ['GRAD_intel_upload_done', false]) &&
 [_this, 'FlashDisk'] call bIs_fnc_hasitem", 
 "_caller  distance _target < 3", 
 { ["Starting upload...", 1, [1,1,1,1], true] call CBA_fnc_notify; }, 
 {  [] spawn {
			for "_i" from 1 to 2 do { 
				playSound3D [getMissionPath "USER\sounds\" + selectRandom ["keypad_1", "keypad_2", "keypad_3"] + ".ogg", player, false, getPosASL player, 5] remoteExec ["say3D", 20];
				sleep (0.05 + random 0.05);
		 	};
		};
		true
 }, 
 {
	params ["_target"];
	_target setVariable ['GRAD_intel_upload_done', true, true];
	["Intel upload finished.", 1, [1,1,1,1], true] call CBA_fnc_notify;

	[_target, "USER\scripts\uploadIntel.sqf"] remoteExec ["BIS_fnc_execVM"];

	["GRAD_intel_upload_completed", []] call CBA_fnc_globalEvent;

	laboratory_big_screen setObjectTextureGlobal [0, "data\krakensatnet.paa"];
},
 { ["Aborted upload", 1, [1,1,1,1], true] call CBA_fnc_notify; }, 
 [], 10, nil, false, false 
] call BIS_fnc_holdActionAdd;

[ 
 _computer, 
 "Inspecting Laptop", 
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
 "_this distance _target < 3 && !(_target getVariable ['GRAD_intel_upload_done', false]) &&
 !([_this, 'FlashDisk'] call bIs_fnc_hasitem)", 
 "_caller  distance _target < 3", 
 { ["Taking a look..", 1, [1,1,1,1], true] call CBA_fnc_notify; }, 
 {  }, 
 {
	params ["_target"];
	["If I had something to stick into the data slot, I would do it.", 1, [1,1,1,1], true] call CBA_fnc_notify;
},
 { ["Aborted inspect", 1, [1,1,1,1], true] call CBA_fnc_notify; }, 
 [], 1, nil, false, false 
] call BIS_fnc_holdActionAdd;

// caching of the textures to prevent flickering later on
[_computer, "USER\scripts\uploadIntel.sqf"] remoteExec ["BIS_fnc_execVM"];