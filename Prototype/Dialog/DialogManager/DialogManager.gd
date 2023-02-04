extends Control
signal dialog_ended

#todo: maybe move this to a json file?
var _test_dialog : Dictionary = {
	"TEXT_TEST_NPC_1" : [
		"Esto es una prueba de NPC 1",
		"No pienses que hay algo más oculto...",
	],
	"TEXT_TEST_NPC_2" : [
		"Esto es una prueba de NPC 2",
		"Habrá algo más oculto?...",
	],	
	"TEXT_PLATFORM_BROKEN" : [
		"Parece haberse dañado. no servirá en el futuro"
	]
}

var _reading : bool = false
var _dialog_id : String = ""
var _current_index : int = -1
var _awaiting : bool = false

#todo: add a DialogBottom TextBox, if needed
func _ready():
	$DialogTop.visible = false

func show_message(dialog_id : String):
	get_tree().paused = true
	_dialog_id = dialog_id
	_current_index = 0
	_reading = true
	$DialogTop.visible = true
	load_next_line()

func load_next_line():
	assert(_test_dialog.has(_dialog_id), "that key doesn't exists!")
	if _current_index == _test_dialog[_dialog_id].size():
		return false
	_awaiting = false
	var line = _test_dialog[_dialog_id][_current_index]
	$DialogTop/RichTextLabel.bbcode_text = line
	$DialogTop/RichTextLabel.percent_visible = 0
	var tween_duration = 0.01 * line.length()
	$DialogTop/Tween.interpolate_property($DialogTop/RichTextLabel, "percent_visible",
		0, 1, tween_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$DialogTop/Tween.start()
	_current_index += 1
	return true
	
func _physics_process(_delta):
	if _reading:
		$DialogTop/Next.visible = _awaiting
		if _awaiting and Input.is_action_just_pressed("ui_accept"):
			var has_line = load_next_line()
			if not has_line:
				close_dialog()
		
func close_dialog():
	_reading = false
	_awaiting = false
	$DialogTop.visible = false
	get_tree().paused = false
	emit_signal("dialog_ended")


func _on_Tween_tween_completed(_object, _key):
	_awaiting = true
