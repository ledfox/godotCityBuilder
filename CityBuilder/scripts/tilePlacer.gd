extends TileMap

const Building = preload("res://scripts/buildings/building.gd") # Relative path
onready var buildOptions = get_tree().get_root().get_node("Main/CanvasLayer/Build Button/Build Window/Build Options")
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
	print("map dimensions: ", map_edges)

func initialize_grid():
	#get used cells into an array (not real world pos)
	#get cell world pos, centralize it and append to grid array
	for pos in get_used_cells():
		var tile_name = tileset.tile_get_name(get_cell(pos.x,pos.y))
		var global_pos = map_to_world(pos) + halfTileSize
		grid[global_pos] = {"base": tile_name, "build": null}

func add_build_object_at(pos, object):
	grid[pos]["build"] = object

func is_unbuilt(pos):
	return grid[pos]["build"] == null

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

func get_snapped_mouse_pos():
	return snap_to_tile(get_global_mouse_pos())


func _input(event):
	var selected = buildOptions.get_selected_name()
	if selected != null and hover["object"] == null: # event.is_action_pressed("mouse_act_right"):
		var held_building = Building.new()
		held_building.init(selected)
		held_building.set_pos(get_snapped_mouse_pos())
		held_building.set_opacity(0.5)
		get_viewport().add_child(held_building)
		hover["object"] = held_building
		get_tile_at(get_snapped_mouse_pos())
		selector.set_pos(get_snapped_mouse_pos())
		selector.show()
	
	if hover["object"] != null:
		hover["object"].set_pos(get_snapped_mouse_pos())
		selector.set_pos(get_snapped_mouse_pos())
		selector.be_green(
			hover["object"].can_build_on(
			get_tile_at(get_snapped_mouse_pos()))
			and 
			is_unbuilt(get_snapped_mouse_pos())
		)
		
	if hover["object"] != null and event.is_action_pressed("mouse_act_left"):
		if hover["object"].can_build_on(get_tile_at(get_snapped_mouse_pos())) and is_unbuilt(get_snapped_mouse_pos()):
			hover["object"].build()
			add_build_object_at(get_snapped_mouse_pos(), hover["object"])
			
		else:
			hover["object"].queue_free() #destory sprite
		hover["object"] = null
		selector.hide()
		buildOptions.clear_selection()
	
	if event.is_action_pressed("mouse_act_right"):
		if hover["object"] != null:
			hover["object"].hide()
		hover["object"] = null
		selector.hide()
		buildOptions.clear_selection()
	
	

	
	
