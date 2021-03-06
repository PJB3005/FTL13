/*
Chief Engineer
*/
/datum/job/chief_engineer
	title = "Chief Engineer"
	flag = CHIEF
	department_head = list("Captain")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain"
	selection_color = "#ffeeaa"
	req_admin_notify = 1
	minimal_player_age = 7

	outfit = /datum/outfit/job/ce

	access = list(access_engine, access_engine_equip, access_literal_engine, access_maint_tunnels, access_external_airlocks, access_atmospherics,
			            access_heads, access_sec_doors, access_ce, access_RC_announce, access_tcomms, access_helm, access_waste, access_ai_chamber)
	minimal_access = list(access_engine, access_engine_equip, access_literal_engine, access_maint_tunnels, access_external_airlocks, access_atmospherics,
			            access_heads, access_sec_doors, access_ce, access_RC_announce, access_tcomms, access_helm, access_waste, access_ai_chamber)

/datum/outfit/job/ce
	name = "Chief Engineer"

	id = /obj/item/weapon/card/id/silver
	belt = /obj/item/weapon/storage/belt/utility/full
	l_pocket = /obj/item/device/pda/heads/ce
	ears = /obj/item/device/radio/headset/heads/ce
	uniform = /obj/item/clothing/under/rank/chief_engineer
	shoes = /obj/item/clothing/shoes/sneakers/brown
	head = /obj/item/clothing/head/hardhat/white
	gloves = /obj/item/clothing/gloves/color/black/ce
	backpack_contents = list(/obj/item/weapon/melee/classic_baton/telescopic=1)

	backpack = /obj/item/weapon/storage/backpack/industrial
	satchel = /obj/item/weapon/storage/backpack/satchel_eng
	dufflebag = /obj/item/weapon/storage/backpack/dufflebag/engineering
	box = /obj/item/weapon/storage/box/engineer
	pda_slot = slot_l_store

/datum/outfit/job/ce/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()

	if(visualsOnly)
		return

	announce_head(H, list("Engineering"))

/*
Ship Engineer
*/
/datum/job/engineer
	title = "Ship Engineer"
	flag = ENGINEER
	department_head = list("Chief Engineer")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 5
	spawn_positions = 5
	supervisors = "the chief engineer"
	alt_titles = list("Maintenance Technician","Engine Technician","Electrician","Repair Specialist", "Architect", "Propulsion Engineer")
	selection_color = "#fff5cc"

	outfit = /datum/outfit/job/engineer

	access = list(access_engine, access_engine_equip, access_literal_engine, access_maint_tunnels, access_external_airlocks, access_atmospherics, access_waste)
	minimal_access = list(access_engine, access_engine_equip, access_literal_engine, access_maint_tunnels, access_external_airlocks, access_waste)

/datum/outfit/job/engineer
	name = "Ship Engineer"

	belt = /obj/item/weapon/storage/belt/utility/full
	l_pocket = /obj/item/device/pda/engineering
	ears = /obj/item/device/radio/headset/headset_eng
	uniform = /obj/item/clothing/under/rank/engineer
	shoes = /obj/item/clothing/shoes/workboots
	head = /obj/item/clothing/head/hardhat
	r_pocket = /obj/item/device/t_scanner

	backpack = /obj/item/weapon/storage/backpack/industrial
	satchel = /obj/item/weapon/storage/backpack/satchel_eng
	dufflebag = /obj/item/weapon/storage/backpack/dufflebag/engineering
	box = /obj/item/weapon/storage/box/engineer
	pda_slot = slot_l_store

/*
Atmospheric Technician
*/
/datum/job/atmos
	title = "Atmospheric Technician"
	flag = ATMOSTECH
	department_head = list("Chief Engineer")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the chief engineer"
	selection_color = "#fff5cc"
	alt_titles = list("Firefighter", "Plumber")

	outfit = /datum/outfit/job/atmos

	access = list(access_engine, access_engine_equip, access_literal_engine, access_maint_tunnels, access_external_airlocks, access_atmospherics)
	minimal_access = list(access_atmospherics, access_maint_tunnels, access_emergency_storage)

/datum/outfit/job/atmos
	name = "Atmospheric Technician"

	belt = /obj/item/weapon/storage/belt/utility/atmostech
	l_pocket = /obj/item/device/pda/atmos
	ears = /obj/item/device/radio/headset/headset_eng
	uniform = /obj/item/clothing/under/rank/atmospheric_technician
	r_pocket = /obj/item/device/analyzer

	backpack = /obj/item/weapon/storage/backpack/industrial
	satchel = /obj/item/weapon/storage/backpack/satchel_eng
	dufflebag = /obj/item/weapon/storage/backpack/dufflebag/engineering
	box = /obj/item/weapon/storage/box/engineer
	pda_slot = slot_l_store
