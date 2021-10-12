/* Generated by BOLTS, do not modify */
function nominalpipesize_table_0(idx) =
//od
idx == "NPS 0.125" ? [0.405] :
idx == "NPS 0.25" ? [0.54] :
idx == "NPS 0.375" ? [0.675] :
idx == "NPS 0.5" ? [0.84] :
idx == "NPS 0.75" ? [1.05] :
idx == "NPS 1" ? [1.315] :
idx == "NPS 1.25" ? [1.66] :
idx == "NPS 1.5" ? [1.9] :
idx == "NPS 2" ? [2.375] :
idx == "NPS 2.5" ? [2.875] :
idx == "NPS 3" ? [3.5] :
idx == "NPS 3.5" ? [4.0] :
idx == "NPS 4" ? [4.5] :
idx == "NPS 4.5" ? [5.0] :
idx == "NPS 5" ? [5.563] :
idx == "NPS 6" ? [6.625] :
idx == "NPS 7" ? [7.625] :
idx == "NPS 8" ? [8.625] :
idx == "NPS 9" ? [9.625] :
idx == "NPS 10" ? [10.75] :
idx == "NPS 11" ? [11.75] :
idx == "NPS 12" ? [12.75] :
idx == "NPS 14" ? [14.0] :
idx == "NPS 16" ? [16.0] :
idx == "NPS 18" ? [18.0] :
idx == "NPS 20" ? [20.0] :
idx == "NPS 24" ? [24.0] :
idx == "NPS 26" ? [26.0] :
idx == "NPS 28" ? [28.0] :
idx == "NPS 30" ? [30.0] :
idx == "NPS 32" ? [32.0] :
idx == "NPS 34" ? [34.0] :
idx == "NPS 36" ? [36.0] :
idx == "NPS 42" ? [42.0] :
idx == "NPS 48" ? [48.0] :
"Error";

function nominalpipesize_table2d_0(rowidx,colidx) =
colidx == "5s" ? nominalpipesize_table2d_rows_0(rowidx)[0] :
colidx == "5" ? nominalpipesize_table2d_rows_0(rowidx)[1] :
colidx == "10s" ? nominalpipesize_table2d_rows_0(rowidx)[2] :
colidx == "10" ? nominalpipesize_table2d_rows_0(rowidx)[3] :
colidx == "20" ? nominalpipesize_table2d_rows_0(rowidx)[4] :
colidx == "30" ? nominalpipesize_table2d_rows_0(rowidx)[5] :
colidx == "40s" ? nominalpipesize_table2d_rows_0(rowidx)[6] :
colidx == "40" ? nominalpipesize_table2d_rows_0(rowidx)[7] :
colidx == "60" ? nominalpipesize_table2d_rows_0(rowidx)[8] :
colidx == "80s" ? nominalpipesize_table2d_rows_0(rowidx)[9] :
colidx == "80" ? nominalpipesize_table2d_rows_0(rowidx)[10] :
colidx == "100" ? nominalpipesize_table2d_rows_0(rowidx)[11] :
colidx == "120" ? nominalpipesize_table2d_rows_0(rowidx)[12] :
colidx == "140" ? nominalpipesize_table2d_rows_0(rowidx)[13] :
colidx == "160" ? nominalpipesize_table2d_rows_0(rowidx)[14] :
"Error";

function nominalpipesize_table2d_rows_0(rowidx) =
rowidx == "NPS 0.125" ? ["None", 0.035, 0.049, 0.049, "None", "None", 0.068, 0.068, "None", 0.095, 0.095, "None", "None", "None", "None"] :
rowidx == "NPS 0.25" ? ["None", 0.049, 0.065, 0.065, "None", "None", 0.088, 0.088, "None", 0.119, 0.119, "None", "None", "None", "None"] :
rowidx == "NPS 0.375" ? ["None", 0.049, 0.065, 0.065, "None", "None", 0.091, 0.091, "None", 0.126, 0.126, "None", "None", "None", "None"] :
rowidx == "NPS 0.5" ? [0.065, 0.065, 0.083, 0.083, "None", "None", 0.109, 0.109, "None", 0.147, 0.147, "None", "None", "None", 0.187] :
rowidx == "NPS 0.75" ? [0.065, 0.065, 0.083, 0.083, "None", "None", 0.113, 0.113, "None", 0.154, 0.154, "None", "None", "None", 0.218] :
rowidx == "NPS 1" ? [0.065, 0.065, 0.109, 0.109, "None", "None", 0.133, 0.133, "None", 0.179, 0.179, "None", "None", "None", 0.25] :
rowidx == "NPS 1.25" ? [0.065, 0.065, 0.109, 0.109, "None", "None", 0.14, 0.14, "None", 0.191, 0.191, "None", "None", "None", 0.25] :
rowidx == "NPS 1.5" ? [0.065, 0.065, 0.109, 0.109, "None", "None", 0.145, 0.145, "None", 0.2, 0.2, "None", "None", "None", 0.281] :
rowidx == "NPS 2" ? [0.065, 0.065, 0.109, 0.109, "None", "None", 0.154, 0.154, "None", 0.218, 0.218, "None", "None", "None", 0.343] :
rowidx == "NPS 2.5" ? [0.083, 0.083, 0.12, 0.12, "None", "None", 0.203, 0.203, "None", 0.276, 0.276, "None", "None", "None", 0.375] :
rowidx == "NPS 3" ? [0.083, 0.083, 0.12, 0.12, "None", "None", 0.216, 0.216, "None", 0.3, 0.3, "None", "None", "None", 0.437] :
rowidx == "NPS 3.5" ? [0.083, 0.083, 0.12, 0.12, "None", "None", 0.226, 0.226, "None", 0.318, 0.318, "None", "None", "None", "None"] :
rowidx == "NPS 4" ? [0.083, 0.083, 0.12, 0.12, "None", "None", 0.237, 0.237, 0.281, 0.337, 0.337, "None", 0.437, "None", 0.531] :
rowidx == "NPS 4.5" ? ["None", "None", "None", "None", "None", "None", "None", 0.247, "None", "None", 0.355, "None", "None", "None", "None"] :
rowidx == "NPS 5" ? [0.109, 0.109, 0.134, 0.134, "None", "None", 0.258, 0.258, "None", 0.375, 0.375, "None", 0.5, "None", 0.625] :
rowidx == "NPS 6" ? [0.109, 0.109, 0.134, 0.134, "None", "None", 0.28, 0.28, "None", 0.432, 0.432, "None", 0.562, "None", 0.718] :
rowidx == "NPS 7" ? ["None", "None", "None", "None", "None", "None", "None", 0.301, "None", "None", 0.5, "None", "None", "None", "None"] :
rowidx == "NPS 8" ? [0.109, 0.109, 0.148, 0.148, 0.25, 0.277, 0.322, 0.322, 0.406, 0.5, 0.5, 0.593, 0.718, 0.812, 0.906] :
rowidx == "NPS 9" ? ["None", "None", "None", "None", "None", "None", "None", 0.342, "None", "None", 0.5, "None", "None", "None", "None"] :
rowidx == "NPS 10" ? [0.134, 0.134, 0.165, 0.165, 0.25, 0.307, 0.365, 0.365, 0.5, 0.5, 0.593, 0.718, 0.843, 1.0, 1.125] :
rowidx == "NPS 11" ? ["None", "None", "None", "None", "None", "None", "None", 0.375, "None", "None", 0.5, "None", "None", "None", "None"] :
rowidx == "NPS 12" ? [0.156, 0.165, 0.18, 0.18, 0.25, 0.33, 0.375, 0.406, 0.562, 0.5, 0.687, 0.843, 1.0, 1.125, 1.312] :
rowidx == "NPS 14" ? [0.156, "None", 0.188, 0.25, 0.312, 0.375, 0.375, 0.437, 0.593, 0.5, 0.75, 0.937, 1.093, 1.25, 1.406] :
rowidx == "NPS 16" ? [0.165, "None", 0.188, 0.25, 0.312, 0.375, 0.375, 0.5, 0.656, 0.5, 0.843, 1.031, 1.218, 1.437, 1.593] :
rowidx == "NPS 18" ? [0.165, "None", 0.188, 0.25, 0.312, 0.437, 0.375, 0.562, 0.75, 0.5, 0.937, 1.156, 1.375, 1.562, 1.781] :
rowidx == "NPS 20" ? [0.188, "None", 0.218, 0.25, 0.375, 0.5, 0.375, 0.593, 0.812, 0.5, 1.031, 1.28, 1.5, 1.75, 1.968] :
rowidx == "NPS 24" ? [0.218, "None", 0.25, 0.25, 0.375, 0.562, 0.375, 0.687, 0.968, 0.5, 1.218, 1.531, 1.812, 2.062, 2.343] :
rowidx == "NPS 26" ? ["None", "None", "None", 0.312, 0.5, "None", 0.375, "None", "None", 0.5, "None", "None", "None", "None", "None"] :
rowidx == "NPS 28" ? ["None", "None", "None", 0.312, 0.5, 0.625, 0.375, "None", "None", "None", "None", "None", "None", "None", "None"] :
rowidx == "NPS 30" ? [0.25, "None", 0.312, 0.312, 0.5, 0.625, 0.375, "None", "None", 0.5, "None", "None", "None", "None", "None"] :
rowidx == "NPS 32" ? ["None", "None", "None", 0.312, 0.5, 0.625, 0.375, 0.688, "None", 0.5, "None", "None", "None", "None", "None"] :
rowidx == "NPS 34" ? ["None", "None", "None", 0.312, 0.5, 0.625, 0.375, 0.688, "None", "None", "None", "None", "None", "None", "None"] :
rowidx == "NPS 36" ? ["None", "None", "None", 0.312, 0.5, 0.625, 0.375, 0.75, "None", 0.5, "None", "None", "None", "None", "None"] :
rowidx == "NPS 42" ? ["None", "None", "None", "None", "None", "None", 0.375, "None", "None", 0.5, "None", "None", "None", "None", "None"] :
rowidx == "NPS 48" ? ["None", "None", "None", "None", "None", "None", 0.375, "None", "None", 0.5, "None", "None", "None", "None", "None"] :
"Error";

function nominalpipesize_dims(nps="NPS 0.5", sched="40", l=50, part_mode="default") = [
	["nps", nps],
	["od", BOLTS_convert_to_default_unit(nominalpipesize_table_0(nps)[0],"in")],
	["sched", sched],
	["l", l],
	["wall", BOLTS_convert_to_default_unit(nominalpipesize_table2d_0(nps,sched),"in")]];

function nominalpipesize_conn(location,nps="NPS 0.5", sched="40", l=50, part_mode="default") = new_cs(
	origin=pipeConn(l, location)[0],
	axes=pipeConn(l, location)[1]);

module nominalpipesize_geo(nps, sched, l, part_mode){
	pipe_wall(
		get_dim(nominalpipesize_dims(nps, sched, l, part_mode),"od"),
		get_dim(nominalpipesize_dims(nps, sched, l, part_mode),"wall"),
		get_dim(nominalpipesize_dims(nps, sched, l, part_mode),"l")
	);
};

module ANSIB3610M(nps="NPS 0.5", sched="40", l=50, part_mode="default"){
	BOLTS_check_parameter_type("ANSIB3610M","nps",nps,"Table Index");
	BOLTS_check_parameter_type("ANSIB3610M","sched",sched,"Table Index");
	BOLTS_check_parameter_type("ANSIB3610M","l",l,"Length (in)");
	if(BOLTS_MODE == "bom"){
		if(!(part_mode == "diff")){
			echo(str("Wrought steel pipe ANSI B36.10M ",nps," ",sched," Length ",l,""));
		}
		cube();
	} else {
		nominalpipesize_geo(nps, sched, l, part_mode);
	}
};

function ANSIB3610M_dims(nps="NPS 0.5", sched="40", l=50, part_mode="default") = nominalpipesize_dims(nps, sched, l, part_mode);

function ANSIB3610M_conn(location,nps="NPS 0.5", sched="40", l=50, part_mode="default") = nominalpipesize_conn(location,nps, sched, l, part_mode);

module API5L(nps="NPS 0.5", sched="40", l=50, part_mode="default"){
	BOLTS_check_parameter_type("API5L","nps",nps,"Table Index");
	BOLTS_check_parameter_type("API5L","sched",sched,"Table Index");
	BOLTS_check_parameter_type("API5L","l",l,"Length (in)");
	if(BOLTS_MODE == "bom"){
		if(!(part_mode == "diff")){
			echo(str("Wrought steel pipe API 5L ",nps," ",sched," Length ",l,""));
		}
		cube();
	} else {
		nominalpipesize_geo(nps, sched, l, part_mode);
	}
};

function API5L_dims(nps="NPS 0.5", sched="40", l=50, part_mode="default") = nominalpipesize_dims(nps, sched, l, part_mode);

function API5L_conn(location,nps="NPS 0.5", sched="40", l=50, part_mode="default") = nominalpipesize_conn(location,nps, sched, l, part_mode);

module ASMEB3610M(nps="NPS 0.5", sched="40", l=50, part_mode="default"){
	BOLTS_check_parameter_type("ASMEB3610M","nps",nps,"Table Index");
	BOLTS_check_parameter_type("ASMEB3610M","sched",sched,"Table Index");
	BOLTS_check_parameter_type("ASMEB3610M","l",l,"Length (in)");
	if(BOLTS_MODE == "bom"){
		if(!(part_mode == "diff")){
			echo(str("Wrought steel pipe ASME B36.10M ",nps," ",sched," Length ",l,""));
		}
		cube();
	} else {
		nominalpipesize_geo(nps, sched, l, part_mode);
	}
};

function ASMEB3610M_dims(nps="NPS 0.5", sched="40", l=50, part_mode="default") = nominalpipesize_dims(nps, sched, l, part_mode);

function ASMEB3610M_conn(location,nps="NPS 0.5", sched="40", l=50, part_mode="default") = nominalpipesize_conn(location,nps, sched, l, part_mode);

