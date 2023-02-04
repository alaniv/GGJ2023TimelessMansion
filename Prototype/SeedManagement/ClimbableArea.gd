extends Area2D

func _on_ClimbableArea_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	body.call_deferred("allow_climbing")


func _on_ClimbableArea_body_shape_exited(_body_rid, body, _body_shape_index, _local_shape_index):
	body.call_deferred("disallow_climbing")
