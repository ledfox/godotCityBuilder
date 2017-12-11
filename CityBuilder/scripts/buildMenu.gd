extends OptionButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var config = [
{"name": "House", "texture": preload("res://resources/buildings/House3.png"), "id": 0},
{"name": "Mill", "texture": preload("res://resources/buildings/Mill.png"), "id": 1}
]

var accepted = false

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
	for item in config:
		add_icon_item(item["texture"], item["name"], item["id"])
	set_process(true)

func _process(delta):
	if get_node("../Accept").is_pressed():
		accepted = true
		self.get_parent().hide()
	if get_node("../Cancel").is_pressed():
		accepted = false
		self.get_parent().hide()

