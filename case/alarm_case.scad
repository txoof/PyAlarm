use <finger_joint_box.scad>;
include <PyPortal_model.scad>
use <voronoi.scad>



/* [Display] */
alpha=0.8; //[0.1:.1:1]


/* [Material and Design] */
material = 4.01;
finger_width = 5;
global_overage = 0.05;
//vornoi roundess
voronoi_round = 0.1; //[0.1:.1:1]
vornoi_thickness = .4; //[0.1:.1:2]
speaker_grill_rings = 4;
speaker_grill_spokes = 5;
speaker_grill_thickness = 1.5;

/* [Case Dimensions] */
// Internal X
case_int_x =125;
// Internal Y
case_int_y = 80;
// Internal Z
case_int_z = 65;

/* [Hidden] */
case_size = [case_int_x+2*material, case_int_y+2*material, case_int_z+2*material];


// 2d and 3d positions
top_p2d = [0, 0, 0];
front_p2d = [0, -(top_p2d[1] + (case_size[1]+case_size[2])/2+material/2), 0];
back_p2d = [0, (top_p2d[1] + (case_size[1]+case_size[2])/2+material/2), 0];
left_p2d = [top_p2d[0] + -((case_size[0]+case_size[1])/2+material/2), 0, 0];
right_p2d = [top_p2d[0] + ((case_size[0]+case_size[1])/2+material/2), 0, 0];
bottom_p2d = [back_p2d[0], back_p2d[1] + (case_size[1])+material/2, 0];
midframe_p2d = [front_p2d[0], front_p2d[1] - case_size[2]+material/2, 0];

bottom_p3d = [0, 0, material/2];
top_p3d = [0, 0, material/2+case_size[2]-bottom_p3d[2]*2];
front_p3d = [0, -(case_size[1]-material)/2, case_size[2]/2];
back_p3d = [0, (case_size[1]-material)/2, case_size[2]/2];
left_p3d = [-(case_size[0]/2)+material/2, 0, (case_size[2]/2)];
right_p3d = [(case_size[0]/2)-material/2, 0, (case_size[2]/2)];
midframe_p3d = [0, -case_size[1]/2+material/2+board_mounted_z+material/2, case_size[2]/2];
pyportal_p3d = [0, midframe_p3d[1]-material/2-board_z/2, midframe_p3d[2]];

// location of mid frame for cutting fingers in left and right faces
midframe_loc_y = midframe_p3d[1];
speaker_loc = [0, 0];
speaker_dia = 50;

module vor_speaker_cutter() {
  difference() {
    circle(r=speaker_dia/2);
    difference() {
      circle(r=speaker_dia/2);
      my_random_voronoi(speaker_dia, speaker_dia, n=100, round=voronoi_round, thickness=vornoi_thickness, center=true);
    }
  }
}

module grill_speaker_cutter(rings=3, spokes=4, width=1.5) {
  rad = speaker_dia/2;

  difference() {
    circle(r=speaker_dia/2);
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


module mid_frame() {
  frame_x = case_int_x+2*material;

  max_divisions = maxDiv([frame_x, case_int_y, case_int_z], finger_width);
  usable_divisions = usableDiv(max_divisions);

  difference() {
    square([frame_x, case_int_z], center=true);
    board_cutter();
    translate([frame_x/2-material, case_int_z/2, 0]) {
      rotate([0, 0, -90]) {
        outsideCuts(case_int_z, finger_width, material, usable_divisions[2]);
      }
    }

    translate([-(frame_x/2), case_int_z/2, 0]) {
      rotate([0, 0, -90]) {
        outsideCuts(case_int_z, finger_width, material, usable_divisions[2]);
      }
    }
    projection(cut=true) translate([0, 0, material/2]) {
      py_portal(mount_p=true);
    }



  }
  /* translate([0, 0, material/2])
  py_portal(); */
}


/* module xmid_frame() {
  frame_x = case_int_x+2*material;

  max_divisions = maxDiv([frame_x, case_int_y, case_int_z], finger_width);
  usable_divisions = usableDiv(max_divisions);
  difference() {
    square([case_int_x+2*material, case_int_z], center=true);
    projection(cut=true) translate([0, 0, -material/2-screen_z]) {
         py_portal(board_p=true, mount_p=true);
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
} */

module top() {
  color("red") {
    faceB(case_size, finger_width, finger_width, material);
  }
}

module bottom() {
  color("purple") {
    difference() {
      faceB(case_size, finger_width, finger_width, material);
      translate(speaker_loc) {
        /* vor_speaker_cutter(); */
        grill_speaker_cutter(rings=speaker_grill_rings, width=speaker_grill_thickness, spokes=speaker_grill_spokes);

      }

    }
  }
}

module front() {
  color("blue") {
    difference() {
      faceA(case_size, finger_width, finger_width, material);
      projection(cut=true) translate([0, 0, -board_mounted_z]) {
        scale([1.015, 1.015, 1])
        py_portal(screen_p=true);
      }
      projection(cut=true) translate([0, 0, -board_mounted_z]) {
        py_portal(lights_p=true);
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
  /* midframe_loc_y = case_int_y/2+material/2-board_mounted_z; */
  color("yellow") {
    difference() {
      faceC(case_size, finger_width, finger_width, material);

      projection(cut=true) rotate([0, 90, 0])
      translate([case_int_x/2+material/2, 0, midframe_loc_y])
      linear_extrude(height=material, center=true) mid_frame();
    }
  }

}


module right() {
  color("orange") {
    difference() {
      faceC(case_size, finger_width, finger_width, material);

      projection(cut=true) rotate([0, 90, 0])
      translate([case_int_x/2+material/2, 0, -midframe_loc_y])
      linear_extrude(height=material, center=true) mid_frame();

    }
  }

}

module layout(threeD=false) {




  if (threeD) {
    translate(bottom_p3d)
    color("purple", alpha)
    linear_extrude(height=material, center=true)
    children(5);

    translate(front_p3d)
    rotate([90, 0, 0])
    color("blue", alpha)
    linear_extrude(height=material, center=true)
    children(1);

    translate(back_p3d)
    rotate([90, 0, 0])
    color("green", alpha)
    linear_extrude(height=material, center=true)
    children(2);

    translate(left_p3d)
    rotate([90, 0, 90])
    color("yellow", alpha)
    linear_extrude(height=material, center=true)
    children(3);

    translate(right_p3d)
    rotate([-90, -0, -90])
    color("orange", alpha)
    linear_extrude(height=material, center=true)
    children(4);

    translate(midframe_p3d)
    rotate([90, 0, 0])
    linear_extrude(height=material, center=true)
    children(6);

    translate(pyportal_p3d)
    rotate([90, 0, 0])
    children(7);

    translate(top_p3d)
    color("red", alpha)
    linear_extrude(height=material, center=true)
    children(0);





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
  py_portal();

}
