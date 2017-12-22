extends TileMap

#const Building = preload("res://scripts/buildings/building.gd") # Relative path
onready var buildOptions = get_tree().get_root().get_node("Main/CanvasLayer/Build Button/Build Window/Build Options")
onready var buildCanvas = get_tree().get_root().get_node("Main/CanvasLayer")
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var grid = {}
var held_building = null;
var map_edges = {"x":{"max":0, "min":0}, "y":{"max":0, "min":0}}
var color = Color(.5,0,.5)
var line = 3
var halfTileSize = Vector2(16, 16)
var tileset = load("res://resources/land_tiles.tres")

var outOfTheWay = Vector2(-1000, 1000)

var highlights = {"green":null, "red":null}
onready var selector = get_node("Selector")

func set_up_highlights():
	for each in ["red", "green"]:
		var square = Sprite.new()
		square.set_texture(get_tile_texture(each))
		square.set_pos(outOfTheWay)
		square.hide()
		highlights[each] = square

func get_tile_at(pos):
	if grid.has(pos):
		return grid[pos]["base"]
	else:
		return ""
	 
func get_tiles_at(poses):
	var a_list = []
	for pos in poses:
		a_list.append(get_tile_at(pos))
	return a_list
	
func find_edges():
	map_edges["x"]["min"] = 0
	map_edges["y"]["min"] = 0
	var max_x = 0
	var max_y = 0 
	for pos in grid.keys():
		if pos.x > max_x:
			max_x = pos.x 
		if pos.y > max_y:
			max_y = pos.y
	var maxVector = map_to_world(Vector2(max_x, max_y))
	map_edges["x"]["max"] = maxVector.x
	map_edges["y"]["max"] = maxVector.y
	get_node("MainCamera").set("map_edges", map_edges) 

func initialize_grid():
	#get used cells into an array (not real world pos)
	#get cell world pos, centralize it and append to grid array
	for pos in get_used_cells():
		var tile_name = tileset.tile_get_name(get_cell(pos.x,pos.y))
		var global_pos = map_to_world(pos) + halfTileSize
		grid[global_pos] = {"base": tile_name, "build": null}

func add_build_object_at(object, pos):
	grid[pos]["build"] = object
	
func add_build_object_ats(object, pos_list):
	for pos in pos_list:
		grid[pos]["build"] = object                       

func is_unbuilt(pos):
	return grid[pos]["build"] == null

func are_unbilt(pos_list):
	for pos in pos_list:
		if not is_unbuilt(pos):
			return false 
	return true

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
	set_up_highlights()

func _process(delta):
	pass
	
func snap_to_tile(pos):
	return map_to_world(world_to_map(pos)) + halfTileSize #half a tile size

func snap_to_tiles(pos_list):
	var a_list = []
	for pos in pos_list:
		a_list.append(snap_to_tile(pos))
	return a_list

func get_snapped_mouse_pos():
	return snap_to_tile(get_global_mouse_pos())
	
func can_build(obj):
	var corners = snap_to_tiles(obj.get_corners());
	return obj.can_build_on(get_tiles_at(corners)) and are_unbilt(corners)


func _input(event):
	var selected = buildOptions.get_selected_name()
	if selected != null and held_building == null: # event.is_action_pressed("mouse_act_right"):
		held_building = buildCanvas.get_new_building(selected)
		if held_building == null:
			buildOptions.clear_selection()
		else:
			held_building.custom_set_pos(get_snapped_mouse_pos())
			held_building.set_opacity(0.5)
			held_building.attatch_selector(selector)
	
	if held_building != null:
		held_building.custom_set_pos(get_snapped_mouse_pos())
		selector.be_green(can_build(held_building))
		
	if held_building != null and event.is_action_pressed("mouse_act_left"):
		held_building.dettatch_selector()
		
		if can_build(held_building):
			held_building.build()
			add_build_object_ats(held_building, snap_to_tiles(held_building.get_corners()))
			
		else:
			held_building.queue_free() #destory sprite
		
		held_building = null
		
		buildOptions.clear_selection()
	
	if event.is_action_pressed("mouse_act_right"):
		held_building.dettatch_selector()
		if held_building != null:
			held_building.hide()
		held_building = null
		
		buildOptions.clear_selection()
	
	

	
	
