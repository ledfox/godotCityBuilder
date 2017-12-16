extends Sprite

var is_road_adj = false
onready var economy = get_tree().get_root().get_node("Main/CanvasLayer/EconomyButton")
var name
var build_cost = 10

var conf_file = ConfigFile.new()
var err = conf_file.load("res://resources/buildingVars.cfg")
var conf = {}

func set_conf(name):
	for key in conf_file.get_section_keys(name):
		conf[key] = conf_file.get_value(name, key)
	conf["name"] = name
	conf["texture"] = load(conf["image_file"])

func can_build_on(tile_name):
	return tile_name in conf["buildable_tiles"]
	
func init(name):
	set_conf(name)
	set_texture(conf["texture"])
	if "offset" in conf.keys():
		set_offset(Vector2(conf["offset"]["x"], conf["offset"]["y"]))
	
func build():
	set_opacity(1)
	for key in conf["produces"]:
		economy.add_value(key, conf["produces"][key])
	economy.add_value("money", -conf["build_cost"])
	
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_centered(true)
	set_process(true)

func _process(delta):
	pass
	

