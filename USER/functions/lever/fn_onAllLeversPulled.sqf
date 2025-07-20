/*
* Code to execute when all levers are pulled simultaneously.
* Is executed in the unscheduled enviroment, server local.
*/

systemChat "All Levers pulled!";


// broadcast
missionNameSpace setVariable ["grad_allLeversPulled", true, true];