/obj/random
	name = "random object"
	desc = "This item type is used to spawn random objects at round-start"
	icon = 'icons/misc/mark.dmi'
	icon_state = "rup"
	var/spawn_nothing_percentage = 0 // this variable determines the likelyhood that this random object will not spawn anything


// creates a new object and deletes itself
/obj/random/New()
	..()
	if (!prob(spawn_nothing_percentage))
		spawn_item()
	del src


// this function should return a specific item to spawn
/obj/random/proc/item_to_spawn()
	return 0


// creates the random item
/obj/random/proc/spawn_item()
	var/build_path = item_to_spawn()
	return (new build_path(src.loc))


/obj/random/tool
	name = "random tool"
	desc = "This is a random tool"
	icon = 'icons/obj/items.dmi'
	icon_state = "welder"
	item_to_spawn()
		return pick(/obj/item/weapon/screwdriver,\
					/obj/item/weapon/wirecutters,\
					/obj/item/weapon/weldingtool,\
					/obj/item/weapon/crowbar,\
					/obj/item/weapon/wrench,\
					/obj/item/device/flashlight)


/obj/random/technology_scanner
	name = "random scanner"
	desc = "This is a random technology scanner."
	icon = 'icons/obj/device.dmi'
	icon_state = "atmos"
	item_to_spawn()
		return pick(prob(5);/obj/item/device/t_scanner,\
					prob(2);/obj/item/device/radio,\
					prob(5);/obj/item/device/analyzer)


/obj/random/powercell
	name = "random powercell"
	desc = "This is a random powercell."
	icon = 'icons/obj/power.dmi'
	icon_state = "cell"
	item_to_spawn()
		return pick(prob(10);/obj/item/weapon/cell/crap,\
					prob(40);/obj/item/weapon/cell,\
					prob(40);/obj/item/weapon/cell/high,\
					prob(9);/obj/item/weapon/cell/super,\
					prob(1);/obj/item/weapon/cell/hyper)


/obj/random/bomb_supply
	name = "bomb supply"
	desc = "This is a random bomb supply."
	icon = 'icons/obj/assemblies/new_assemblies.dmi'
	icon_state = "signaller"
	item_to_spawn()
		return pick(/obj/item/device/assembly/igniter,\
					/obj/item/device/assembly/prox_sensor,\
					/obj/item/device/assembly/signaler,\
					/obj/item/device/multitool)


/obj/random/toolbox
	name = "random toolbox"
	desc = "This is a random toolbox."
	icon = 'icons/obj/storage.dmi'
	icon_state = "red"
	item_to_spawn()
		return pick(prob(3);/obj/item/weapon/storage/toolbox/mechanical,\
					prob(2);/obj/item/weapon/storage/toolbox/electrical,\
					prob(1);/obj/item/weapon/storage/toolbox/emergency)


/obj/random/tech_supply
	name = "random tech supply"
	desc = "This is a random piece of technology supplies."
	icon = 'icons/obj/power.dmi'
	icon_state = "cell"
	spawn_nothing_percentage = 50
	item_to_spawn()
		return pick(prob(3);/obj/random/powercell,\
					prob(2);/obj/random/technology_scanner,\
					prob(1);/obj/item/weapon/packageWrap,\
					prob(2);/obj/random/bomb_supply,\
					prob(1);/obj/item/weapon/extinguisher,\
					prob(1);/obj/item/clothing/gloves/fyellow,\
					prob(3);/obj/item/stack/cable_coil,\
					prob(2);/obj/random/toolbox,\
					prob(2);/obj/item/weapon/storage/belt/utility,\
					prob(5);/obj/random/tool,\
					prob(2);/obj/item/weapon/tape_roll)

/obj/random/gun
	name = "random gun"
	desc = "This is a random gun."
	icon = 'icons/obj/power.dmi'
	icon_state = "cell"
	spawn_nothing_percentage = 0
	item_to_spawn()
		return pick( /obj/item/weapon/gun/projectile/shotgun/pump/combat,
					 /obj/item/weapon/gun/projectile/shotgun/pump,
					 /obj/item/weapon/gun/projectile/shotgun/doublebarrel,
					 /obj/item/weapon/gun/projectile/shotgun,
					 /obj/item/weapon/gun/projectile/mateba,
					 /obj/item/weapon/gun/projectile/russian,
					 /obj/item/weapon/gun/projectile/pistol,
					 /obj/item/weapon/gun/projectile/deagle,
					 /obj/item/weapon/gun/projectile/deagle/gold,
					 /obj/item/weapon/gun/projectile/silenced,
					 /obj/item/weapon/gun/projectile/automatic/l6_saw,
					 /obj/item/weapon/gun/projectile/automatic/c20r,
					 /obj/item/weapon/gun/projectile/automatic/mini_uzi,
					 /obj/item/weapon/gun/projectile/automatic,
					 /obj/item/weapon/gun/projectile/detective,
					 /obj/item/weapon/gun/projectile/detective/semiauto,
					 /obj/item/weapon/gun/projectile/detective/fluff/callum_leamas,
					 /obj/item/weapon/gun/energy/sniperrifle,
					 /obj/item/weapon/gun/energy/temperature,
					 /obj/item/weapon/gun/energy/toxgun,
					 /obj/item/weapon/gun/energy/mindflayer,
					 /obj/item/weapon/gun/energy/floragun,
					 /obj/item/weapon/gun/energy/decloner,
					 /obj/item/weapon/gun/energy/ionrifle,
					 /obj/item/weapon/gun/energy/pulse_rifle,
					 /obj/item/weapon/gun/energy/pulse_rifle/M1911,
					 /obj/item/weapon/gun/energy/pulse_rifle/destroyer,
					 /obj/item/weapon/gun/energy/xray,
					 /obj/item/weapon/gun/energy/laser,
					 /obj/item/weapon/gun/energy/laser/retro,
					 /obj/item/weapon/gun/energy/taser,
					 /obj/item/weapon/gun/energy/gun,
					 /obj/item/weapon/gun/energy/gun/nuclear,
					 /obj/item/weapon/gun/energy/lasercannon,
					  )
