extends KinematicBody2D

onready var _animation_player = $AnimationPlayer

var velocity = Vector2(0,0)
const walk_speed = 36
const climb_speed = 36
const gravity = 15
const jumpforce = -400
var double_jumped = false

func _physics_process(_delta):
	if Input.is_action_pressed("ui_right"):
		$Sprite.set_flip_h(false)
		_animation_player.play("walk")
		velocity.x += walk_speed
	elif Input.is_action_pressed("ui_left"):
		_animation_player.play("walk")
		$Sprite.set_flip_h(true)
		velocity.x -= walk_speed
	else:
		_animation_player.play("idle")
	
	if $ClimbAllower.is_climb_allowed():
		double_jumped = false
		velocity.y = min(0.0, velocity.y)		
		
	if is_on_floor():
		double_jumped = false
	if Input.is_action_just_pressed("ui_select") and (is_on_floor() || !double_jumped):
		double_jumped = !is_on_floor()
		velocity.y = jumpforce
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x, 0, 0.2)
