extends "res://scripts/building.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var workers = [] #list of persons employed at this location

func do_work():
	var count = 0
	for each in workers:
		count = count + 1
	print(conf["name"], " did ", count, " work.")
	economy.add_value("money", 1)

func _process(delta):
	pass

func on_turn():
	if is_built:
		do_work()