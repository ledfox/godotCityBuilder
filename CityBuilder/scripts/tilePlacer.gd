extends TileMap

const Building = preload("res://scripts/buildings/building.gd") # Relative path

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var grid = {}
var map_edges = {"x":{"max":0, "min":0}, "y":{"max":0, "min":0}}
var color = Color(.5,0,.5)
var line = 3
var halfTileSize = Vector2(16, 16)
var tileset = load("res://resources/land_tiles.tres")

var hover = {"object":null, "highlight":null}

func get_tile_at(pos):
	var tile_pos = world_to_map(pos)
	if grid.has(tile_pos):
		return grid[tile_pos]
	else:
		return ""

func change_tile_at(pos, newValue):
	grid[snap_to_tile(pos)] = newValue

	 
func find_edges():
	map_edges["x"]["min"] = 0
	map_edges["y"]["min"] = 0
	for pos in grid.keys():
		if pos.x > map_edges["x"]["max"]:
			map_edges["x"]["max"] = pos.x 
		if pos.y > map_edges["y"]["max"]:
			map_edges["y"]["max"] = pos.y
	get_child(0).set("map_edges", map_edges) 
	map_edges["x"]["max"] = map_to_world(Vector2(map_edges["x"]["max"], 0)).x
	map_edges["y"]["max"] = map_to_world(Vector2(0, map_edges["y"]["max"])).y
	print(map_edges)

func initialize_grid():
	#get used cells into an array (not real world pos)
	#get cell world pos, centralize it and append to grid array
	for pos in get_used_cells():
		var tile_name = tileset.tile_get_name(get_cell(pos.x,pos.y))
		grid[pos] = tile_name
	

func new_building_at(name, pos, alpha=1):
	var building = Sprite.new()
	var scale = Vector2(0.5, 0.5)
	var texture = get_tile_texture(name)
	building.set_texture(texture)
	building.set_pos(pos)
	building.set_scale(scale)
	building.set_opacity(alpha)
	get_viewport().call_deferred("add_child", building)
	return building

func get_tile_texture(name):
	var index = tileset.find_tile_by_name(name)
	return tileset.tile_get_texture(index)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	set_process(true) #player interactions
	set_process_input(true) #also player interactions
	initialize_grid()
	find_edges()

func _process(delta):
	pass
	
func snap_to_tile(pos):
	return map_to_world(world_to_map(pos)) + halfTileSize #half a tile size

func _input(event):
	if event.is_action_pressed("mouse_act_right"):
		var held_building = Building.new()
		held_building.init("house", get_global_mouse_pos())
		held_building.set_opacity(0.5)
		get_viewport().add_child(held_building)
		hover["object"] = held_building
	
	if hover["object"] != null:
		hover["object"].set_pos(snap_to_tile(get_global_mouse_pos()))
		get_tile_at(get_global_mouse_pos())
	if hover["object"] != null and event.is_action_released("mouse_act_right"):
		hover["object"].set_opacity(1)
		hover["object"] = null
	
	if event.is_action_pressed("mouse_act_left"):
		if hover["object"] != null:
			hover["object"].hide()
		hover["object"] = null
	

	
	
