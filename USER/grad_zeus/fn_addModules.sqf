[] spawn {
  waitUntil {!isNull player};
  waitUntil {  time > 3 };

  {
    private _curator = _x;
    
      _curator addEventHandler ["CuratorGroupPlaced", {
          params ["", "_group"];

          ["GRAD_missionControl_setServerAsOwner", [_group]] call CBA_fnc_serverEvent;
      }];

      _curator addEventHandler ["CuratorObjectPlaced", {
          params ["", "_object"];

          if (_object isKindOf "CAManBase") then {
             if (count units _object == 1) then {
                 ["GRAD_missionControl_setServerAsOwner", [group _object]] call CBA_fnc_serverEvent;
             };
          } else {
             if (count crew _object > 1) then {
                 ["GRAD_missionControl_setServerAsOwner", [group (crew _object select 0)]] call CBA_fnc_serverEvent;
             };
         };

      }];

  } forEach allCurators;
};


//////////////
////////////// CALLS
//////////////

["STO LEVIV - CALLS", "Ad hoc intel call (Input)",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

  _position = ASLtoAGL _position;

  ["Example Dialog", [["EDIT", "Intel to send via call", "Your message for public briefing"]], {
			params ["_message", "_position"]; 
      
      private _nearestPhone = objNull;
      private _nearestPhoneIndex = 0;
      private _allNumbers = missionNamespace getVariable ['GRAD_TELEPHONE_ALLNUMBERS', []];
      {
          private _phoneObjects = _x select 1;
          private _numberIndex = _forEachIndex;

          {
              private _phoneObject = _x;
              private _positionPhoneObject = position _x;

              if (isNull _nearestPhone) then {
                  _nearestPhone = _phoneObject;
              };

              if (_positionPhoneObject distance2D _position < (position _nearestPhone) distance2D _position) then {
                  _nearestPhone = _phoneObject;
                  _nearestPhoneIndex = _numberIndex;
              };
          } forEach _phoneObjects;
      } forEach _allNumbers;

      if (count _allNumbers < 1) exitWith { systemChat "No phones on map"; };

      [_nearestPhone, "GRAD_garble_long", _message#0] remoteExec ["GRAD_telephone_fnc_fakeCallPhone", 2];   
  
  }, { systemchat "cancelled"; }, _position] call zen_dialog_fnc_create;  

}] call zen_custom_modules_fnc_register;




["SHADOW LEDGER - RADIO", "1 - Briefing",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

    // CRAWLER
    [
        ["Alright, listen up, you grunts! This ain't no damn holiday. Garmanda's crawling with infected, and the gov wants 'em gone. Every one you drop is 60 credits in our pocket. Reaper and Blades are out there too, but they ain't our enemies. Anyone popping a friendly is gonna owe the government a thousand. Don't be stupid.  Flags are one credit a second for control, so grab 'em, plant them near a POI and make sure we're the ones racking up the most cash. Get to your positions!", 
        "crawler_briefing", 
        51,
        "crawler"
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];


    // REAPER
    [
        ["Alright, listen up, you grunts! This ain't no damn holiday. Garmanda's crawling with infected, and the gov wants 'em gone. Every one you drop is 60 credits in our pocket. Crawler and Blades are out there too, but they ain't our enemies. Anyone popping a friendly is gonna owe the government a thousand. Don't be stupid.  Flags are one credit a second for control, so grab 'em, plant them near a POI and make sure we're the ones racking up the most cash. Get to your positions!", 
        "reaper_briefing", 
        42,
        "reaper"
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];


    // BLADES
    [
        ["Alright, listen up, you grunts! This ain't no damn holiday. Garmanda's crawling with infected, and the gov wants 'em gone. Every one you drop is 60 credits in our pocket. Reaper and Crawler are out there too, but they ain't our enemies. Anyone popping a friendly is gonna owe the government a thousand. Don't be stupid.  Flags are one credit a second for control, so grab 'em, plant them near a POI and make sure we're the ones racking up the most cash. Get to your positions!", 
        "blades_briefing", 
        36,
        "blades"
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];

}] call zen_custom_modules_fnc_register;




["SHADOW LEDGER - RADIO", "2 - Pull Levers",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];


    missionNameSpace setVariable ["grad_flagGameOver", true, true];

    // CRAWLER
    [
        ["Great. New orders. Turns out the infected are spawning from some kind of temporal tear. Just our luck. The solution is some emergency gas the scientists cooked up and never got to release. We've got to hit the levers at all five POIs at the same time to deploy it. No more flag money while we do this, so don't you dare drop the ball. If you don't coordinate, we're all dead.", 
        "crawler_levers", 
        32,
        "crawler"
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];


    // REAPER
    [
        ["Great. New orders. Turns out the infected are spawning from some kind of temporal tear. Just our luck. The solution is some emergency gas the scientists cooked up and never got to release. We've got to hit the levers at all five POIs at the same time to deploy it. No more flag money while we do this, so don't you dare drop the ball. If you don't coordinate, we're all dead.", 
        "reaper_levers", 
        28,
        "reaper"
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];


    // BLADES
    [
        ["Great. New orders. Turns out the infected are spawning from some kind of temporal tear. Just our luck. The solution is some emergency gas the scientists cooked up and never got to release. We've got to hit the levers at all five POIs at the same time to deploy it. No more flag money while we do this, so don't you dare drop the ball. If you don't coordinate, we're all dead.", 
        "blades_levers", 
        27,
        "blades"
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];

}] call zen_custom_modules_fnc_register;




["SHADOW LEDGER - RADIO", "3 - Temporal Tear Closed",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

    // CRAWLER
    [
        ["Alright, team, reports are in. The synchronous pull worked, that temporal anomaly is closed. No more endless infected pouring out of thin air. You bastards actually did it. Now, let's keep that momentum. Next objective coming soon, so stay sharp.", 
        "crawler_temporaltear", 
        24,
        "crawler"
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];


    // REAPER
    [
        ["Alright, team, reports are in. The synchronous pull worked, that temporal anomaly is closed. No more endless infected pouring out of thin air. You bastards actually did it. Now, let's keep that momentum. Next objective coming soon, so stay sharp.", 
        "reaper_temporaltear", 
        24,
        "reaper"
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];


    // BLADES
    [
        ["Alright, team, reports are in. The synchronous pull worked, that temporal anomaly is closed. No more endless infected pouring out of thin air. You bastards actually did it. Now, let's keep that momentum. Next objective coming soon, so stay sharp.", 
        "blades_temporaltear", 
        23,
        "blades"
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];

}] call zen_custom_modules_fnc_register;






["SHADOW LEDGER - RADIO", "4 - Military Base",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

    // CRAWLER
    [
        ["Alright, hold it! New orders just dropped from Command, and this ain't pretty. Forget everything else. Our final objective is the overrun military base in the northwest. This whole damn mess started there, and those eggheads weren't just brewing a virus. Rumor is, they uncorked something a hell of a lot worse. This isn't about credits anymore, people. This is about containing whatever nightmare they unleashed. Get in there and destroy whatever's gotta go!", 
        "crawler_militarybase", 
        33,
        "crawler"
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];


    // REAPER
    [
        ["Alright, hold it! New orders just dropped from Command, and this ain't pretty. Forget everything else. Our final objective is the overrun military base in the northwest. This whole damn mess started there, and those eggheads weren't just brewing a virus. Rumor is, they uncorked something a hell of a lot worse. This isn't about credits anymore, people. This is about containing whatever nightmare they unleashed. Get in there and destroy whatever's gotta go!", 
        "reaper_militarybase", 
        36,
        "reaper"
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];


    // BLADES
    [
        ["Alright, hold it! New orders just dropped from Command, and this ain't pretty. Forget everything else. Our final objective is the overrun military base in the northwest. This whole damn mess started there, and those eggheads weren't just brewing a virus. Rumor is, they uncorked something a hell of a lot worse. This isn't about credits anymore, people. This is about containing whatever nightmare they unleashed. Get in there and destroy whatever's gotta go!", 
        "blades_militarybase", 
        29,
        "blades"
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];

}] call zen_custom_modules_fnc_register;



["SHADOW LEDGER - RADIO", "5 - Mutants Payment after arrival",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

    // CRAWLER
    [
        ["Alright, new intel on the infected! Apparently, some of these things are not of human origin. But that means more money for us. Any of those fuckers you take down? That's 120 credits a kill. Don't care how ugly it is, just put it in the ground and claim your bounty. Let's go make some money boys!", 
        "crawler_mutants", 
        30,
        "crawler"
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];


    // REAPER
    [
        ["Alright, new intel on the infected! Apparently, some of these things are not of human origin. But that means more money for us. Any of those fuckers you take down? That's 120 credits a kill. Don't care how ugly it is, just put it in the ground and claim your bounty. Let's go make some money boys!", 
        "reaper_mutants", 
        22,
        "reaper"
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];


    // BLADES
    [
        ["Alright, new intel on the infected! Apparently, some of these things are not of human origin. But that means more money for us. Any of those fuckers you take down? That's 120 credits a kill. Don't care how ugly it is, just put it in the ground and claim your bounty. Let's go make some money boys!", 
        "blades_mutants", 
        21,
        "blades"
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];

}] call zen_custom_modules_fnc_register;



["SHADOW LEDGER - RADIO", "6 - Smasher Reveal",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

    // CRAWLER
    [
        ["What the hell. That's a Smasher! Looks like a damn freight train with teeth. This ain't just about survival, now it's about profit. One thousand credits for any Smasher! Don't let it get close, these bastards hit hard.", 
        "crawler_smasher", 
        19,
        "crawler"
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];


    // REAPER
    [
        ["What the hell. That's a Smasher! Looks like a damn freight train with teeth. This ain't just about survival, now it's about profit. One thousand credits for any Smasher! Don't let it get close, these bastards hit hard.", 
        "reaper_smasher", 
        17,
        "reaper"
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];


    // BLADES
    [
        ["What the hell. That's a Smasher! Looks like a damn freight train with teeth. This ain't just about survival, now it's about profit. One thousand credits for any Smasher! Don't let it get close, these bastards hit hard.", 
        "blades_smasher", 
        16,
        "blades"
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];

}] call zen_custom_modules_fnc_register;




["SHADOW LEDGER - RADIO", "7 - Goliath Reveal",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

    // CRAWLER
    [
        ["What the absolute hell was that?! I just received note: that's a Goliath! This ain't some big infected, people, this thing's a goddamn tank, looks like it's made of rebar and rage. But every monster has a price. Two thousand credits for that Goliath! You wanna be a legend? There's your chance.", 
        "crawler_goliath", 
        27,
        "crawler"
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];


    // REAPER
    [
        ["What the absolute hell was that?! I just received note: that's a Goliath! This ain't some big infected, people, this thing's a goddamn tank, looks like it's made of rebar and rage. But every monster has a price. Two thousand credits for that Goliath! You wanna be a legend? There's your chance.", 
        "reaper_goliath", 
        29,
        "reaper"
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];


    // BLADES
    [
        ["What the absolute hell was that?! I just received note: that's a Goliath! This ain't some big infected, people, this thing's a goddamn tank, looks like it's made of rebar and rage. But every monster has a price. Two thousand credits for that Goliath! You wanna be a legend? There's your chance.", 
        "blades_goliath", 
        28,
        "blades"
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];

}] call zen_custom_modules_fnc_register;




["SHADOW LEDGER - RADIO", "8 - Return to Garmanda",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

    // CRAWLER
    [
        ["Solid work out there, team. That base was a damn meat grinder, but you handled those... things. Impressive. Now that the immediate threat is contained, get your asses back to Garmanda city center. We'll sort out the details there. And try not to track too much of that... stuff... into my briefing area.", 
        "crawler_returntogarmanda", 
        20,
        "crawler"
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];


    // REAPER
    [
        ["Solid work out there, team. That base was a damn meat grinder, but you handled those... things. Impressive. Now that the immediate threat is contained, get your asses back to Garmanda city center. We'll sort out the details there. And try not to track too much of that... stuff... into my briefing area.", 
        "reaper_returntogarmanda", 
        27,
        "reaper"
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];


    // BLADES
    [
        ["Solid work out there, team. That base was a damn meat grinder, but you handled those... things. Impressive. Now that the immediate threat is contained, get your asses back to Garmanda city center. We'll sort out the details there. And try not to track too much of that... stuff... into my briefing area.", 
        "blades_returntogarmanda", 
        28,
        "blades"
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];

}] call zen_custom_modules_fnc_register;




["SHADOW LEDGER - SPAWNS", "Move Spawn Garmanda",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

    private _spawnMarker = [
        "mrk_spawner_1",
        "mrk_spawner_2",
        "mrk_spawner_3",
        "mrk_spawner_4"
    ];

    private _selectedMarker = selectRandom _spawnMarker;

    _selectedMarker setMarkerPos ASLtoAGL _position;

    private _spawnPositions = [
        getMarkerPos "mrk_spawner_1",
        getMarkerPos "mrk_spawner_2",
        getMarkerPos "mrk_spawner_3",
        getMarkerPos "mrk_spawner_4"
    ];

    missionNameSpace setVariable ["grad_spawner_positions", _spawnPositions, true]; 
    

}] call zen_custom_modules_fnc_register;





["SHADOW LEDGER - SPAWNS", "Spawn Bloater",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

    private _position = ASLtoAGL _position;

    private _unit = (createGroup east) createUnit ["Zombie_Special_OPFOR_Boomer", _position, [], 0, "CAN_COLLIDE"];
    [_position] remoteExec ["grad_spawnFX_fnc_SpawnFX_local"];
    _unit setDir random 360;

}] call zen_custom_modules_fnc_register;


["SHADOW LEDGER - SPAWNS", "Spawn Corrupted",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

    private _position = ASLtoAGL _position;

    private _unit = (createGroup east) createUnit ["WBK_SpecialZombie_Corrupted_3", _position, [], 0, "CAN_COLLIDE"];
    [_position] remoteExec ["grad_spawnFX_fnc_SpawnFX_local"];
    _unit setDir random 360;

}] call zen_custom_modules_fnc_register;



["SHADOW LEDGER - SPAWNS", "Spawn Goliaph",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

    private _position = ASLtoAGL _position;

    private _unit = (createGroup east) createUnit ["WBK_Goliaph_3", _position, [], 0, "CAN_COLLIDE"];
    [_position] remoteExec ["grad_spawnFX_fnc_SpawnFX_local"];
    _unit setDir random 360;

}] call zen_custom_modules_fnc_register;




["SHADOW LEDGER - SPAWNS", "Spawn Leaper 1",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

    private _position = ASLtoAGL _position;

    private _unit = (createGroup east) createUnit ["Zombie_Special_OPFOR_Leaper_1", _position, [], 0, "CAN_COLLIDE"];
    [_position] remoteExec ["grad_spawnFX_fnc_SpawnFX_local"];
    _unit setDir random 360;

}] call zen_custom_modules_fnc_register;


["SHADOW LEDGER - SPAWNS", "Spawn Leaper 2",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

    private _position = ASLtoAGL _position;

    private _unit = (createGroup east) createUnit ["Zombie_Special_OPFOR_Leaper_2", _position, [], 0, "CAN_COLLIDE"];
    [_position] remoteExec ["grad_spawnFX_fnc_SpawnFX_local"];
    _unit setDir random 360;

}] call zen_custom_modules_fnc_register;

["SHADOW LEDGER - SPAWNS", "Spawn Screamer",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

    private _position = ASLtoAGL _position;

    private _unit = (createGroup east) createUnit ["Zombie_Special_OPFOR_Screamer", _position, [], 0, "CAN_COLLIDE"];
    [_position] remoteExec ["grad_spawnFX_fnc_SpawnFX_local"];
    _unit setDir random 360;

}] call zen_custom_modules_fnc_register;

["SHADOW LEDGER - SPAWNS", "Spawn Smasher",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

    private _position = ASLtoAGL _position;

    private _unit = (createGroup east) createUnit ["WBK_SpecialZombie_Smasher_3", _position, [], 0, "CAN_COLLIDE"];
    [_position] remoteExec ["grad_spawnFX_fnc_SpawnFX_local"];
    _unit setDir random 360;

}] call zen_custom_modules_fnc_register;




["SHADOW LEDGER - SPAWNS", "Spawn Garmanda Infected",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

    private _position = ASLtoAGL _position;

    private _infectedClassnames = [
        "Zombie_O_Crawler_Civ",
        "Zombie_O_RC_Civ",
        "Zombie_O_Shambler_Civ",
        "Zombie_O_RA_Civ",
        "Zombie_O_Walker_Civ"
    ];

    private _unit = (createGroup east) createUnit [selectRandom _infectedClassnames, _position, [], 0, "CAN_COLLIDE"];
    [_position] remoteExec ["grad_spawnFX_fnc_SpawnFX_local"];
    _unit setDir random 360;

}] call zen_custom_modules_fnc_register;




["SHADOW LEDGER - PERFORMANCE", "Pause Spawn Loop",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

    missionNamespace setVariable ["grad_pause_spawn_loop", true, true];
    "Spawn Loop paused" call CBA_fnc_notify;

}] call zen_custom_modules_fnc_register;


["SHADOW LEDGER - PERFORMANCE", "Resume Spawn Loop",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

    missionNamespace setVariable ["grad_pause_spawn_loop", false, true];
    "Spawn Loop resumed" call CBA_fnc_notify;

}] call zen_custom_modules_fnc_register;



["SHADOW LEDGER - INFO", "Show & Log Victorypoints",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

    private _victoryPoints = format ["victorypoints: reaper %1, crawler %2, blades %3", 
            grad_victorypoints_reaper, 
            grad_victorypoints_crawler, 
            grad_victorypoints_blades];

    private _killcount = format ["killcount: reaper %1, crawler %2, blades %3", 
            grad_killcount_reaper, 
            grad_killcount_crawler, 
            grad_killcount_blades];
            
    private _blueonblue = format ["blue on blue count: reaper %1, crawler %2, blades %3", 
            grad_blueonblue_reaper, 
            grad_blueonblue_crawler, 
            grad_blueonblue_blades];

    systemChat _victoryPoints;
    systemChat _killcount;
    systemChat _blueonblue;

    diag_log _victoryPoints;
    diag_log _killcount;
    diag_log _blueonblue;

}] call zen_custom_modules_fnc_register;





["SHADOW LEDGER - PERFORMANCE", "Pause Spawn Loop MilitaryBase",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

    missionNamespace setVariable ["grad_pause_spawn_loop_militarybase", true, true];
    "Spawn Loop Militarybase paused" call CBA_fnc_notify;

}] call zen_custom_modules_fnc_register;


["SHADOW LEDGER - PERFORMANCE", "Resume Spawn Loop MilitaryBase",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

    missionNamespace setVariable ["grad_pause_spawn_loop_militarybase", false, true];
    "Spawn Loop Militarybase resumed" call CBA_fnc_notify;

}] call zen_custom_modules_fnc_register;
