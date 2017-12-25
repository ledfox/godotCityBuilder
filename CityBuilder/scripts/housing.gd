extends "res://scripts/building.gd"

const Person = preload("res://scripts/person.gd") # Relative path
var occupants = []

func _ready():
	occupants.append(Person.new(self))

func on_turn():
	# Called every time the node is added to the scene.
	# Initialization here
	if is_built:
		print("Ima house:", conf["name"], " ", occupants.size(), " people live here")
		for occ in occupants:
			print("One person is ", occ.religion)
