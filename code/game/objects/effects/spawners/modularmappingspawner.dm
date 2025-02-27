/obj/effect/spawner/modularmap
	name = "Modular map marker"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "random_map"
	dir = NORTH
	///The ID of the types we would like to be choosing from
	var/mapid
	///How high our spawner area is, used to catch mistakes in mapping
	var/spawner_height = 0
	///How wide our spawner area is, used to catch mistakes in mapping
	var/spawner_width = 0

/obj/effect/spawner/modularmap/Initialize(mapload)
	. = ..()
	SSmodularmapping.markers += src

///Actually loads the modularmap: called by SSmodularmapping
/obj/effect/spawner/modularmap/proc/load_modularmap()
	var/datum/map_template/modular/template
	template = pick(SSmapping.modular_templates[mapid])
	var/errored = FALSE
	if(!istype(template, /datum/map_template/modular))
		stack_trace("A spawner has an invalid template")
		errored = TRUE
	if(spawner_height != template.template_height)
		stack_trace("A spawner has an invalid height")
		errored = TRUE
	if(spawner_width != template.template_width)
		stack_trace("A spawner has an invalid width")
		errored = TRUE
	if(errored)
		return
	if(!template)
		stack_trace("Mapping error: room loaded with no template")
		message_admins("Warning, modular mapping error, please report this to coders and get it fixed ASAP")
		qdel(src)
		return
	var/turf/loadloc = get_turf(src)
	qdel(src)
	template.load(loadloc, template.keepcentered)

////	Types:
//	San Francisco sewers
/obj/effect/spawner/modularmap/sanfrancisco/sewernortheast1
	mapid = "sewersnortheast1"
	spawner_width = 14
	spawner_height = 17
