/*
	This datum is used to specify the characteristics of a reaction.
	There will only ever be one instance of each type in a game.
	The reactions are referenced using required chemicals
*/

/datum/chemical_reaction
	var/const/static/list/reactants = list()
	var/const/static/list/catalysts = list()
	var/const/static/list/products = list()

	var/const/static/heat_transfer = 0 // How much heat is transferred in the reaction, in joules. Positive for endothermic reactions, negative for exothermic
	var/const/static/required_temp = null // The temperature required for the reaction to occur, leave null if no requried temp

	// Both of these variables are mostly going to be used with slime cores - but if you want to, you can use them for other things
	var/const/static/atom/required_container = null // the container required for the reaction to happen

// Returns true if all reactants and catalysts are present in the composition
/datum/chemical_reaction/proc/checkMixture( var/datum/composition/mixture )
	var/list/chemicals = list( mixture.chemicals )
	var/list/required = reactants | catalysts // Combines unique indexes

	chemicals &= required // Keeps indexes from chemicals that are in common with required

	if( chemicals.len == required.len ) // If both are equal length, that means they are the same
		return 1
	else
		return 0

/datum/chemical_reaction/proc/onReaction( var/datum/composition/mixture )
	if( !reactants || !reactants.len ) return 0
	if( !checkMixture( mixture )) return 0

	var/limit = mixture.total_moles
	for( var/chemical in mixture.chemicals )
		if( chemical in reactants)
			var/ratio = ( mixture.chemicals[chemical] )/reacants[chemical]
			if( ratio < limit )
				limit = ratio

	for( var/chemical in mixture.chemicals )
		if( chemical in reactants)
			mixture.adjChemical( chemical, limit*reactants[chemical] )

	return 1
