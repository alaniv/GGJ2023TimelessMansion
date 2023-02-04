extends Node2D

export(int) var seed_count : int
var _can_seed : bool

var _nearby_seedable_zone : Node2D = null

func _ready():
	pass

func _process(_delta):
	if _can_seed and Input.is_action_just_pressed("ui_focus_next"):
		assert(_nearby_seedable_zone.has_method("is_free"))
		if seed_count > 0 and _nearby_seedable_zone.is_free():
			_nearby_seedable_zone.call_deferred("plant_seed")
			seed_count -= 1
		if seed_count == 0:
			print_debug("se me acabaron las seeds :(")
	
func allow_seed(seedable_zone):
	_can_seed = true
	_nearby_seedable_zone = seedable_zone

func disallow_seed(seedable_zone):
	_can_seed = false
	_nearby_seedable_zone = seedable_zone
