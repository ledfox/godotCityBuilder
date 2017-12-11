extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var is_road_adj = false
var tileset = load("res://resources/land_tiles.tres")
onready var money = get_tree().get_root().get_node("Main/CanvasLayer/Money Value")
var shape
var collider
var build_cost = 10

var buildable_tiles = ["grass"]

func get_tile_stats(name):
	var index = tileset.find_tile_by_name(name)
	self.set_texture(tileset.tile_get_texture(index))
	shape = tileset.tile_get_shape(index)
	
func can_build_on(tile_name):
	return tile_name in buildable_tiles
	
func init(name, pos):
	self.set_scale(Vector2(0.5, 0.5))
	get_tile_stats(name)
	self.set_pos(pos)
	
func build():
	set_opacity(1)
	money.add_gold(-build_cost)
	

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)

	
func _process(delta):
	pass
	

