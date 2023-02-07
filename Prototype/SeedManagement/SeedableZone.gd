extends Area2D
signal seed_planted

var _is_free : bool = true

func _ready():
	pass # Replace with function body.

func _on_SeedableZone_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	assert(body.has_method("allow_seed"))
	body.call_deferred("allow_seed", self)

func _on_SeedableZone_body_shape_exited(_body_rid, body, _body_shape_index, _local_shape_index):
	assert(body.has_method("disallow_seed"))
	body.call_deferred("disallow_seed", self)

func is_free() -> bool:
	return _is_free
	
func plant_seed():
	_is_free = false
	$PlantSound.play()
	emit_signal("seed_planted")
