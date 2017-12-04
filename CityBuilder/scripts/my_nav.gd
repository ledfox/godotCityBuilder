extends Camera2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var max_x = 50 # in tiles
var max_y = 25 # in tiles
var pan_active = true

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	print("camera rdy")
	set_process(true) #player interactions
	set_process_input(true) #also player interactions
	self.set_pos(Vector2(0,0))
	pass

func constrained_pos():
	#Get the mouse position, but restict it to the map size
	var pos = get_global_mouse_pos()
	if pos.x < 0:
		pos.x = 0
	if pos.y < 0:
		pos.y = 0
	if pos.x > (max_x * 32):
		pos.x = (max_x * 32)
	if pos.y > (max_y * 32):
		pos.y = (max_y * 32)
		
	return pos

func _input(event):
	if event.is_action_pressed("ui_select"):
		pan_active = not pan_active
	
	
func _process(delta):
	#this scrolls the map
	if pan_active:
		self.set_global_pos(constrained_pos())
	


