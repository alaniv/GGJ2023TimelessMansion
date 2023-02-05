extends Area2D

export (String) var next_scene_path = ""

func _on_Exit_body_shape_entered(_body_rid, _body, _body_shape_index, _local_shape_index):
	var _ret = get_tree().change_scene(next_scene_path)
