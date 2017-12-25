extends Sprite

var is_road_adj = false
onready var economy = get_tree().get_root().get_node("Main/CanvasLayer/EconomyButton")
#var name
#var build_cost = 10

#var conf_file = ConfigFile.new()
#onready var err = conf_file.load("res://resources/buildingVars.cfg")
var conf = {}
var tile_size = 32
var pos_offset = null
var is_built = false
var my_selector = null
var requiredBuildTiles = []


#func set_conf(buildId):
#	print(err)
#	print(conf_file.get_sections())
#	for key in conf_file.get_section_keys(buildId):
#		conf[key] = conf_file.get_value(buildId, key)
#	print(buildId)
#	print(conf)
#	conf["texture"] = load(conf["image_file"])


func can_build_on(tile_names):
	for name in tile_names:
		if not (name in conf["buildable_tiles"]):
			return false

	for required in requiredBuildTiles:
		if not (required in tile_names):
			return false

	return true


func get_corners():
	var pos = get_pos()
	# the offsets of 1 to make the search square slightly smaller than a square
	# So they're all within the tile
	var half_x = (conf["size"]["x"]/2) -1
	var half_y = (conf["size"]["y"]/2) - 1

	var top_right = Vector2(pos.x - half_x, pos.y + half_y) 
	var bottom_right = Vector2(pos.x - half_x, pos.y - half_y) 
	var top_left = Vector2(pos.x + half_x, pos.y + half_y) 
	var bottom_left = Vector2(pos.x + half_x, pos.y - half_y) 
	return [bottom_right, top_right, bottom_left, top_left]
	
func can_afford_to_build():
	var eco = economy.get_values()
	for key in conf["resource_req"].keys():
		if eco[key] < conf["resource_req"][key]:
			return false
	return true

func process_buildable_tiles():
	var updated_buildable_tiles = conf["buildable_tiles"]
	for tile in conf["buildable_tiles"]:
		if tile.ends_with("Required"):
			updated_buildable_tiles.erase(tile)
			var base_name = tile.replace("Required", "")
			updated_buildable_tiles.append(base_name)
			requiredBuildTiles.append(base_name)

	conf["buildable_tiles"] = updated_buildable_tiles
		
	
func get_pos_offset():
	if pos_offset == null:
		var x_offset = (conf["size"]["x"] - tile_size)/2 ;
		var y_offset = (conf["size"]["y"] - tile_size)/2 ;
		pos_offset = Vector2(x_offset, y_offset)
	return pos_offset;

func custom_set_pos(pos):
	set_pos(pos - get_pos_offset())
	if my_selector != null:
		my_selector.set_pos(pos - get_pos_offset())
	
func init(start_conf):
	conf = start_conf
	set_texture(conf["texture"])
	if "offset" in conf.keys():
		set_offset(Vector2(conf["offset"]["x"], conf["offset"]["y"]))
	process_buildable_tiles()

func attatch_selector(sel):
	my_selector = sel
	my_selector.custom_set_scale(conf["scale"])
	my_selector.show()
	
func dettatch_selector():
	if my_selector != null:
		my_selector.hide()
		my_selector = null
	
func kill():
	dettatch_selector()
	hide()
	queue_free()
		
func build():
	set_opacity(1)
	dettatch_selector()
	for key in conf["produces"]:
		economy.add_value(key, conf["produces"][key])
	economy.add_value("money", -conf["build_cost"])
	is_built = true
	
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_centered(true)
	set_process(true)
	var timer = get_tree().get_root().get_node("Main/Timer")
	timer.connect("timeout", self, "on_turn")

func _process(delta):
	pass
	
func on_turn():
	pass

