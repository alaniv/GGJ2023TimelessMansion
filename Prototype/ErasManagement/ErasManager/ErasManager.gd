extends Node

#todo: cambiarle el nombre a Eras manager...

export(int) var current_era : int

var _travelling = false

#preconditions:
onready var eras_node : Node = get_tree().get_nodes_in_group("Eras")[0]
onready var eras : Array = eras_node.get_children()
onready var mc : Node2D = get_tree().get_nodes_in_group("MainCharacter")[0]
onready var eras_dynamic_objects : Array = get_tree().get_nodes_in_group("ErasCommonDynamics")[0].get_children()

func _ready():
	for i in range(0, eras.size()):
		if i != current_era:
			eras_node.remove_child(eras[i])	
	for obj in eras_dynamic_objects:
		obj.call_deferred("init_to_era", current_era)

func travel(origin_era, destination_era, change_position_on_warp, destination_position):
	if _travelling:
		return
	_travelling = true
	eras_node.remove_child(eras[origin_era])
	eras_node.add_child(eras[destination_era])
	for obj in eras_dynamic_objects:
		obj.update_to_era(origin_era, destination_era)
	if change_position_on_warp:
		mc.position = destination_position
	$Cooldown.start(0.5)
	yield($Cooldown, "timeout")
	_travelling = false
	print(destination_era)
