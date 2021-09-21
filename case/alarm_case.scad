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
case_int_y = 80;
// Internal Z
case_int_z = 75;

/* [Hidden] */
case_size = [case_int_x+2*material, case_int_y+2*material, case_int_z+2*material];


module mid_frame() {
  frame_x = case_int_x+2*material;

  max_divisions = maxDiv([frame_x, case_int_y, case_int_z], finger_width);
  usable_divisions = usableDiv(max_divisions);
  echo(usable_divisions);
  difference() {
    square([case_int_x+2*material, case_int_z], center=true);
    projection(cut=true) translate([0, 0, -material/2-screen_z]) {
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

module top() {
  color("red") {
    faceB(case_size, finger_width, finger_width, material);
  }
}

module bottom() {
  color("purple") {
    faceB(case_size, finger_width, finger_width, material);
  }
}

module front() {
  color("blue") {
    difference() {
      faceA(case_size, finger_width, finger_width, material);
      projection(cut=true) translate([0, 0, -board_mounted_z]) {
        assemble(screen_p=true, lights_p=true, mount_p=true);
      }
    }
  }
}


module back() {
  color("green") {
    faceA(case_size, finger_width, finger_width, material);
  }
}

module left() {
  color("yellow") {
    faceC(case_size, finger_width, finger_width, material);
  }

}

module right() {
  color("orange") {
    faceC(case_size, finger_width, finger_width, material);
  }

}

module layout(threeD=false) {
  top_p2d = [0, 0, 0];
  front_p2d = [0, -(top_p2d[1] + (case_size[1]+case_size[2])/2+material/2), 0];
  back_p2d = [0, (top_p2d[1] + (case_size[1]+case_size[2])/2+material/2), 0];
  left_p2d = [top_p2d[0] + -((case_size[0]+case_size[1])/2+material/2), 0, 0];
  right_p2d = [top_p2d[0] + ((case_size[0]+case_size[1])/2+material/2), 0, 0];
  bottom_p2d = [back_p2d[0], back_p2d[1] + (case_size[1])+material/2, 0];
  midframe_p2d = [front_p2d[0], front_p2d[1] - case_size[2]+material/2, 0];

  bottom_p3d = [0, 0, material/2];
  front_p3d = [0, -(case_size[1]-material)/2, case_size[2]/2];
  back_p3d = [0, (case_size[1]-material)/2, case_size[2]/2];
  left_p3d = [-(case_size[0]/2)+material/2, 0, (case_size[2]/2)];
  right_p3d = [(case_size[0]/2)-material/2, 0, (case_size[2]/2)];
  midframe_p3d = [0, -case_size[1]/2+material/2+board_mounted_z+material/2, case_size[2]/2];
  pyportal_p3d = [0, midframe_p3d[1]-material/2-board_z/2, midframe_p3d[2]];



  if (threeD) {
    translate(bottom_p3d)
    color("red")
    linear_extrude(height=material, center=true)
    children(5);

    translate(front_p3d)
    rotate([90, 0, 0])
    color("blue")
    linear_extrude(height=material, center=true)
    children(1);

    translate(back_p3d)
    rotate([90, 0, 0])
    color("green")
    linear_extrude(height=material, center=true)
    children(2);

    translate(left_p3d)
    rotate([90, 0, 90])
    color("orange")
    linear_extrude(height=material, center=true)
    children(3);

    translate(right_p3d)
    rotate([-90, -0, -90])
    color("yellow")
    linear_extrude(height=material, center=true)
    children(4);

    translate(midframe_p3d)
    rotate([90, 0, 0])
    linear_extrude(height=material, center=true)
    children(6);

    translate(pyportal_p3d)
    rotate([90, 0, 0])
    children(7);





  } else {
    // top
    children(0);

    //front
    translate(front_p2d)
    children(1);

    // back
    translate(back_p2d)
    children(2);

    // left
    translate(left_p2d)
    children(3);

    // right
    translate(right_p2d)
    children(4);

    // bottom
    translate(bottom_p2d)
    children(5);

    translate(midframe_p2d)
    children(6);
  }
}

layout(true) {
  top();
  front();
  back();
  left();
  right();
  bottom();
  mid_frame();
  assemble();

}
