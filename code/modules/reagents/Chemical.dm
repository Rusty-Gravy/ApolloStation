#define SOLID 0
#define LIQUID 1
#define GAS 2

#define LOOSE 1 // Whether a solid material is either a solid or loose, like dust or pellets

#define REAGENTS_OVERDOSE 30
#define REM REAGENTS_EFFECT_MULTIPLIER

/*
	This datum is used to specify the physical characteristics of each chemical
	There will only be one instance of each type per game. Every time the chemical is use, it is referenced via ID
*/

/datum/chemical
	var/const/static/name = "primordial soup"
	var/const/static/description = "The basis for all chemicals known to mankind"
	var/const/static/id = "primordial soup" // The ID used for quick reference

	var/const/static/color = "#FF6600"
	var/const/static/l_color = "#803300"

	var/const/static/nutriment_factor = 0
	var/const/static/custom_metabolism = REAGENTS_METABOLISM

	var/const/static/overdose = 0
	var/const/static/overdose_dam = 1 // How much toxin damage the chemical does when overdosing

	// Damage adjustment values for mob metabolizing, used per tick of mob.life()
	// Positive to add damage, negative to remove damage
	var/const/static/toxic_adj = 0
	var/const/static/brute_adj = 0
	var/const/static/oxy_adj= 0
	var/const/static/clone_adj = 0
	var/const/static/hallos_adj = 0

	var/const/static/solid_state = SOLID // Either SOLID or LOOSE, basically whether its all one piece of material or not. Loose solids turn into dust when you toss them on the floor
	var/const/static/dissolves = 1 // Does the solid chemical dissolve in liquids?
	var/const/static/list/phase_transitions = list(  "solid-liquid" = T20C-20 // The boundary temp between solid and liquid
												"liquid-gas" = T20C+80 // The boundary temp between liquid and gas
												"gas-plasma" = T20C+1980 ) // The boundary temp between gas and plasma

	// The characteristics of the chemical, most of these are only used when the chemical is a solid
	var/const/static/heat_capacity = 1.0 // How many joules of energy it takes to increase temp by 1 K
	var/const/static/flash_point = 500 // The temperature that the chemical bursts into flame spotaneously
	var/const/static/flammability = 1.0 // How easily the chemical is set alight by other fire sources. High values are good for firefighting. From 0.0 to 1.0

	var/const/static/hardness = 1.0 // How easily it scratches or is scratched, on a scale from 1.0 to 10.0
	var/const/static/molar_mass = 0.0005 // How many grams per mol of this chemical

	var/const/static/compressive_strength = 0.0 // Resistance to blasts or bullets, from 0.0 to 1.0
	var/const/static/tensile_strength = 0.0 // Clothing modifier for other armor values, from 0.0 to 1.0
	var/const/static/permeability_coefficient = 0.0 // Mainly used for virus and chemical transfer, if 1.0, then nothhing is transferred

	var/const/static/electric_resistance = 0.0 // How easily it conducts electricity from 0.0 to 1.0
	var/const/static/magnetism = 0.0 // How strongly magnets affect this material. Also determines how good of a magnet this material would make. From 0.0 to 1.0

	var/const/static/transparency = 1 // If the chemical is transparent, either 1 or 0
	var/const/static/reflectivity = 0.0 // How much light the material reflects, good for laser protection // from 0.0 to 1.0

	var/const/static/luminosity = 1 // How brightly the chemical glows
	var/const/static/radioactivity = 0.0 // How much radiation the chemical gives off

// Calculates temperature from heat and moles
/datum/chemical/proc/calcTemp( var/heat, var/moles )
	if( !heat_capacity )
		return 0
	return heat/heat_capacity

/datum/chemical/proc/calcHeat( var/temperature, var/moles )
	if( !temperature )
		return 0

/datum/chemical/proc/onMobLife(var/mob/living/M as mob, var/alien)
	if(!istype(M, /mob/living))
		return //Noticed runtime errors from pacid trying to damage ghosts, this should fix. --NEO
	if( overdose && (volume >= overdose))//Overdosing, wooo
		M.adjustToxLoss(overdose_dam)
	holder.remove_reagent(src.id, custom_metabolism) //By default it slowly disappears.
	return

/datum/chemical/proc/onMove(var/mob/M)
	return
