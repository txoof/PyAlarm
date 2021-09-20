// PyPortal Model
$fn = 36;
/* total_x_in = 3.84;
total_y_in = 2.54;
mount_dia_ext_in = 0.4;
mount_dia_int_in = 0.12;
board_x_in = total_x_in;
board_y_in = 2.13; */

function mm_inch(val) = val * 22.4;

// Board Dimensions
total_x = 89.65; //including connectors and SD card
total_y = 64.55;
mount_dia_ext = 5.08;
mount_dia_int = 3;
board_x = 88.265;
board_y = 54.2;
board_z = 1.57;

//light sensor
lights_dia = 2.4;
lights_loc_y = 22.6;
lights_loc_x = 1.75+lights_dia/2;



// Screen Dimensions
screen_z = 4.057;
screen_y = 55.0;
screen_x = 77.7;
// location relative to bottom left corner of board
screen_loc_x = 9.7;
screen_loc_y = -.8;

// Micro USB Dimensions
musb_y = 8.80;
musb_z = 3.0;
musb_x = 5.60;

// location relative to bottom left corner of board
musb_loc_x = 0;
musb_loc_y = 41.2;

// JST Connector Block
jst_x = 8.8;
jst_y = 35.65;
jst_z = 5.6;

jst_loc_x = board_x-jst_x;
jst_loc_y =10;


module mount(dia, material, int_dia, project=false) {
  if (project == true) {
    union() {
      cylinder(r=dia/2, h=material, center=true);
      cylinder(r=int_dia/2, h=material * 100, center=true);
      translate([0, -dia/4, 0]) {
        cube([dia, dia/2, material], center=true);
      }
    }
  } else {
    difference() {
      union() {
        cylinder(r=dia/2, h=material, center=true);
        translate([0, -dia/4, 0]) {
          cube([dia, dia/2, material], center=true);
        }
      }
      cylinder(r=int_dia/2, h=material*2, center=true);
    }
  }
}

/* module mountx(dia, material,  int_dia=0) {
  difference() {
    union() {
      cylinder(r=dia/2, h=material, center=true);
      translate([0, -dia/4, 0]) {
        cube([dia, dia/2, material], center=true);
      }
    }
    cylinder(r=int_dia/2, h=material*2, center=true);
  }
} */


module screen() {
  color("silver") {
    cube([screen_x, screen_y, screen_z], center=true);
  }
}

module micro_usb() {
  color("silver") {
    cube([musb_x, musb_y, musb_z], center=true);
  }
}

module jst_block() {
  color("DimGray") {
    cube([jst_x, jst_y, jst_z], center=true);
  }
}

module light_sensor(project=false) {
  if (project == true) {
    color("yellow") {
      cylinder(h=board_z*100, r=lights_dia/2, center=true);
    }
  } else {
    color("yellow") {
      cylinder(h=board_z*2, r=lights_dia/2, center=true);
    }
  }

}


module board(project=false) {
  board_dim = [board_x, board_y, board_z];
    union(){
      if (project==true) {
        translate([-(board_x)/2+lights_loc_x, -(board_y)/2+lights_loc_y, 0]) {
          light_sensor(project);
        } // close translate
      } // end if project
      color("purple") {
        difference() {
          cube(board_dim, true);
          if (project==false) {
            translate([-(board_x)/2+lights_loc_x, -(board_y)/2+lights_loc_y, 0]) {
              light_sensor(project);
            } // close translate
          } // end if project
        } // close difference
          for (i=[-1, 1]) {
            for (j=[-1, 1]) {
              // if j is negative, rotate 180
              rot = j > 0 ? 0 : 180;
              translate([i*board_dim[0]/2-i*mount_dia_ext/2, j*board_dim[1]/2+j*mount_dia_ext/2, 0]) {
                rotate([0, 0, rot]) {
                  mount(mount_dia_ext, board_z, mount_dia_int, project);
                } // close rotate
              } // close translate
            } // close j
          } // close i
      } // close color
      // place screen
      translate([-(board_x-screen_x)/2+screen_loc_x, -(board_y-screen_y)/2+screen_loc_y, board_z/2-0.001+screen_z/2]) {
        screen();
      }

      // place micro usb
      translate([-(board_x-musb_x)/2, -(board_y-musb_y)/2+musb_loc_y, -board_z/2-musb_z/2]) {
        micro_usb();

      }

      // place JST block
      translate([-(board_x-jst_x)/2+jst_loc_x, -(board_y-jst_y)/2+jst_loc_y, -(board_z+jst_z)/2]) {
        jst_block();
      }
  }
}

board();
