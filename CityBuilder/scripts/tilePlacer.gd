extends TileMap

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var color = Color(.5,0,.5)
var line = 3

var held_object = []

func new_building_at(name, pos, alpha=1):
	var building = Sprite.new()
	var scale = Vector2(0.5, 0.5)
	var texture = get_tile_texture(name)
	building.set_texture(texture)
	building.set_pos(pos)
	building.set_scale(scale)
	get_viewport().call_deferred("add_child", building)
	return building

func get_tile_texture(name):
	var tileset = load("res://resources/land_tiles.tres")
	var index = tileset.find_tile_by_name(name)
	print(tileset.tile_get_name(index))
	return tileset.tile_get_texture(index)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true) #player interactions
	set_process_input(true) #also player interactions
	pass

func _process(delta):
	pass

func snap_to_tile(pos):
	return map_to_world(world_to_map(pos)) + Vector2(16, 16) #half a tile size

func _input(event):
	if event.is_action_pressed("mouse_act_right"):
		held_object.append(new_building_at("house_trans", get_global_mouse_pos()))
	
	if held_object.size() > 0:
		held_object[0].set_pos(snap_to_tile(get_global_mouse_pos()))
	if event.is_action_released("mouse_act_right"):
		held_object = []
	
	pass
	
	
