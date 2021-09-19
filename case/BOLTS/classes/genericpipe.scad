/* Generated by BOLTS, do not modify */
function genericpipe_dims(od=13, id=10, l=1000, part_mode="default") = [
	["od", od],
	["id", id],
	["l", l]];

function genericpipe_conn(location,od=13, id=10, l=1000, part_mode="default") = new_cs(
	origin=pipeConn(l, location)[0],
	axes=pipeConn(l, location)[1]);

module genericpipe_geo(od, id, l, part_mode){
	pipe(
		get_dim(genericpipe_dims(od, id, l, part_mode),"id"),
		get_dim(genericpipe_dims(od, id, l, part_mode),"od"),
		get_dim(genericpipe_dims(od, id, l, part_mode),"l")
	);
};

module genericPipe(od=13, id=10, l=1000, part_mode="default"){
	BOLTS_check_parameter_type("genericPipe","od",od,"Length (mm)");
	BOLTS_check_parameter_type("genericPipe","id",id,"Length (mm)");
	BOLTS_check_parameter_type("genericPipe","l",l,"Length (mm)");
	if(BOLTS_MODE == "bom"){
		if(!(part_mode == "diff")){
			echo(str("Pipe OD ",od," ID ",id," length ",l,""));
		}
		cube();
	} else {
		genericpipe_geo(od, id, l, part_mode);
	}
};

function genericPipe_dims(od=13, id=10, l=1000, part_mode="default") = genericpipe_dims(od, id, l, part_mode);

function genericPipe_conn(location,od=13, id=10, l=1000, part_mode="default") = genericpipe_conn(location,od, id, l, part_mode);

