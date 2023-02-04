extends Node2D

var _body_ref : Node2D = null
var _body_climbing = false

func _process(_delta):
	if _body_climbing:
		_body_ref.velocity.y = 0
		_body_ref.global_position = $Pivot/Position2DPivot.global_position

func _physics_process(_delta):
	if _body_climbing and Input.is_action_pressed("ui_select"):
		_body_climbing = false
		
func enable(enabled : bool) :
	enabled = true #hardcodeo
	$Pivot/Area2D/CollisionShape2D.disabled = not enabled
	$Pivot/SpriteLiana.visible = enabled

func _on_Area2D_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	_body_climbing = true
	_body_ref = body.get_owner()
	_body_ref.get_node("ClimbAllower").call_deferred("allow_climbing")
	$Pivot/Position2DPivot.global_position = _body_ref.global_position
	$Pivot/Area2D/CollisionShape2DExtra.set_deferred("disabled", false)

func _on_Area2D_body_shape_exited(_body_rid, _body, _body_shape_index, _local_shape_index):
	_body_climbing = false
	_body_ref.get_node("ClimbAllower").call_deferred("disallow_climbing")
	$Pivot/Area2D/CollisionShape2DExtra.set_deferred("disabled", true)
