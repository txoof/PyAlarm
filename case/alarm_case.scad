use <finger_joint_box.scad>;
include <PyPortal_model.scad>
/* [Display] */

/* [Material and Design] */
material = 4.01;
finger_width = 5;


/* [Case Dimensions] */
// Internal X
case_int_x =120;
// Internal Y
case_int_y = 75;
// Internal Z
case_int_z = 75;


module mid_frame() {
  difference() {
    square([case_int_x, case_int_y], center=true);
    translate([0, 0, -material/2-screen_z]) {
      assemble(board_p=true, mount_p=true);
    }
  }
}

mid_frame();
