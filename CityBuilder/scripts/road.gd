extends "res://scripts/building.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func on_turn():
	if is_built:
		print("Iam road: ", conf["name"])
