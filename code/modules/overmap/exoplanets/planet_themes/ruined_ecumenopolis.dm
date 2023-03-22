/datum/exoplanet_theme/ruined_city/ecumenopolis
	name = "Ruined City"
	ruin_tags_whitelist = RUIN_RAINWORLD
	sub_themes = list()

/datum/exoplanet_theme/ruined_city/ecumenopolis/before_map_generation(obj/effect/overmap/visitable/sector/exoplanet/E)
	E.ruin_tags_whitelist |= RUIN_ALIEN
	for (var/zlevel in E.map_z)
		new /datum/random_map/city/ecumenopolis(null,1,1,zlevel,E.maxx,E.maxy,0,1,1, E.planetary_area)

/datum/random_map/city/ecumenopolis
	descriptor = "ruined city"
	building_types = list(
		/datum/random_map/maze/concrete/ecumenopolis = 100,
		)
	max_building_size = 11	//Size of buildings in tiles. Must be odd number for building generation to work properly.
	buildings_number = 8	//Buildings per block
	list/blocks_x = list(TRANSITIONEDGE + 1)	//coordinates for start of blocs
	list/blocks_y = list(TRANSITIONEDGE + 1)

/datum/random_map/city/ecumenopolis/generate_map()
	var/block_size = buildings_number * max_building_size + 2
	var/num_blocks_x = round((limit_x - 2*TRANSITIONEDGE)/block_size)
	var/num_blocks_y = round((limit_y - 2*TRANSITIONEDGE)/block_size)

	//Get blocks borders coordinates
	for (var/i = 1 to num_blocks_x)
		blocks_x += blocks_x[i] + block_size + 1
	for (var/i = 1 to num_blocks_y)
		blocks_y += blocks_x[i] + block_size + 1
	blocks_x += limit_x - TRANSITIONEDGE - 1
	blocks_y += limit_y - TRANSITIONEDGE - 1

	//Place buildings
	for (var/i = 1 to blocks_x.len - 1)
		for (var/j = 1 to blocks_y.len - 1)
			for (var/k = 0 to buildings_number - 1)
				for (var/l = 0 to buildings_number - 1)
					var/building_x = blocks_x[i] + 2 + max_building_size * k
					var/building_y = blocks_y[j] + 2 + max_building_size * l
					var/building_size_x = pick(7,9,9,11,11,11)
					var/building_size_y = pick(7,9,9,11,11,11)
					if (building_x + building_size_x >= limit_x - TRANSITIONEDGE)
						continue
					if (building_y + building_size_y >= limit_y - TRANSITIONEDGE)
						continue
					var/building_type = pickweight(building_types)
					var/datum/random_map/building = new building_type(null, building_x, building_y, origin_z, building_size_x, building_size_y, 1, 1, 1, use_area)
					LAZYADD(building_maps, building) // They're applied later to let buildings handle their own shit
	return 1

// Buildings

//Generic ruin
/datum/random_map/maze/concrete/ecumenopolis
	wall_type =  /turf/simulated/wall/containment
	floor_type = /turf/unsimulated/floor/exoplanet/concrete/reinforced
	preserve_map = 0

/datum/random_map/maze/concrete/ecumenopolis/get_appropriate_path(var/value)
	if (value == WALL_VALUE)
		if (prob(80))
			return /turf/simulated/wall/containment/rainworld
		else
			return /turf/unsimulated/floor/exoplanet/concrete/reinforced
	return ..()

/datum/random_map/maze/concrete/ecumenopolis/get_additional_spawns(value, turf/floor)
	if (!istype(floor))
		return
	if (prob(1))
		new /obj/structure/rubble/war (floor)
	if (prob(15))
		new /obj/structure/rubble/house (floor)

/turf/simulated/wall/containment/rainworld
	paint_color = COLOR_GRAY40