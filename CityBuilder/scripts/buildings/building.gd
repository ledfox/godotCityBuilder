extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var is_road_adj = false
var tileset = load("res://resources/land_tiles.tres")
onready var money = get_tree().get_root().get_node("Main/CanvasLayer/Money Value")
var name
var build_cost = 10

var config = {}

var house = {
	"name": "house",
	"texture": preload("res://resources/buildings/House3.png"),
	"offset": Vector2(0, 6),
	"build_cost": 10,
	"buildable_tiles": ["grass"]
}

var mill = {
	"name": "mill",
	"texture": preload("res://resources/buildings/Mill.png"),
	"build_cost": 100,
	"buildable_tiles": ["grass"]
}


var all_configs = [house]
var config_lkp = compile_config_lkp()

var buildable_tiles = ["grass"]

func compile_config_lkp():
	var lkp = {}
	for each in all_configs:
		lkp[each["name"]] = each
	return lkp
	
	
	
func can_build_on(tile_name):
	return tile_name in config["buildable_tiles"]
	
func init(name):
	config = config_lkp[name]
	set_texture(config["texture"])
	if "offset" in config.keys():
		set_offset(config["offset"])
	if "scale" in config.keys():
		set_scale(config["scale"])
	
func build():
	set_opacity(1)
	money.add_gold(-config["build_cost"])
	

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)

	
func _process(delta):
	pass
	

