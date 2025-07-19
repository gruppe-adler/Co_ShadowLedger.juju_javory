

if (isServer) then
{

	private _seawatch = (playableUnits + switchableUnits) select { groupId group _x == "SEAWATCH" || groupId group _x == "SEAWATCH" };
	private _lifeline = (playableUnits + switchableUnits) select { groupId group _x == "LIFELINE" };

	private _kraken = (playableUnits + switchableUnits) select { groupId group _x == "KRAKEN" };

	private _channelName = "SEAWATCH COMMAND";
	private _channelSeawatchID = radioChannelCreate [[0.56, 0.06, 0.4, 1], _channelName, "%UNIT_NAME", []];
	if (_channelSeawatchID == 0) exitWith {
		diag_log format ["Custom channel '%1' creation failed!", _channelName]
	};
	[_channelSeawatchID, {
		_this radioChannelAdd _seawatch
	}] remoteExec ["call", [0, -2] select isDedicated, _channelName];

	private _channelName = "KRAKEN COMMAND";
	private _channelKrakenID = radioChannelCreate [[0.56, 0.06, 0.4, 1], _channelName, "%UNIT_NAME", []];
	if (_channelKrakenID == 0) exitWith {
		diag_log format ["Custom channel '%1' creation failed!", _channelName]
	};
	[_channelKrakenID, {
		_this radioChannelAdd _kraken
	}] remoteExec ["call", [0, -2] select isDedicated, _channelName];

	missionNameSpace setVariable ["GRAD_CHANNEL_SEAWATCH", _channelSeawatchID, true];
	missionNameSpace setVariable ["GRAD_CHANNEL_KRAKEN", _channelKrakenID, true];
};
