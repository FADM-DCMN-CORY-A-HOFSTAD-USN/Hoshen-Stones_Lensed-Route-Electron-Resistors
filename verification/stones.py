def calculate_crystal_node(density, mass_grams, thickness_mm, dielectric_constant):
    # Convert parameters to standard engineering units
    volume_cm3 = mass_grams / density
    area_cm2 = volume_cm3 / (thickness_mm / 10.0)
    area_m2 = area_cm2 * 0.0001
    d_m = thickness_mm * 0.001
    
    # Vacuum permittivity constant
    epsilon_0 = 8.854e-12
    
    # Calculate capacitance in picofarads
    capacitance_pf = (dielectric_constant * epsilon_0 * area_m2 / d_m) * 1e12
    return round(capacitance_pf, 4)

# Example: Row 2, Node 3 (Quartz/Yahalom Layer)
quartz_density = 2.65
quartz_mass = 45.0
quartz_thickness = 5.0
quartz_dielectric = 4.5

capacitance = calculate_crystal_node(quartz_density, quartz_mass, quartz_thickness, quartz_dielectric)
print(f"Yahalom Node Capacitance: {capacitance} pF")
