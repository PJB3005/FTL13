/obj/item/station_charter
	name = "station charter"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "scroll2"
	desc = "An official document entrusting the governance of the ship \
		and the area within its shield boundaries to the Captain."
	var/used = FALSE

	var/unlimited_uses = FALSE
	var/ignores_timeout = FALSE
	var/response_timer_id = null
	var/approval_time = 600

	var/static/regex/standard_station_regex

/obj/item/station_charter/New()
	. = ..()
	if(!standard_station_regex)
		var/prefixes = jointext(station_prefixes, "|")
		var/names = jointext(station_names, "|")
		var/suffixes = jointext(station_suffixes, "|")
		var/numerals = jointext(station_numerals, "|")
		var/regexstr = "(([prefixes]) )?(([names]) ?)([suffixes]) ([numerals])"
		standard_station_regex = new(regexstr)

/obj/item/station_charter/Destroy()
	if(response_timer_id)
		deltimer(response_timer_id)
	response_timer_id = null
	. = ..()

/obj/item/station_charter/attack_self(mob/living/user)
	if(used)
		user << "This charter has already been used to name the ship."
		return
	if(!ignores_timeout && (world.time-round_start_time > CHALLENGE_TIME_LIMIT)) //5 minutes
		user << "The crew has already settled into the shift. \
			It probably wouldn't be good to rename the ship right now."
		return
	if(response_timer_id)
		user << "You're still waiting for approval from your employers about \
			your proposed name change, it'd be best to wait for now."
		return

	var/new_name = stripped_input(user, message="What do you want to name \
		[station_name()]? Keep in mind particularly terrible names may be \
		rejected by your employers, while names using the standard format, \
		will automatically be accepted.", max_length=MAX_CHARTER_LEN)

	if(!new_name)
		return
	log_game("[key_name(user)] has proposed to name the ship as \
		[new_name]")

	if(standard_station_regex.Find(new_name))
		user << "Your name has been automatically approved."
		rename_station(new_name, user)
		return

	user << "Your name has been sent to your employers for approval."
	// Autoapproves after a certain time
	response_timer_id = addtimer(src, "rename_station", approval_time, \
		FALSE, new_name, user)
	admins << "<span class='adminnotice'><b><font color=orange>CUSTOM SHIP RENAME:</font></b>[key_name_admin(user)] (<A HREF='?_src_=holder;adminmoreinfo=\ref[user]'>?</A>) proposes to rename the ship to [new_name] (will autoapprove in [approval_time / 10] seconds). (<A HREF='?_src_=holder;BlueSpaceArtillery=\ref[user]'>BSA</A>) (<A HREF='?_src_=holder;reject_custom_name=\ref[src]'>REJECT</A>)</span>"

/obj/item/station_charter/proc/reject_proposed(user)
	if(!user)
		return
	if(!response_timer_id)
		return
	var/turf/T = get_turf(src)
	T.visible_message("<span class='warning'>The proposed changes disappear \
		from [src]; it looks like they've been rejected.</span>")
	var/m = "[key_name(user)] has rejected the proposed ship name."

	message_admins(m)
	log_admin(m)

	deltimer(response_timer_id)
	response_timer_id = null

/obj/item/station_charter/proc/rename_station(designation, mob/user)
	world.name = designation
	station_name = designation
	minor_announce("[user.real_name] has designated your ship as [world.name]", "Captain's Charter", 0)
	log_game("[key_name(user)] has renamed the ship as [world.name]")

	name = "ship charter for [world.name]"
	desc = "An official document entrusting the governance of \
		[world.name] and the area within its shield boundaries to Captain [user]."

	if(!unlimited_uses)
		used = TRUE
