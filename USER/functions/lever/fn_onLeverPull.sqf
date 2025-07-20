/*
* Code to execute when a lever gets pulled.
* Is executed in the unscheduled enviroment, client local.
*/

params ["_lever"];

systemChat format["Pulled Lever %1!", _lever];
