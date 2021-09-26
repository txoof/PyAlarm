use <finger_joint_box.scad>;
include <PyPortal_model.scad>
use <voronoi.scad>
use <BOLTS/BOLTS.scad>


/* [Design] */
case_x = 125;
case_y = 70;
case_z = 78;
bolt_dia = 3; //[2.5, 3, 4]
// tilt of screen from vertical
display_tilt = 20; //[-45:45]
// widht of finger joints
finger_width = 5;
// thickness of material
material = 3;

// type of speaker grill to use
speaker_grill_type = "circular"; //[circular, voronoi]
//diameter of speaker
speaker_dia = 35;


/* [Feet] */
/* foot_height = 6;
chamfer_rad = 15;
width_bottom = 3;
area_above = 4; */

/* [Circular Speaker Grill] */
rings = 4;
spokes = 5;
grill_width = 1.5;


/* [Vornoi Speaker Grill] */
voronoi_round = 0.1; //[0.1:.1:1]
vornoi_thickness = .4; //[0.1:.1:2]

/* [Hidden] */
z_front = case_z/cos(display_tilt);
y_top = case_y - case_z*tan(display_tilt);

// values for calculating catch body size based on bolt size
key = str("M", bolt_dia);
nut_params = MetricHexagonNut_dims(key=key, part_mode="default");
match = search(["e_min"], nut_params)[0];
nut_dia = nut_params[match][1];

catch_body_size = [nut_dia*2, nut_dia*2]; // XY size of catch
// x, y position of catches (bottom and top panels)
catch_x = (case_x-catch_body_size[0]-material)/2-material;
catch_y = (case_y)/2-material*2.5;
catch_z = (case_z)/2-catch_body_size[1];

// radius of power cable opening
power_cable_rad = finger_width/2;


module power_cable_cutter() {
  translate([0, 0])
  union() {
    circle(r=power_cable_rad);
    translate([0, power_cable_rad/2])
      square([power_cable_rad*2, power_cable_rad], center=true);
  }
}

module vor_speaker_cutter(dia=30, n=100, round=0.1, thickness=0.4, center=true) {
  /*
  create a circular "cutter" using the voronoi library to create
  an organic and semi-random web

  dia(real): diameter of the hole
  n(int): number of voronoi cells
  round(real): roundness of the cells, larger values create rounder cells
  thickess(real): thickess of border between cells
  center(bool): center in the area

  */
  difference() {
    circle(r=dia/2);
    difference() {
      circle(r=dia/2);
      my_random_voronoi(dia, dia, n=n, round=round, thickness=thickness, center=center);
    }
  }
}

module grill_speaker_cutter(dia=30, rings=3, spokes=4, width=1.5) {
  rad = dia/2;
  /*
  create a round speaker grill "Cutter" with concentric circles and spokes

  dia(real): diameter of speaker_dia
  rings(int): number of concentric rings
  spokes(int): number of spokes radiating from center
  width(real): width of spokes and rings
  */
  difference() {
    circle(r=rad);
    union() {
      for (i=[0:rings-1]) {
        difference() {
          circle(r=(rad/rings)*i+width);
          circle(r=(rad/rings)*i);
        }
      }

      for (j=[0:spokes-1]) {
        rotate([0, 0, 360/spokes*j])
        square([width, rad], center=false);
      }
    }
  }
}

module speaker_cutter() {
  if (speaker_grill_type == "circular") {
    grill_speaker_cutter(dia=speaker_dia, rings=rings, spokes=spokes, width=grill_width);
  }
  if (speaker_grill_type == "voronoi") {
    vor_speaker_cutter(speaker_dia, round=voronoi_round, thickness=vornoi_thickness);
  }
}

module bolt_catch(dia=3, bolt_hole=true, nut_hole=false, tab=false, overage=1.05, finger=5, project=false, cutter=false) {
  key=str("M",dia);
  nut_params = MetricHexagonNut_dims(key=key, part_mode="default");
  match = search(["e_min"], nut_params)[0];
  nut_dia = nut_params[match][1];
  corner_rad = dia/4;

  size = [nut_dia*1.5, nut_dia*1.5];
  min_size = [size[0]-corner_rad*2, size[1]-corner_rad*2];

  position = tab==true ? [0, size[0]/2+material] : [0, size[0]/2];

  if (cutter==false) {
    if (project) {
      translate(position)
      cylinder(h=material*100, r=dia/2, center=true);
    } else {

      translate(position)
      difference() {
        union() {
          minkowski() {
            square(min_size, center=true);
            circle(r=corner_rad);
          } // end minkowski
          if (tab) {
            translate([0, -size[1]/2-material/2])
            square([finger, material], center=true);
          }
        } // end union
        if (nut_hole) {
          circle($fn=6, r=nut_dia/2*overage);
        }
        if (bolt_hole) {
          circle(r=dia/2*overage);
        }
      } // end difference
    }
  } else {
    square([finger, material], center=true);
  }
}

module bolt_catch_3d(dia=3, overage=1.05, finger=5, project=false) {
  colors=["gold", "olive"];

  rotate([90, 0, 0]) {
  bolt_catch(tab=true, project=project);
  color(colors[0])
  translate([0, material, -material])
  linear_extrude(height=material, center=true)
    bolt_catch(dia=dia, overage=overage, finger=finger);

  color(colors[1])
  translate([0, 0, 0])
  linear_extrude(height=material, center=true)
    bolt_catch(dia=dia, bolt_hole=false, nut_hole=true, tab=true, overage=overage, finger=finger, project=project);

  color(colors[0])
  translate([0, material, material])
  linear_extrude(height=material, center=true)
    bolt_catch(dia=dia, overage=overage, finger=finger);
  }

  /* bolt_catch(dia=dia, bolt_hole=bolt_hole, nut_hole=nut_hole, tab=tab, overage=overage, finger=finger, project=project, cutter=cutter); */
}


module front() {
  x = case_x;
  y = case_y;
  z = case_z;

  size = [x, y, z];

  difference() {
    faceA(size, finger_width, finger_width, material);
    projection(cut=true)
      rotate([0, 180, 0])
      translate([0, 0, board_mounted_z*2])
      py_portal(mount_p=true, screen_p=true, lights_p=true);

    for (i=[-1, 1]) {
      for(j=[-1, 1]) {
        // amount to shift the +z catches
        shift = j==-1 ? catch_body_size[1]/2+material : 0;
        projection(cut=true) translate([i*catch_x, j*catch_z-shift, 5])
        bolt_catch(project=true);
      } // end j
    } // end i
  } // end difference
} // end front


module back() {
  x = case_x;
  y = case_y;
  z = z_front;

  // calculate the number of divisions
  max_x_div = floor(x/finger_width);
  // calculate the usable divisions
  use_x_div = max_x_div%2==0 ? max_x_div-3 : max_x_div-2;
  // actual number of cuts
  cuts_x = floor(use_x_div/2);
  // set the offset to 0 if number is even, else 1
  x_offset = cuts_x%2==0 ? 0 : 1;

  // use the offset to move the cable opening
  cable_loc = [finger_width*x_offset, -(z/2-material-power_cable_rad), 0];

  size = [x, y, z];
  difference() {
    faceA(size, finger_width, finger_width, material);

    speaker_cutter();

    translate(cable_loc)
    rotate([0, 0, 180])
      power_cable_cutter();
  }

  /* square([x, z], true); */
}

module bottom() {
  x = case_x;
  y = case_y;
  z = case_z;

  size = [x, y, z];

  difference() {
    faceB(size, finger_width, finger_width, material);
    for(i=[-1, 1]) {
      translate([i*catch_x, catch_y]) {
        bolt_catch(cutter=true);
      } // end translate
    } // end i
  } // difference
} // end bottom

module top() {
  x = case_x;
  y = y_top;
  z = case_z;

  size = [x, y, z];
  difference() {
    faceB(size, finger_width, finger_width, material);
    for(i=[-1, 1]) {
      translate([i*catch_x, (y_top-material)/2-2*material]) {
        #bolt_catch(cutter=true);
      }
    }
  }
  /* square([x, y], true); */
}

module feet(x, y, chamfer_rad, width_bottom, area_above=0) {
  /*
  use a minkowski union to create feet with chamfered corners
  x(real): total width
  y(real): total height of feet
  chamfer_rad(real): radius of the chamfer
  width_bottom(real): width of feet at bottom
  area_above(real): area above feet that is left uncut
  */
  $fn=64;

  size = [x, y+area_above];
  min_size = [x-2*chamfer_rad-2*width_bottom, y-2];

  translate([0, -area_above/2]){
    union() {
      translate([0, area_above/2+y/2])
        square([x, area_above], true);
      difference() {
        square([x, y], center=true);
        translate([0, -chamfer_rad/2])
        minkowski() {
          square(min_size, true);
          circle(chamfer_rad);
        }
      } //end difference
    } //end union
  }
}

module side() {
  /*
  left or right side of case
  */
  x = case_y;
  y = case_z;
  y_t = y_top;
  points = [[-x/2, -y/2], [x/2, -y/2], [x/2, y/2], [x/2-y_t, y/2]];

  max_divs_xy = maxDiv([x, y, 0], finger_width);
  usable_divs_xy = usableDiv(max_divs_xy);

  max_divs_tf = maxDiv([y_t, z_front, 0], finger_width);
  usable_divs_tf = usableDiv(max_divs_tf);

  difference() {
    union() {
      polygon(points=points);
      //add feet to sides
      /* translate([0, -y/2-foot_height/2-area_above/2])
        feet(x, foot_height, chamfer_rad, width_bottom, area_above); */
    }
    translate([-x/2, -y/2-.01, 0])
      outsideCuts(length=x, finger=finger_width, cutD=material+.02, div=usable_divs_xy[0]);
    translate([x/2, -y/2, 0])
    rotate([0, 0, 90])
      outsideCuts(length=y, finger=finger_width, cutD=material, div=usable_divs_xy[1]);

    translate(points[0])
    translate([material, 0, 0])
    rotate([0, 0, 90-display_tilt])
      outsideCuts(length=z_front, finger=finger_width, cutD=material, div=usable_divs_tf[1]);

    translate([points[3][0], y/2-material, 0])
      outsideCuts(length=y_t, finger=finger_width, cutD=material, div=usable_divs_tf[0]);

  }
}


module left() {
  rotate([0, 180, 0])
  side();
}

module right() {
  side();
}

module assemble_case(three_d=true) {
  colors = ["red", "blue", "yellow", "purple", "orange", "green"];
  d3_bottom = [0, 0, material/2];
  d3_top = [0, (case_y-y_top)/2, case_z-material/2];
  d3_back = [0, (case_y/2-material/2), case_z/2];
  d3_front = [0, -(case_y-material)/2+(case_y-y_top)/2, case_z/2];
  d3_front_rotate = [90-display_tilt, 0, 0];
  d3_midframe = [d3_front[0], d3_front[1]+board_mounted_z, d3_front[2]];
  d3_left = [-(case_x-material)/2, 0, case_z/2];
  d3_right = [(case_x-material)/2, 0, case_z/2];
  d3_pyportal = [d3_front[0], d3_front[1]+screen_z/2, d3_front[2]];


  if (three_d) {
    color(colors[0])
    translate(d3_bottom)
    linear_extrude(height=material, center=true)
      children(0);

    color(colors[1])
    translate(d3_back)
    rotate([90, 0, 0])
    linear_extrude(height=material, center=true)
      children(5);

    color(colors[2])
    translate(d3_left)
    rotate([90, 0, -90])
    linear_extrude(height=material, center=true)
      children(2);

    /* color(colors[3])
    translate(d3_right)
    rotate([90, 0, 90])
    linear_extrude(height=material, center=true)
      children(3); */

    color(colors[4])
    translate(d3_top)
    rotate([0, 0, 0])
    linear_extrude(height=material, center=true)
      children(4);

    color(colors[5])
    translate(d3_front)
    rotate(d3_front_rotate)
    linear_extrude(height=material, center=true)
      children(1);

    /* translate(d3_midframe)
    rotate(d3_front_rotate)
    linear_extrude(height=material, center=true)
      children(6); */


    d3_catch_z = case_z;
    for (i=[-1, 1]) {
        translate([i*catch_x, catch_y, 0])
          children(7);
    }
    for (j=[-1, 1]) {
      translate([j*catch_x, catch_y, d3_catch_z])
      rotate([0, 180, 0])
        children(7);
    }

    /* translate(d3_pyportal)
    rotate(d3_front_rotate)
      children(8); */

  } else {
    echo("not implemented");
  }

}

assemble_case() {
  bottom();   //0
  back();     //1
  left();     //2
  right();    //3
  top();      //4
  front();    //5
  mid_frame();  //6
  bolt_catch_3d(project=false); //7
  py_portal(); //8
}
