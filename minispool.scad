// 2024-09-07 adam mead
// spool holder for a 3d printer.
// uses 2x 608 bearings, 8mm threaded rod if you need to secure the bearings, or plain rod
// if you don't need to secure the bearings. For instance, bearings can't come out due to
// side supports or they are a tight fit.

// resolution of the cylinder
$fn = 64;
//resolution of the core - use 6 for a hexagon (easier to print without support)
coreres = 6;
// Diameter of the roller
core_d = 40;
//Overall length of the roller including the end rings
core_w = 90;
// Diameter of the bearing
bearing_d = 22;
// Width of the bearing
bearing_w = 7;
// Diameter of the center hole (should be slightly less than the bearing_d)
center_hole_d = 18;
// Width of the end stops
end_w = 3;
// Diameter of the end stops
end_d = core_d+10;

module core() {
        difference() {
            cylinder(h = core_w, d = core_d);
                cylinder(h = bearing_w, d = bearing_d);
            translate([0,0,core_w-bearing_w]) 
                cylinder(h = bearing_w, d = bearing_d);
            cylinder(h = core_w, d = center_hole_d, $fn = coreres);
        }
};

module create_endring() {
    difference() {
        cylinder(h = end_w, d = end_d);
        cylinder(h = end_w, d = core_d);
    };

}


module ends() {
    create_endring();
    translate([0,0,core_w-end_w])
        create_endring();
}

color("moccasin")
    render() {
        core();
        ends();
};
