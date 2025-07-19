/*
*   Wird zum Missionsstart auf Server und Clients ausgeführt.
*   Funktioniert wie die init.sqf.
*/


// add custom BFT, disable ace BFT
[] execVM "user\scripts\customBFT.sqf";
[] execVM "user\scripts\markerManagerServer.sqf";