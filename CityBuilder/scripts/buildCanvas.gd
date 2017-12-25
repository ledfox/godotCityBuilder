extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
#onready var economy = get_child("EconomyButton") #get_tree().get_root().get_node("Main/CanvasLayer/EconomyButton")
const House = preload("res://scripts/housing.gd") # Relative path
const Road = preload("res://scripts/road.gd") # Relative path
const Industry = preload("res://scripts/industry.gd") # Relative path
var conf_file = ConfigFile.new()
onready var err = conf_file.load("res://resources/buildingVars.cfg")

func get_conf(buildId):
	var conf = {}
	print(err)
	print(conf_file.get_sections())
	for key in conf_file.get_section_keys(buildId):
		conf[key] = conf_file.get_value(buildId, key)
	print(buildId)
	print(conf)
	conf["texture"] = load(conf["image_file"])
	conf["scale"] = Vector2(conf["size"]["x"], conf["size"]["y"])
	return conf

func get_new_building(buildId):
	var new_building
	var conf = get_conf(buildId)
	if conf["category"] == "road":
		new_building =  Road.new()
	elif conf["category"] == "housing":
		new_building =  House.new()
	else:
		new_building =  Industry.new()
		
	new_building.init(get_conf(buildId))
	get_viewport().add_child(new_building)
	if new_building.can_afford_to_build():
		return new_building
	else:
		print("You don't have the resources to build " + new_building.conf["name"])
		print(new_building.conf["resource_req"])
		return null

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
