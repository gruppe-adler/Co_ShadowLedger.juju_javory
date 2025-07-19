params ["_laptop"];

private _message = "
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#

CLASSIFIED DOCUMENTS â€“ LEVEL RED\#
TOP SECRET â€“ FOR AUTHORIZED EYES ONLY\#
Recovered from Capsule [Code: Omega-17]\#
---\#
Transmission Logs â€“ KRAKEN HQ and Unidentified Foreign Power\#
Date: [REDACTED]\#
From: KRAKEN Command, Director [REDACTED]\#
To: [Foreign Contact: Codename 'Spectre']\#
Subject: Trade Agreement â€“ Phase Two\#
---\#
'Spectre, we have delivered the requested intel on BLUFOR's naval movements. In exchange, we expect the next shipment of weapon systems to be ready by the next quarter. Ensure this transaction remains undiscovered. BLUFOR is beginning to suspect increased activity in the sector, but KRAKEN's role is still secure.'\#
---\#
Date: [REDACTED]\#
From: Spectre\#
To: KRAKEN Command\#
'Understood. Our latest technology will be delivered via the designated channels. As for your payment, the offshore accounts have been updated. Ensure your forces maintain distance during our next operation in BLUFOR waters. Any interference will result inâ€¦complications.'\#
---\#
Encrypted Audio File #0047 â€“ Recorded at KRAKEN HQ\#
Voice 1 (Director [REDACTED]): 'BLUFOR is getting too close to discovering our arrangement. We need to keep SEAWATCH and the others occupied with false threats. Divert their attention, leak false intel if you have to. Just make sure they don't figure out that we're the ones handing over BLUFOR's positions.'\#
Voice 2: 'And what about the space capsule? SEAWATCH might find out about the connection to Spectre.'\#
Voice 1: 'It doesn't matter. Once the sub is destroyed and the capsule's intel wiped, there will be no trace. If SEAWATCH gets too close, we'll deal with them just like we dealt with the others.'\#
---\#
Financial Transaction Report\#
Date: [REDACTED]\#
Transaction Type: Offshore Wire Transfer\#
From: KRAKEN HQ, Account [REDACTED]\#
To: [Foreign Power], Account [REDACTED]\#
Amount: $12,500,000 USD\#
---\#
Mission Brief â€“ KRAKEN HQ Internal\#
Date: [REDACTED]\#
'Operation â€˜Shroudâ€™ initiated. BLUFOR assets will be compromised during upcoming deployments. Our foreign partners will make their move once SEAWATCH is diverted. Ensure all evidence points away from KRAKEN's involvement. The longer we keep BLUFOR distracted, the more we can gain from this arrangement. Eliminate any potential leaks internally.'\#
---\#
END OF DOCUMENT\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#
\#

";
forceUnicode -1;
// Split the original message into lines based on the [LINEBREAK] delimiter
private _rawLinesArray = _message splitString "\#"; 
private _linesArray = []; // New array for processed lines

// Process each raw line to handle long lines
{
	private _line = _x;
	// Split lines longer than 80 characters into smaller segments
	while {count _line > 80} do {
		_linesArray pushBack (_line select [0, 80]); // Push the first 80 characters
		_line = _line select [80, count _line - 80]; // Remainder of the line
	};
	// Push any remaining characters to the array
	if (count _line > 0) then {
		_linesArray pushBack (_line + "\n");
	};
} forEach _rawLinesArray; // Process each raw line

copyToClipboard format ["%1", _rawlinesArray];
_linesArray joinString "\n";


[_laptop, _linesArray] spawn {
	params ["_laptop", "_linesArray"];

	// Local variables
	private _currentLineIndex = 0; // Current index for the line to be displayed
	private _lineCount = 0; // Counter for the number of lines displayed
	private _totalLines = count _linesArray; // Total number of lines
	private _displayLineCount = 20;
	private _loadingBarLength = 40; // Length of the loading bar in characters
	private _uploadedLength = 0; // Current uploaded length
	private _messageDisplay = ""; // Initialize display message		
	private _progressBar = "";
			
	// Loop to display lines
	while {_currentLineIndex < _totalLines} do {

		// Prepare to display 10 lines
		_messageDisplay = "";
		_progressBar = "";

		
		  // Set the range for displaying lines
		private _startLine = _currentLineIndex; // Start from current index
		private _endLine = (_startLine + _displayLineCount) min _totalLines; // End line for display
		
		for "_i" from _startLine to (_endLine - 1) do {
			if (_i < _totalLines) then { // Check bounds
				_messageDisplay = _messageDisplay + (_linesArray select _i) + "\n"; // Append each line with a newline
			};
		};
	
				 
			  /*  hint (
		("totallines: " + str _totallines) + "\n" +
		("_startLine: " + str _startLine) + "\n" +
		("_endLine: " + str _endLine) + "\n");*/
		 // Update the loading bar length
		// Update the loading bar length
		_uploadedLength = (_currentLineIndex / _totalLines) * _loadingBarLength; // Calculate the uploaded length

		// Create the loading bar using a loop
		
		for "_j" from 0 to (_loadingBarLength - 1) do {
			if (_j < _uploadedLength) then {
				_progressBar = _progressBar + "#"; // Fill with hash for uploaded portion
			} else {
				_progressBar = _progressBar + "."; // Fill with dashes for remaining portion
			};
		};

		// Combine the message with the loading bar
		_messageDisplay = "\nLoading: [" + _progressBar + "] \n" + format ["%1%%", round (_currentLineIndex / _totalLines * 100)] + _messageDisplay; // Append loading bar
		
		// Show the current line on the laptop
		_laptop setObjectTexture ["Screen_1", "#(rgb,512,512,3)text(0,0,""LucidaConsoleB"",0.035,""#000000"",""#33ff33""," + _messageDisplay + ")"];
		
		// Increment the line index and count for the next iteration
		_currentLineIndex = _currentLineIndex + 1; // Move to the next line
		_lineCount = _lineCount + 1; // Update the displayed line count

		// Check if we've reached the end of the lines
		if (_currentLineIndex + 10 >= _totalLines) exitWith {
		
		sleep 1;
				_messageDisplay = "\n UPLOAD COMPLETE: [" + _progressBar + "] \n" + format ["%1%%", 100]; // Append loading bar
				 _laptop setObjectTexture ["Screen_1", "#(rgb,512,512,3)text(0,0,""LucidaConsoleB"",0.035,""#000000"",""#33ff33""," + _messageDisplay + ")"];

		sleep 10;
		_laptop setObjectTexture ["Screen_1", "#(rgb,512,512,3)text(0,0,""LucidaConsoleB"",0.035,""#000000"",""#33ff33""," + "" + ")"];

		}; // Exit if no more lines to display
		
		// Slow down the loop to simulate typing (0.1 second delay)
		sleep 0.1; 
		
		
 
	 };
	
};