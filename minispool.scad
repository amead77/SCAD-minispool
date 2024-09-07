// 2024-09-07 adam mead
// spool holder for a 3d printer.
// uses 2x 608 bearings, 8mm threaded rod if you need to secure the bearings, or plain rod
// if you don't need to secure the bearings. For instance, bearings can't come out due to
// side supports or they are a tight fit.

//Which part to make = 0 for tube, 1 for support
partmake = 1;

// ---- Tube ----

// resolution of the cylinder
cylres = 64;
//resolution of the core - use 6 for a hexagon (easier to print without support if printing on side)
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

// ---- Support ----

cPinD = 5;
cPinLen = 30;
cPinOffsetX = 15;
cPinOffsetZ = 11.5;
cPinOffsetY = 0;
cProfile = [[0,0],[5,15],[10,15],[11,5],[19,5],[20,15],[25,15],[30,0],[0,0]];
cProfileExtrude = 23;

// ---- Code ----


// --- Tube ---
module core() {
        difference() {
            cylinder(h = core_w, d = core_d, $fn = cylres);
                cylinder(h = bearing_w, d = bearing_d, $fn = cylres);
            translate([0,0,core_w-bearing_w]) 
                cylinder(h = bearing_w, d = bearing_d, $fn = cylres);
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

// --- Support ---

module profile() {
    linear_extrude(height = cProfileExtrude)
        polygon(points = cProfile);
}

module legs() {
    translate([0,-10,0]) {
        cube([30, 10, 5]);
    };
    translate([0,-10,18]) {
        cube([30, 10, 5]);
    };
}

module pin() {
    rotate([90,0,0]) {
        translate([cPinOffsetX, cPinOffsetZ, cPinOffsetY]) {
            cylinder(h = cPinLen, d = cPinD, $fn = 32);
        };
    };
}

if (partmake == 0) {
color("moccasin")
    render() {
        union() {
            core();
            ends();
        };
    };
};

if (partmake == 1) {
    render() {
        union() {
            profile();
            legs();
            pin();
        };
    };

};