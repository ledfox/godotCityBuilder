extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var is_road_adj = false
var tileset = load("res://resources/land_tiles.tres")
var shape
var collider

func get_tile_stats(name):
	var index = tileset.find_tile_by_name(name)
	self.set_texture(tileset.tile_get_texture(index))
	shape = tileset.tile_get_shape(index)
	
	

func init(name, pos):
	self.set_scale(Vector2(0.5, 0.5))
	get_tile_stats(name)
	self.set_pos(pos)
	

func find_neighbors():
	self.get_node(".").is_co

func _on_collision(value):
    collider = value.get_parent()
    print("ouch")
    #Then your else if ladder

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)

	
func _process(delta):
	pass
	

