// Hoshen Board Enclosure & Folded Pouch Spec
$fn = 50;

board_dim = 228.6;   // 1 Span in mm
thickness = 3.0;     // Matrix thickness
pouch_gap = 12.0;    // Clearance for internal Urim/Thummim Tool Bag
lens_radius = 20.0;  // Golden circular housing radius (from Image 3)

module active_front_panel() {
    difference() {
        // Main Board Substrate
        cube([board_dim, board_dim, thickness]);
        
        // 4x3 Array of Lens Cutouts (Programmable Interconnect Portals)
        for (r = [1:4]) {
            for (c = [1:3]) {
                translate([c * (board_dim/4), r * (board_dim/5), -1])
                    cylinder(h = thickness + 2, r = lens_radius);
            }
        }
    }
}

module shielded_back_plate() {
    // Solid Back Ground Plane
    cube([board_dim, board_dim, thickness]);
}

// Render Folded Assembly
// Front Active Matrix
active_front_panel();

// 90-Degree Bottom Flange Connection
translate([0, 0, -pouch_gap - thickness]) {
    shielded_back_plate();
}

// Side Seams (The Soldered Borders from Image 2)
translate([0, 0, -pouch_gap])
    cube([thickness, board_dim, pouch_gap]); // Left Busbar
translate([board_dim - thickness, 0, -pouch_gap])
    cube([thickness, board_dim, pouch_gap]); // Right Busbar

echo("CHASSIS READY: Insert tool_bag_kit.stl into the internal pouch cavity.");
