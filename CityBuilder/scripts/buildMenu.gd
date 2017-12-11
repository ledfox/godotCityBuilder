extends OptionButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var config = [
{"name": "House", "texture": preload("res://resources/buildings/House3.png"), "id": 0},
{"name": "Mill", "texture": preload("res://resources/buildings/Mill.png"), "id": 1}
]

func get_selected_name():
	get_item_text (get_selected ())

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	for item in config:
		add_icon_item(item["texture"], item["name"], item["id"])

