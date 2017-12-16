extends OptionButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var conf_file = ConfigFile.new()
var err = conf_file.load("res://resources/buildingVars.cfg")

var accepted = false

func config_to_dict(name):
	var conf = {}
	for key in conf_file.get_section_keys(name):
		conf[key] = conf_file.get_value(name, key)
	conf["name"] = name
	conf["texture"] = load(conf["image_file"])
	return conf

func load_all_conf():
	var conf_list = []
	for section in conf_file.get_sections():
		conf_list.append(config_to_dict(section))
	return my_sort(conf_list)

func my_sort(a_list):
	var len = a_list.size()
	var sorted_list = []
	var count = 0
	while count <= len:
		for each in a_list:
			if each["menu_order"] == count:
				sorted_list.append(each)
		count = count + 1
	return sorted_list

func get_selected_name():
	if accepted:
		return get_item_text(get_selected ())
	else:
		return null

func clear_selection():
	accepted = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	for item in load_all_conf():
		add_icon_item(item["texture"], item["name"], item["menu_order"])
	set_process(true)

func _process(delta):
	if get_node("../Accept").is_pressed():
		accepted = true
		self.get_parent().hide()
	if get_node("../Cancel").is_pressed():
		accepted = false
		self.get_parent().hide()

