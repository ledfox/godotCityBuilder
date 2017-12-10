extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var accum=0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#pass
	set_process(true)

func _process(delta):
	accum += delta/2
	set_text(str(round(accum)))
