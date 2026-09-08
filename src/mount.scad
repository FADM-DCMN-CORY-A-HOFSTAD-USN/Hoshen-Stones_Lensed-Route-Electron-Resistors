// Hoshen Circular Gold Mounting Brackets (Mishbetzot Zahav)
// Component foot print exporter for 3D modeling and OpenSCAD assembly
// Units: millimeters (mm)

$fn = 120; // High resolution rendering for curves

// Global Design Tolerances & Dimensions
board_dim = 228.6;       // 1 Span size
thickness = 3.0;         // Base cloth thickness
bracket_height = 5.0;    // Depth of the gold mounting rim
inner_radius = 20.0;     // Clear aperture entry radius for gemstone lens
wall_thickness = 4.0;    // Structural width of the solid gold boundary frame
groove_depth = 1.5;      // Inset channel depth for holding flux paste/solder

// Individual Bracket Component Footprint Module
module gold_mounting_bracket(hebrew_id, designator) {
    echo(str("GEN_BRACKET: Instantiating ", designator, " for ", hebrew_id));
    
    difference() {
        union() {
            // Main Outer Gold Ring Body
            cylinder(h = bracket_height, r = inner_radius + wall_thickness, center = false);
            
            // Lower Soldering Lip (Overlapping trace interface for the crossbar array)
            cylinder(h = 1.0, r = inner_radius + wall_thickness + 2.0, center = false);
        }
        
        // Inner Gemstone Aperture Cutout (Clear flight path for the lensed routing)
        translate([0, 0, -1])
            cylinder(h = bracket_height + 2, r = inner_radius, center = false);
            
        // Flux Paste & Solder Grooves (Prevents boundary resistance and heat bottlenecks)
        translate([0, 0, bracket_height - groove_depth]) {
            difference() {
                cylinder(h = groove_depth + 1, r = inner_radius + wall_thickness - 1.0, center = false);
                cylinder(h = groove_depth + 2, r = inner_radius + 1.0, center = false);
            }
        }
    }
}

// Global 4x3 Crossbar System Assembly
module full_bracket_array_assembly() {
    // Spatial coordinates dynamically mapped to match the KiCad matrix pitch
    col_pitch = board_dim / 4; // ~57.15 mm
    row_pitch = board_dim / 5; // ~45.72 mm
    
    // Node Names array mapped straight to the JSON Netlist
    names = [
        ["Odem", "Pitdah", "Bareqet"],
        ["Nofekh", "Sappir", "Yahalom"],
        ["Leshem", "Shevo", "Achlamah"],
        ["Tarshish", "Shoham", "Yashfeh"]
    ];

    for (r = [1:4]) {
        for (c = [1:3]) {
            // Precise X/Y grid calculation
            x_pos = c * col_pitch;
            y_pos = r * row_pitch;
            
            translate([x_pos, y_pos, thickness]) {
                gold_mounting_bracket(names[r-1][c-1], str("R", r, "_C", c));
            }
        }
    }
}

// Execution Render
color([0.85, 0.65, 0.12, 1.0]) { // 24k Gold Layer Shader Material
    full_bracket_array_assembly();
}

// Base Grid Guide Line Reference (Simulating the Blue/Red crosshatched FPGA traces)
%translate([0, 0, 0]) cube([board_dim, board_dim, thickness]);
