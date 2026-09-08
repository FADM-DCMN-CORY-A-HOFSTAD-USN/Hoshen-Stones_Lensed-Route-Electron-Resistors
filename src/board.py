# Hoshen 4x3 Matrix Placement Script for KiCad
import pcbnew

board = pcbnew.GetBoard()
board_size_mm = 228.6
rows, cols = 4, 3

# Calculate precise pitch spacing
col_pitch = board_size_mm / (cols + 1)  # ~57.15 mm pitch
row_pitch = board_size_mm / (rows + 1)  # ~45.72 mm pitch

print("Component Footprint Coordinates (Origin at Top-Left Center):")
for r in range(1, rows + 1):
    for c in range(1, cols + 1):
        x_pos = c * col_pitch
        y_pos = r * row_pitch
        component_id = f"REF_ROW{r}_COL{c}"
        print(f"Node: {component_id} -> X: {x_pos:.2f} mm, Y: {y_pos:.2f} mm")
