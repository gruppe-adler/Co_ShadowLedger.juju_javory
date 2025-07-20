class BP_lever_militarybase {
	tag = "BP_lever_militarybase";
    class lever {
		file = "USER\functions\lever_militarybase";
        class addLeverAction {};
        class onLeverPull {};
        class onAllLeversPulled {};
        class triggerLevers {
            postInit = 1;
        };
    };
};