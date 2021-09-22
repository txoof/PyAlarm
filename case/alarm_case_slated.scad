use <finger_joint_box.scad>;
include <PyPortal_model.scad>


/* [Design] */
case_x = 125;
case_y = 80;
case_z = 75;
finger_width = 5;
material = 3;
// tilt of screen from vertical
display_tilt = 20; //[-45:45]


/* [Hidden] */
z_front = case_z/cos(display_tilt);
y_top = case_y - case_z*tan(display_tilt);

module back() {
  x = case_x;
  y = case_y;
  z = case_z;

  size = [x, y, z];
  faceA(size, finger_width, finger_width, material);

  /* square([x, z], true); */
}

module front() {
  x = case_x;
  y = case_y;
  z = z_front;

  size = [x, y, z];
  faceA(size, finger_width, finger_width, material);

  /* square([x, z], true); */
}



module bottom() {
  x = case_x;
  y = case_y;
  z = case_z;

  size = [x, y, z];
  faceB(size, finger_width, finger_width, material);

  /* square([x, y], true); */

}

module top() {
  x = case_x;
  y = y_top;
  z = case_z;

  size = [x, y, z];
  faceB(size, finger_width, finger_width, material);
  /* square([x, y], true); */
}


module mid_frame() {
  x = case_x;
  y = z_front-4*material;
  z = 0;

  max_divs = maxDiv([x, y, z], finger_width);
  usable_divs = usableDiv(max_divs);

  difference() {
    square([x, y], center=true);
    board_cutter();
    projection(cut=true) translate([0, 0, 20]) py_portal(mount_p=true);


    translate([-(x/2), y/2, 0]) {
      rotate([0, 0, -90]) {
        outsideCuts(y, finger_width, material, usable_divs[1]);
      }
    }

    translate([(x/2), -y/2, 0]) {
      rotate([0, 0, 90]) {
        outsideCuts(y, finger_width, material, usable_divs[1]);
      }
    }

  }
}

module mid_frame_cutter() {

  translate([material/2, 0, 0])
  projection(cut=true)
    translate([0, 0, case_x/2-material/2])
    rotate([0, 90, 0])
    #linear_extrude(height=material, center=true)
    mid_frame();
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



  /* difference() {
    polygon(points=points);
    difference() {
      square([x, y], center=true);
      #faceC([0, case_y, case_z], finger_width, finger_width, material);
    }
  } */
  difference() {
    polygon(points=points);
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

    /* translate([-case_y/2+material/2+5*material, 0, 0])
    rotate([0, 0, -display_tilt])
      mid_frame_cutter(); */

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


  if (three_d) {
    color(colors[0])
    translate(d3_bottom)
    linear_extrude(height=material, center=true)
      children(0);

    color(colors[1])
    translate(d3_back)
    rotate([90, 0, 0])
    linear_extrude(height=material, center=true)
      children(1);

    color(colors[2])
    translate(d3_left)
    rotate([90, 0, -90])
    linear_extrude(height=material, center=true)
      children(2);

    color(colors[3])
    translate(d3_right)
    rotate([90, 0, 90])
    linear_extrude(height=material, center=true)
      children(3);

    /* color(colors[4])
    translate(d3_top)
    rotate([0, 0, 0])
    linear_extrude(height=material, center=true)
      children(4); */

    color(colors[5])
    translate(d3_front)
    rotate(d3_front_rotate)
    linear_extrude(height=material, center=true)
      children(5);

    /* translate(d3_midframe)
    rotate(d3_front_rotate)
    linear_extrude(height=material, center=true)
      children(6); */

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
}
