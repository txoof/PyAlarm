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
  frame_x = case_int_x+2*material;

  max_divisions = maxDiv([frame_x, case_int_y, case_int_z], finger_width);
  usable_divisions = usableDiv(max_divisions);
  echo(usable_divisions);
  difference() {
    square([case_int_x+2*material, case_int_y], center=true);
    translate([0, 0, -material/2-screen_z]) {
      assemble(board_p=true, mount_p=true);
    }

    translate([frame_x/2-material, case_int_z/2, 0]) {
      rotate([0, 0, -90]) {
        outsideCuts(case_int_y, finger_width, material, usable_divisions[2]);
      }
    }
    translate([-frame_x/2+material, -case_int_z/2, 0]) {
      rotate([0, 0, 90]) {
        outsideCuts(case_int_y, finger_width, material, usable_divisions[2]);
      }
    }
  }
}

mid_frame();
