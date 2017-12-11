extends Camera2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var map_edges = {"x":{"max":0, "min":0}, "y":{"max":0, "min":0}}
var pan_active = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	print("camera rdy")
	set_process(true) #player interactions
	set_process_input(true) #also player interactions
	pass

func constrained_pos():
	var x_offset = 0#500 
	var y_offset = 0#500 
	#Get the mouse position, but restict it to the map size
	var pos = get_global_mouse_pos()
	
	if pos.x < map_edges["x"]["min"]:
		pos.x = map_edges["x"]["min"]
	if pos.y < map_edges["y"]["min"]:
		pos.y = map_edges["y"]["min"]
	if pos.x > map_edges["x"]["max"] - x_offset:
		pos.x = map_edges["x"]["max"] - x_offset
	if pos.y > map_edges["y"]["max"] - y_offset:
		pos.y = map_edges["y"]["max"] - y_offset
		
	return pos

func _input(event):
	if event.is_action_pressed("activate_panning"):
		pan_active = not pan_active
	
	
func _process(delta):
	#this scrolls the map
	if pan_active:
		self.set_global_pos(constrained_pos())
	


