extends Area2D

export(int) var origin_era : int
export(int) var destination_era : int
export(bool) var change_position_on_warp : bool = false
export(Vector2) var destination_position : Vector2

#precondition
onready var portalManager = get_tree().get_nodes_in_group("PortalManager")[0]

func _ready():
	$Sprite.frame = destination_era

func _on_Portal_body_shape_entered(_body_rid, _body, _body_shape_index, _local_shape_index):
	portalManager.call_deferred("travel", origin_era, destination_era, change_position_on_warp, destination_position)

func disable(disabled : bool):
	$CollisionShape2D.disabled = disabled

#note: Portal.tscn max num of portals depends on resource.
