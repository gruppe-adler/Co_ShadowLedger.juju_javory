params ["_unit"];


private ["_currentLoadout", "_currentLoadoutType", "_diveLoadout", "_normalLoadout"];

// private _normalLoadout = [];
// private _diveLoadout = [];
// private _currentLoadout = [];

/*
private _currentLoadoutType = "NORMAL";

switch (typeOf _unit) do {
	// SEAWATCH SQL
	case "B_T_Diver_TL_F": {
		_diveLoadout = [["arifle_SDAR_F","","","",["20Rnd_556x45_UW_mag",20],[],""],[],[],["U_B_Wetsuit",[["ACE_tourniquet",4],["ACE_packingBandage",10],["ACE_elasticBandage",10],["ACE_salineIV_500",1],["ACE_morphine",2],["ACE_quikclot",10],["20Rnd_556x45_UW_mag",8,20]]],["V_RebreatherB",[]],[],"","G_B_Diving",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]];
		_normalLoadout = [["rhs_weap_m16a4_imod_M203","","","rhsusf_acc_eotech_552",["30Rnd_556x45_Stanag",30],["1Rnd_HE_Grenade_shell",1],""],[],[],["rhs_uniform_acu_ucp",[["ACE_packingBandage",15],["ACE_elasticBandage",15],["ACE_quikclot",10],["ACE_morphine",2],["ACE_salineIV_500",1],["ACE_tourniquet",4]]],["rhsusf_iotv_ucp_Teamleader",[["30Rnd_556x45_Stanag_Tracer_Yellow",15,30],["rhs_mag_an_m8hc",2,1],["rhs_mag_m67",1,1]]],["TFAR_mr3000_bwmod_tropen",[["rhs_mag_M441_HE",10,1],["rhs_mag_m714_White",10,1]]],"rhsusf_ach_helmet_ucp","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]];
		_currentLoadout = _normalLoadout;
	};
	// SEAWATCH Rescue Diver
	case "B_T_Diver_F": {
		_diveLoadout = [["arifle_SDAR_F","","","",["20Rnd_556x45_UW_mag",20],[],""],[],[],["U_B_Wetsuit",[["ACE_tourniquet",4],["ACE_packingBandage",10],["ACE_elasticBandage",10],["ACE_salineIV_500",1],["ACE_morphine",2],["ACE_quikclot",10],["20Rnd_556x45_UW_mag",8,20]]],["V_RebreatherB",[]],[],"","G_B_Diving",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]];
		_normalLoadout = [["rhs_weap_m16a4","","","rhsusf_acc_eotech_552",["30Rnd_556x45_Stanag",30],[],""],[],[],["rhs_uniform_acu_ucp",[["ACE_packingBandage",15],["ACE_elasticBandage",15],["ACE_quikclot",10],["ACE_morphine",2],["ACE_salineIV_500",1],["ACE_tourniquet",4]]],["rhsusf_iotv_ucp_Teamleader",[["rhs_mag_an_m8hc",2,1],["rhs_mag_m67",1,1],["30Rnd_556x45_Stanag_Tracer_Yellow",15,30]]],[],"rhsusf_ach_helmet_ucp","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]];
		_currentLoadout = _normalLoadout;
	};
	// SEAWATCH EOD
	case "B_soldier_exp_F": {
		_diveLoadout = [["arifle_SDAR_F","","","",["20Rnd_556x45_UW_mag",20],[],""],[],[],["U_B_Wetsuit",[["ACE_tourniquet",4],["ACE_packingBandage",10],["ACE_elasticBandage",10],["ACE_salineIV_500",1],["ACE_morphine",2],["ACE_DefusalKit",1],["20Rnd_556x45_UW_mag",8,20]]],["V_RebreatherB",[]],[],"","G_B_Diving",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]];
		_normalLoadout = [["rhs_weap_m16a4_imod","","","rhsusf_acc_eotech_552",["30Rnd_556x45_Stanag",30],[],""],[],[],["rhs_uniform_acu_ucp",[["ACE_packingBandage",15],["ACE_elasticBandage",15],["ACE_quikclot",10],["ACE_morphine",2],["ACE_tourniquet",4],["ACE_salineIV_500",1]]],["rhsusf_iotv_ucp_Repair",[["rhs_mag_an_m8hc",2,1],["rhs_mag_m67",1,1],["30Rnd_556x45_Stanag_Tracer_Yellow",11,30]]],["rhsusf_assault_eagleaiii_ucp",[["ACE_DefusalKit",1],["ACE_M26_Clacker",1],["DemoCharge_Remote_Mag",5,1]]],"rhsusf_ach_helmet_ucp","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]];
		_currentLoadout = _normalLoadout;
	};
	// SEAWATCH Medic
	case "B_T_Recon_Medic_F": {
		_diveLoadout = [["arifle_SDAR_F","","","",["20Rnd_556x45_UW_mag",20],[],""],[],[],["U_B_Wetsuit",[["ACE_tourniquet",4],["ACE_packingBandage",10],["ACE_elasticBandage",10],["ACE_salineIV_500",1],["ACE_morphine",2],["ACE_quikclot",10],["20Rnd_556x45_UW_mag",8,20]]],["V_RebreatherB",[]],[],"","G_B_Diving",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]];
		_normalLoadout = [["rhs_weap_m16a4_imod","","","rhsusf_acc_eotech_552",["30Rnd_556x45_Stanag",30],[],""],[],[],["rhs_uniform_acu_ucp",[["ACE_packingBandage",15],["ACE_elasticBandage",15],["ACE_quikclot",10],["ACE_morphine",2],["ACE_tourniquet",4],["ACE_salineIV_500",1]]],["rhsusf_iotv_ucp_Medic",[["rhs_mag_an_m8hc",2,1],["rhs_mag_m67",1,1],["30Rnd_556x45_Stanag_Tracer_Yellow",11,30]]],["rhsusf_assault_eagleaiii_ucp",[["ACE_salineIV",8],["ACE_salineIV_500",10],["ACE_splint",8],["ACE_surgicalKit",1],["ACE_tourniquet",4],["ACE_morphine",10],["ACE_epinephrine",10],["ACE_packingBandage",40],["ACE_elasticBandage",40]]],"rhsusf_ach_helmet_ucp","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]];
		_currentLoadout = _normalLoadout;
	};
	// KRAKEN SQL
	case "B_recon_TL_F": {		
		_diveLoadout = [["arifle_SDAR_F","","","",["20Rnd_556x45_UW_mag",20],[],""],[],[],["U_I_Wetsuit",[["ACE_tourniquet",4],["ACE_packingBandage",10],["ACE_elasticBandage",10],["ACE_salineIV_500",1],["ACE_morphine",2],["ACE_quikclot",10],["20Rnd_556x45_UW_mag",8,20]]],["V_RebreatherIA",[]],[],"","G_I_Diving",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]];
		_normalLoadout = [["rhs_weap_hk416d145_m320","rhsusf_acc_nt4_black","","rhsusf_acc_eotech_xps3",["30Rnd_556x45_Stanag_Tracer_Green",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_Pistol_heavy_01_F","muzzle_snds_acp","","optic_MRD",["11Rnd_45ACP_Mag",15],[],""],["rhs_uniform_g3_blk",[["ACE_elasticBandage",20],["ACE_packingBandage",20],["ACE_tourniquet",4],["ACE_morphine",2],["ACE_salineIV_500",1],["ACE_MapTools",1]]],["V_PlateCarrier2_blk",[["rhs_mag_an_m8hc",2,1],["rhs_mag_m67",2,1],["11Rnd_45ACP_Mag",2,15],["30Rnd_556x45_Stanag_green",11,30]]],["TFAR_rt1523g_black",[["rhs_mag_M441_HE",8,1],["rhs_mag_m714_White",8,1]]],"rhsusf_opscore_bk_pelt","G_I_Diving",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]];
		_currentLoadout = _normalLoadout;
	};
	// KRAKEN Sepcial Forces Diver
	case "B_diver_F": {		
		_diveLoadout = [["arifle_SDAR_F","","","",["20Rnd_556x45_UW_mag",20],[],""],[],[],["U_I_Wetsuit",[["ACE_tourniquet",4],["ACE_packingBandage",10],["ACE_elasticBandage",10],["ACE_salineIV_500",1],["ACE_morphine",2],["ACE_quikclot",10],["20Rnd_556x45_UW_mag",8,20]]],["V_RebreatherIA",[]],["B_Messenger_Black_F",[["ACE_DefusalKit",1],["ACE_M26_Clacker",1],["SatchelCharge_Remote_Mag",1,1]]],"","G_I_Diving",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]];
		_normalLoadout = [["rhs_weap_hk416d145","rhsusf_acc_nt4_black","","rhsusf_acc_eotech_xps3",["30Rnd_556x45_Stanag_Tracer_Green",30],[],""],[],["hgun_Pistol_heavy_01_F","muzzle_snds_acp","","optic_MRD",["11Rnd_45ACP_Mag",15],[],""],["rhs_uniform_g3_blk",[["ACE_elasticBandage",20],["ACE_packingBandage",20],["ACE_tourniquet",4],["ACE_morphine",2],["ACE_salineIV_500",1],["ACE_MapTools",1]]],["V_PlateCarrier2_blk",[["30Rnd_556x45_Stanag_green",11,30],["rhs_mag_an_m8hc",2,1],["rhs_mag_m67",2,1],["11Rnd_45ACP_Mag",2,15]]],[],"rhsusf_opscore_bk_pelt","G_I_Diving",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]];
		_currentLoadout = _normalLoadout;
	};
	// KRAKEN Medic
	case "B_recon_medic_F": {		
		_diveLoadout = [["arifle_SDAR_F","","","",["20Rnd_556x45_UW_mag",20],[],""],[],[],["U_I_Wetsuit",[["ACE_tourniquet",4],["ACE_packingBandage",10],["ACE_elasticBandage",10],["ACE_salineIV_500",1],["ACE_morphine",2],["ACE_quikclot",10],["20Rnd_556x45_UW_mag",8,20]]],["V_RebreatherIA",[]],[],"","G_I_Diving",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]];
		_normalLoadout = [["rhs_weap_hk416d145","rhsusf_acc_nt4_black","","rhsusf_acc_eotech_xps3",["30Rnd_556x45_Stanag_Tracer_Green",30],[],""],[],["hgun_Pistol_heavy_01_F","muzzle_snds_acp","","optic_MRD",["11Rnd_45ACP_Mag",15],[],""],["rhs_uniform_g3_blk",[["ACE_elasticBandage",20],["ACE_packingBandage",20],["ACE_tourniquet",4],["ACE_morphine",2],["ACE_salineIV_500",1],["ACE_MapTools",1]]],["V_PlateCarrier2_blk",[["30Rnd_556x45_Stanag_green",11,30],["rhs_mag_an_m8hc",2,1],["rhs_mag_m67",2,1],["11Rnd_45ACP_Mag",2,15]]],["B_ViperHarness_blk_F",[["ACE_surgicalKit",1],["ACE_salineIV",8],["ACE_salineIV_500",10],["ACE_morphine",10],["ACE_epinephrine",10],["ACE_splint",8],["ACE_tourniquet",4],["ACE_packingBandage",50],["ACE_elasticBandage",50]]],"rhsusf_opscore_bk_pelt","G_I_Diving",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]];
		_currentLoadout = _normalLoadout;
	};
	// KRAKEN Radiation Expert and Gunners
	case "B_recon_F": {		
		_diveLoadout = [["arifle_SDAR_F","","","",["20Rnd_556x45_UW_mag",20],[],""],[],[],["U_I_Wetsuit",[["ACE_tourniquet",4],["ACE_packingBandage",10],["ACE_elasticBandage",10],["ACE_salineIV_500",1],["ACE_morphine",2],["ACE_quikclot",10],["20Rnd_556x45_UW_mag",8,20]]],["V_RebreatherIA",[]],[],"","G_I_Diving",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]];
		_normalLoadout = [["rhs_weap_hk416d145","rhsusf_acc_nt4_black","","rhsusf_acc_eotech_xps3",["30Rnd_556x45_Stanag_Tracer_Green",30],[],""],[],["hgun_Pistol_heavy_01_F","muzzle_snds_acp","","optic_MRD",["11Rnd_45ACP_Mag",15],[],""],["rhs_uniform_g3_blk",[["ACE_elasticBandage",20],["ACE_packingBandage",20],["ACE_tourniquet",4],["ACE_morphine",2],["ACE_salineIV_500",1],["ACE_MapTools",1]]],["V_PlateCarrier2_blk",[["30Rnd_556x45_Stanag_green",11,30],["rhs_mag_an_m8hc",2,1],["rhs_mag_m67",2,1],["11Rnd_45ACP_Mag",2,15]]],[],"rhsusf_opscore_bk_pelt","G_I_Diving",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]];
		_currentLoadout = _normalLoadout;
	};
};

_unit setVariable ["GRAD_BP_normal_Loadout", _normalLoadout, true];
_unit setVariable ["GRAD_BP_dive_Loadout", _diveLoadout, true];
_unit setVariable ["GRAD_BP_current_Loadout_Type", _currentLoadoutType, true];
_unit setUnitLoadout _currentLoadout;

if (!isPlayer _unit) exitWith {};

// [] spawn {
// 	sleep 20;
// 	[] call BP_LOADOUT_fnc_addLoadoutAction;
// };

*/