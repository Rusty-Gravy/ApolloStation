#define SOLID 0
#define LIQUID 1
#define GAS 2
#define PLASMA 3 // no, not the flammable gas, get outta here non-bay'ers
// also, no love for the bose-einstein condenstate

#define REAGENTS_OVERDOSE 30
#define REM REAGENTS_EFFECT_MULTIPLIER

/datum/chemical
	var/static/name = "primordial soup"
	var/static/description = "The basis for all chemicals known to mankind"

	var/volume = 0
	var/nutriment_factor = 0
	var/custom_metabolism = REAGENTS_METABOLISM
	var/overdose = 0
	var/overdose_dam = 1

	var/temperature = T20C

	var/phase = null // The phase of the chemical, be it solid, liquid, gas, or plasma
	var/static/list/phase_transitions = list(  "solid-liquid" = T20C-20 // The boundary temp between solid and liquid
												"liquid-gas" = T20C+80 // The boundary temp between liquid and gas
												"gas-plasma" = T20C+1980 ) // The boundary temp between gas and plasma

	// The characteristics of the chemical
	var/static/heat_capacity = 1.0 // How many joules of energy it takes to increase temp by 1 K
	var/static/flash_point = 500 // The temperature that the chemical bursts into flame spotaneously
	var/static/flammability = 1.0 // How easily the chemical is set alight by other fire sources. High values are good for firefighting. From 0.0 to 1.0
	var/static/internal_energy = 1.0 // How much energy, in joules, the chemical releases when 1 mol is burned

	var/static/hardness = 1.0 // How easily it scratches or is scratched, on a scale from 1.0 to 10.0
	var/static/molar_mass = 0.0005 // How many grams per mol of this chemical

	var/static/compressive_strength = 1.0 // Resistance to blasts or bullets, from 0.0 to 1.0
	var/static/tensile_strength = 1.0 // Clothing modifier for other armor values, from 0.0 to 1.0

	var/static/electric_resistance = 1.0 // How easily it conducts electricity from 0.0 to 1.0
	var/static/magnetism = 1.0 // How strongly magnets affect this material. Also determines how good of a magnet this material would make. From 0.0 to 1.0

	var/static/transparency = 1 // If the chemical is transparent, either 1 or 0
	var/static/reflectivity = 1.0 // How much light the material reflects, good for laser protection // from 0.0 to 1.0

	var/static/luminosity = 1 // How brightly the chemical glows
	var/static/radioactivity = 0.0 // How much radiation the chemical gives off

/datum/chemical/adjust_heat( var/joules )

