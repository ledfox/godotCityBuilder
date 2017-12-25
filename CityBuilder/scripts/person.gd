extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var home
var religion
var religions = ["P", "S"]

func pick_religion():
	randomize()
	return religions[randi()%2]
	
func _init(home):
	religion = pick_religion()
	home = home
	
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
