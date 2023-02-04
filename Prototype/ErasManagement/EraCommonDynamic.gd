extends Node2D

var eras : Array
var status_dict = {} #common status dict to be modified by scripts in children nodes. (shared between eras)

func _ready():
	eras = get_children()
	for i in range(0, eras.size()):
		remove_child(eras[i])

func init_to_era(origin: int) -> void:
	add_child(eras[origin])

func update_to_era(origin:int, destination : int) -> void :
	remove_child(eras[origin])
	add_child(eras[destination])
