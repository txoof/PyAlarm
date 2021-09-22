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
//larger size for projection
lights_dia_project = lights_dia*2;
lights_loc_y = 22.6;
lights_loc_x = 1.75+lights_dia/2;

//sdcard
sd_x = 17.6;
sd_y = 14.2;
sd_z = 2.1;
sd_loc_x = -1.5;
sd_loc_y = 25;


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

board_mounted_z = board_z + screen_z;

module sd_card(project=false) {
  z_mult = project==true ? 100 : 1;
  color("pink") {
    cube([sd_x, sd_y, sd_z*z_mult], true);
  }
}

module mount(dia, material, int_dia, project=false) {
  z_mult = project==true ? 100 : 1;
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

module screen(project=false) {
  z_mult = project==true ? 100 : 1;
  color("silver") {
      cube([screen_x, screen_y, screen_z * z_mult], center=true);
  }
}

module micro_usb(project=false) {
  z_mult = project==true ? 100 : 1;
  color("silver") {
    cube([musb_x, musb_y, musb_z*z_mult], center=true);
  }
}

module jst_block(project=false) {
  z_mult = project==true ? 100 : 1;
  color("DimGray") {
    cube([jst_x, jst_y, jst_z*z_mult], center=true);
  }
}

module light_sensor(project=false) {
  z_mult = project==true ? 100 : 1;
  rad = project == true ? lights_dia_project/2 : lights_dia/2;
  color("yellow") {
    cylinder(h=board_z*2*z_mult, r=rad, center=true);
  }

}

module board(board_p=false, mount_p=false) {
  /*
  PCB board outline with mounting holes
  board_p(bool): project board 100*z height
  mount_p(bool): project mount
  */
  z_mult = board_p==true ? 100 : 1;

  union() {
    color("purple") {
      difference() {
        cube([board_x, board_y, board_z*z_mult], center = true);
        translate([-(board_x)/2+lights_loc_x, -(board_y)/2+lights_loc_y, 0]) {
          light_sensor();
        }
      }
      translate([-(board_x-sd_x)/2+sd_loc_x, -(board_y-sd_y)/2+sd_loc_y, -board_z/2-sd_z/2]) {
        sd_card(board_p);
      }
      for (i=[-1, 1]) {
        for (j=[-1, 1] ) {
          // if j is negative, rotate 180
          rot = j > 0 ? 0 : 180;
          translate([i*board_x/2-i*mount_dia_ext/2, j*board_y/2+j*mount_dia_ext/2, 0]) {
            rotate([0, 0, rot]) {
              mount(mount_dia_ext, board_z, mount_dia_int, mount_p);

              /* if ((i==1) && (j==-1)) {
                //pass on lower right corner -- useless can't be bolted
              } else {
                mount(mount_dia_ext, board_z, mount_dia_int, mount_p);
              } */
            } // close rotate
          } // close translate
        } // close j
      } // close i
    } // close color
  } // close union
} // close board


module board_cutter() {
  cutter_x = board_x+25;
  mount_x = mount_dia_ext;
  //width for corner with micro usb
  musb_y = 5;
  //width for corner with jst that is usable
  jst_y = 3;

  difference() {
    square([cutter_x, board_y], center=true);
    translate([-board_x/2+mount_x/2, board_y/2-musb_y/2, 0])
      square([mount_x, musb_y], center=true);

    translate([board_x/2-mount_x/2, board_y/2-jst_y/2, 0])
      square([mount_x, jst_y], center=true);
  }
}


module py_portal(board_p=false, mount_p=false, lights_p=false, screen_p=false, enlarge=1) {
  // add the board
  board(board_p, mount_p);

  // add the light sensor projection if needed
  if (lights_p==true) {
    translate([-(board_x)/2+lights_loc_x, -(board_y)/2+lights_loc_y, 0]) {
      light_sensor(lights_p);
    }
  }

  //add the screen
  translate([-(board_x-screen_x)/2+screen_loc_x, -(board_y-screen_y)/2+screen_loc_y, board_z/2+screen_z/2]) {
    screen(screen_p);
  }

  //add the JST connector Block
  translate([-(board_x-jst_x)/2+jst_loc_x, -(board_y-jst_y)/2+jst_loc_y, -board_z/2-jst_z/2]) {
    jst_block();
  }

  // add the micro USB
  translate([-(board_x-musb_x)/2+musb_loc_x, -(board_y-musb_y)/2+musb_loc_y, -board_z/2-musb_z/2]) {
    micro_usb();
  }
}

/* !assemble(lights_p=true, screen_p=true); */
