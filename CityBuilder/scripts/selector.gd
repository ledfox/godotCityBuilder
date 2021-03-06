extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var tile_size = 32

var textures = {
	"green": load("res://resources/green.png"),
	"red": load("res://resources/red.png")
}

func set_color(color):
	set_texture(textures[color])

func be_green(should_green):
	if should_green:
		set_color("green")
	else:
		set_color("red")

func custom_set_scale(vect):
	set_scale(Vector2(vect.x/tile_size, vect.y/tile_size))

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	print("selector ready")
	set_centered(true)
	set_process(true) #player interactions
	
	
func _process(delta):
	pass