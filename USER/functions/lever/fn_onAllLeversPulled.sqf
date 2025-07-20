/*
* Code to execute when all levers are pulled simultaneously.
* Is executed in the unscheduled enviroment, server local.
*/

// systemChat "All Levers pulled!";


// broadcast
missionNameSpace setVariable ["grad_allLeversPulled", true, true];

private _point1 = getMarkerPos "mrk_spawner_1";
private _point2 = getMarkerPos "mrk_spawner_2";
private _point3 = getMarkerPos "mrk_spawner_3";
private _point4 = getMarkerPos "mrk_spawner_4";

// Calculate the sum of x, y, and z coordinates
private _totalX = (_point1 select 0) + (_point2 select 0) + (_point3 select 0) + (_point4 select 0);
private _totalY = (_point1 select 1) + (_point2 select 1) + (_point3 select 1) + (_point4 select 1);
private _totalZ = (_point1 select 2) + (_point2 select 2) + (_point3 select 2) + (_point4 select 2);

// Divide by 4 to get the average
private _averageX = _totalX / 4;
private _averageY = _totalY / 4;
private _averageZ = _totalZ / 4;

// Return the averaged 3D position
playSound3D [getMissionPath "user\sounds\implosion.ogg", [_averageX, _averageY, _averageZ], false, [_averageX, _averageY, _averageZ], 5, 1, 2500];


60 setFog 0.3;