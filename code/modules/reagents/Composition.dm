/*
	This datum is used to interact with the chemical datums.
	It handles everything that interacts with chemicals in-game

	There will be an instance of composition every time there are chemicals in game
*/

/datum/composition
	var/atom/my_atom = null

	var/list/chemicals = list() // Stores a list of chemical ID's with a reference to number of moles

	var/total_moles = 0
	var/max_moles = 120

	var/temperature = 0

/datum/composition/New( my_atom = null, chemicals = null, maximum_volume = 120, temperature = 0 )
	..()

	if( !my_atom )
		del( src ) // We can't have a composition without something to compose
	if( !chemicals )
		del( src ) // We can't be a composition if we aren't composed of anything

	if( !temperature )
		temperature = T20C // Might as well make it room temp if there's no other option

/datum/composition/proc/adjTemp( var/heat )
	if( !heat ) return 0

	temperature += calcTemperatureChange( heat )

/datum/composition/proc/addChemical( var/chemical, var/moles )
	if( !chemical ) return 0
	if( moles <= 0 ) return 0

	moles = calcMolesAdded( moles )

	if( chemical in chemicals ) // If it exists, plop it on into the existing ammount
		chemicals[chemical] += moles
	else
		chemicals[chemical] = moles

	return moles


/datum/composition/proc/adjChemical( var/chemical, var/moles )
	if( !chemical ) return 0

	moles = calcMolesAdded( moles )

	if( moles == 0 ) return 0

	if( chemical in chemicals )

		if( new_chem_moles <= 0 )
			chemicals.Remove( chemical )
			return ( moles+new_chem_moles ) // Returning the ammount that was left
		else
			chemicals[chemical] = new_chem_moles
			return moles
	else
		return // If the chemical didn't exist, you are a fool for even trying

/datum/composition/proc/updateTotalMoles()
	if( !chemicals ) return 0

	total_moles = 0

	for( var/chemical in chemicals )
		total_moles += chemicals[chemical]

	return total_moles

/datum/composition/proc/calcTemperatureChange( var/heat )
	if( !chemicals_list ) return 0
	if( !chemicals ) return 0

	var/temp_change = 0

	for( var/chemical in chemicals )
		if( chemical in chemicals_list )
			var/datum/chemical/C = chemicals[chemical]
			temp_change += C.calcTemp( heat, chemicals[chemical] )

	if( chemicals.len )
		temp_change = temp_change/chemicals.len

	return temp_change

// Used to calculate moles added, but doesn't actually add anything
/datum/composition/proc/calcMolesAdded( var/moles )
	if( moles == 0 ) return 0

	if( moles+total_moles > max_moles )
		moles = ( moles+total_moles )-max_moles
	else if( moles+total_moles < 0 )
		moles = total_moles-( moles-total_moles )

	return moles