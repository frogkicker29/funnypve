/atom/movable/screen/ghost
	icon = 'icons/mob/screen_ghost.dmi'

/atom/movable/screen/ghost/MouseEntered()
	flick(icon_state + "_anim", src)

/atom/movable/screen/attack_ghost(mob/dead/observer/user)
	Click()

/atom/movable/screen/ghost/follow_ghosts
	name = "Follow"
	icon_state = "follow_ghost"

/atom/movable/screen/ghost/follow_ghosts/Click()
	var/mob/dead/observer/G = usr
	G.follow()

// /atom/movable/screen/ghost/follow_xeno
// name = "Follow Xeno"
// icon_state = "follow_xeno"

// /atom/movable/screen/ghost/follow_xeno/Click()
// var/mob/dead/observer/G = usr
// G.follow_xeno()

// /atom/movable/screen/ghost/follow_human
// name = "Follow Humans"
// icon_state = "follow_human"

// /atom/movable/screen/ghost/follow_human/Click()
// var/mob/dead/observer/G = usr
// G.follow_human()

/atom/movable/screen/ghost/reenter_corpse
	name = "Reenter corpse"
	icon_state = "reenter_corpse"

/atom/movable/screen/ghost/reenter_corpse/Click()
	var/mob/dead/observer/G = usr
	G.reenter_corpse()

/atom/movable/screen/ghost/toggle_huds
	name = "Toggle HUDs"
	icon_state = "ghost_hud_toggle"

/atom/movable/screen/ghost/toggle_huds/Click()
	var/client/client = usr.client
	client.toggle_ghost_hud()

/datum/hud/ghost/New(mob/owner, ui_style='icons/mob/hud/human_white.dmi', ui_color, ui_alpha = 230)
	. = ..()
	var/atom/movable/screen/using

	using = new /atom/movable/screen/ghost/follow_ghosts()
	using.screen_loc = ui_ghost_slot2
	static_inventory += using

	// using = new /atom/movable/screen/ghost/follow_human()
	// using.screen_loc = ui_ghost_slot3
	// static_inventory += using

	using = new /atom/movable/screen/ghost/reenter_corpse()
	using.screen_loc = ui_ghost_slot3
	static_inventory += using

	using = new /atom/movable/screen/ghost/toggle_huds()
	using.screen_loc = ui_ghost_slot4
	static_inventory += using

/datum/hud/ghost/show_hud(version = 0, mob/viewmob)
	// don't show this HUD if observing; show the HUD of the observee
	var/mob/dead/observer/O = mymob
	if (istype(O) && O.observe_target_mob)
		plane_masters_update()
		return FALSE

	. = ..()
	if(!.)
		return
	var/mob/screenmob = viewmob || mymob

	if(!hud_shown)
		screenmob.client.remove_from_screen(static_inventory)
	else
		screenmob.client.add_to_screen(static_inventory)
