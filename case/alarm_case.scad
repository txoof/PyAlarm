use <finger_joint_box.scad>

/* [Display] */

/* [Material and Design] */
material = 4.01;

module foot(w, h, ratio, center=false) {
  q = w - w*(1-ratio);

 trans_coord = center ? [-w/2, -h/2] : [0, 0, 0];

 coords = [[0, 0], [w, 0],
           [q, h], [0, h]];
 translate(trans_coord)
     polygon(coords);
}
