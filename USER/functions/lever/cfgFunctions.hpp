class BP_lever {
	tag = "BP_lever";
    class lever {
		file = "USER\functions\lever";
        class addLeverAction {};
        class onLeverPull {};
        class onAllLeversPulled {};
        class triggerLevers {
            postInit = 1;
        };
    };
};