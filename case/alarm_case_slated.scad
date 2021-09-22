use <finger_joint_box.scad>;


/* [Design] */
case_x = 100;
case_y = 75;
case_z = 50;
finger_width = 5;
material = 3;
// tilt of screen from vertical
display_tilt = 45; //[0:45]


/* [Hidden] */
z_front = case_z/cos(display_tilt);
y_top = case_y - case_z*tan(display_tilt);

module back() {
  x = case_x;
  y = case_y;
  z = case_z;

  square([x, z], true);
}

module front() {
  x = case_x;
  y = case_y;
  z = z_front;

  square([x, z], true);
}



module bottom() {
  x = case_x;
  y = case_y;
  z = case_z;

  square([x, y], true);

}

module top() {
  x = case_x;
  y = y_top;
  z = case_z;

  square([x, y], true);
}


module side() {
  /*
  left or right side of case
  */
  x = case_y;
  y = case_z;
  y_t = y_top;
  points = [[-x/2, -y/2], [x/2, -y/2], [x/2, y/2], [x/2-y_t, y/2]];

  polygon(points=points);
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

    color(colors[4])
    translate(d3_top)
    rotate()
    linear_extrude(height=material, center=true)
      children(4);

    color(colors[5])
    translate(d3_front)
    rotate(d3_front_rotate)
    linear_extrude(height=material, center=true)
      children(5);

  } else {
    echo("not implemented");
  }


}

assemble_case() {
  bottom();
  back();
  left();
  right();
  top();
  front();
}
