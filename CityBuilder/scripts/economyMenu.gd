extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var lables = {
"food": {
	"base_text":"Food: ",
	"value": 0, 
	"node": get_node("Food"),
	"percision": "%3.2f"},
"pop": {
	"base_text":"Population: ",
	"value": 0, 
	"node": get_node("Pop"),
	"percision": "%3.0f"},
"ore": {
	"base_text":"Ore: ",
	"value": 3, 
	"node": get_node("Ore"),
	"percision": "%3.2f"},
"wood": {
	"base_text":"Wood: ",
	"value": 50, 
	"node": get_node("Wood"),
	"percision": "%3.2f"},
"money": {
	"base_text":"Money: ",
	"value": 0, 
	"node": get_node("Money"),
	"percision": "%3.2f"}
	,
"time": {
	"base_text":"Time: ",
	"value": 0, 
	"node": get_node("Timer"),
	"percision": "%3.4f"}
	}

func add_value(var_name, num):
	lables[var_name]["value"] = lables[var_name]["value"] + num

func display_value(num):
	return "%3.2f" % num

func get_values():
	var all_val = {}
	for lab in lables:
		all_val[lab] = lables[lab]["value"]
	return all_val
	
func show_values():
	for lab in lables:
		var each = lables[lab]
		each["node"].set_text(each["base_text"] + each["percision"] % each["value"])
	
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	set_process(true)
	connect("toggled", self, "on_toggled")
	set_toggle_mode(true)
	set_pressed(true)

func on_toggled(toggled):
    # I WISH I WOULD HAVE HERE THE THE BUTTON OBJECT OR AT LEAST THE 
    # NAME ON THE BUTTON.
	for child in get_children():
		if toggled:
			child.show()
		else:
			child.hide()


func _process(delta):
	add_value("time", 0.0001)
	show_values()
	