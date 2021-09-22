use <finger_joint_box.scad>;


/* [Design] */
case_x = 100;
case_y = 70;
case_z = 50;
finger_width = 5;
material = 3;
// tilt of screen from vertical
d_tilt = 45; //[0:45]



/* [Hidden] */
front_y = case_z/cos(d_tilt);
top_y = case_y -case_z*tan(d_tilt);


module front() {

  faceA([case_x, front_y, case_z], finger_width, finger_width, material);
}


module left() {
  max_divs = maxDiv([case_x, top_y, front_y], finger_width);
  usable_divs = usableDiv(max_divs);

  difference() {
    union() {
      faceC([case_x, case_y, case_z], finger_width, finger_width, material);
      translate([material/2, material/2]) {
        square([case_y-material, case_z-material], center=true);
      } // end translate
    } // end union
    translate([case_y/2, -case_z/2, 0])
    rotate([0, 0, 90+d_tilt])
    #outsideCuts(front_y, finger_width, material, usable_divs[1]);
  } // end difference
}

left();
