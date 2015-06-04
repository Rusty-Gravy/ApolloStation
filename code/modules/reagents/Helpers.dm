/hook/startup/proc/generate_chemical_lists()
			//I dislike having these here but map-objects are initialised before world/New() is called. >_>
			if(!chemicals_list)
				//Chemicals - Initialises all /datum/chemical into a list indexed by reagent id
				var/paths = typesof(/datum/chemical) - /datum/chemical
				chemicals_list = list()
				for(var/path in paths)
					var/datum/chemical/C = new path()
					chemicals_list[C.id] = C
			if(!chemical_reactions_list)
				//Chemical Reactions - Initialises all /datum/chemical_reaction into a list
				// It is filtered into multiple lists within a list.
				// For example:
				// chemical_reaction_list["phoron"] is a list of all reactions relating to phoron

				var/paths = typesof(/datum/chemical_reaction) - /datum/chemical_reaction
				chemical_reactions_list = list()

				for(var/path in paths)

					var/datum/chemical_reaction/D = new path()
					var/list/reaction_ids = list()

					if(D.required_reagents && D.required_reagents.len)
						for(var/reaction in D.required_reagents)
							reaction_ids += reaction

					// Create filters based on each reagent id in the required reagents list
					for(var/id in reaction_ids)
						if(!chemical_reactions_list[id])
							chemical_reactions_list[id] = list()
						chemical_reactions_list[id] += D
						break // Don't bother adding ourselves to other reagent ids, it is redundant.

/proc/mix_color_from_chemicals(var/list/chemical_list)
	if(!chemical_list || !length(chemical_list))
		return 0

	var/contents = length(chemical_list)
	var/list/weight = new /list(contents)
	var/list/redcolor = new /list(contents)
	var/list/greencolor = new /list(contents)
	var/list/bluecolor = new /list(contents)
	var/i

	//fill the list of weights
	for(i=1; i<=contents; i++)
		var/datum/chemical/re = chemical_list[i]
		var/chemicalweight = re.volume
		if(istype(re, /datum/chemical/paint))
			chemicalweight *= 20 //Paint colours a mixture twenty times as much
		weight[i] = chemicalweight


	//fill the lists of colours
	for(i=1; i<=contents; i++)
		var/datum/chemical/re = chemical_list[i]
		var/hue = re.color
		if(length(hue) != 7)
			return 0
		redcolor[i]=hex2num(copytext(hue,2,4))
		greencolor[i]=hex2num(copytext(hue,4,6))
		bluecolor[i]=hex2num(copytext(hue,6,8))

	//mix all the colors
	var/red = mixOneColor(weight,redcolor)
	var/green = mixOneColor(weight,greencolor)
	var/blue = mixOneColor(weight,bluecolor)

	//assemble all the pieces
	var/finalcolor = rgb(red, green, blue)
	return finalcolor

/proc/mixOneColor(var/list/weight, var/list/color)
	if (!weight || !color || length(weight)!=length(color))
		return 0

	var/contents = length(weight)
	var/i

	//normalize weights
	var/listsum = 0
	for(i=1; i<=contents; i++)
		listsum += weight[i]
	for(i=1; i<=contents; i++)
		weight[i] /= listsum

	//mix them
	var/mixedcolor = 0
	for(i=1; i<=contents; i++)
		mixedcolor += weight[i]*color[i]
	mixedcolor = round(mixedcolor)

	mixedcolor=min(max(mixedcolor,0),255)

	return mixedcolor
