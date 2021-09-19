// PyPortal Model
$fn = 36;
total_x_in = 3.84;
total_y_in = 2.54;
mount_dia_ext_in = 0.4;
mount_dia_int_in = 0.12;
board_x_in = total_x_in;
board_y_in = 2.13;

function mm_inch(val) = val * 22.4;

// Board Dimensions
total_x = 89.534; //including connectors and SD card
total_y = mm_inch(total_y_in);
mount_dia_ext = 5.08;
mount_dia_int = 3;
board_x = 88.265;
board_y = 54.102;
board_z = 1.57;


// Screen Dimensions
screen_z = 4.057;
screen_y = 53.6;
screen_x = 76.0;
// location relative to bottom left corner of board
screen_loc_x = 10.56;

// Micro USB Dimensions
musb_y = 8.80;
musb_z = 3.0;
musb_x = 5.60;

// location relative to bottom left corner of board
musb_loc_x = 0;
musb_loc_y = 49.198;



module mount(dia, material,  int_dia=0) {
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


module board() {
  board_dim = [board_x, board_y, board_z];
    union(){
      color("purple") {
        cube(board_dim, true);
        for (i=[-1, 1]) {
          for (j=[-1, 1]) {
            // if j is negative, rotate 180
            rot = j > 0 ? 0 : 180;
            translate([i*board_dim[0]/2-i*mount_dia_ext/2, j*board_dim[1]/2+j*mount_dia_ext/2, 0]) {
              rotate([0, 0, rot]) {
                mount(mount_dia_ext, board_z, mount_dia_int);
              }

            }

          }
        }

      }
      translate([-(board_x-screen_x)/2+screen_loc_x, 0, board_z/2-0.001+screen_z/2]) {
        screen();
      }

      translate([-(board_x-musb_x)/2, -(board_y-musb_y)/2+musb_loc_y-musb_y, -board_z/2-musb_z/2]) {
        rotate([0, 0, 0]) {
          #micro_usb();
        }
      }
  }
}

board();
