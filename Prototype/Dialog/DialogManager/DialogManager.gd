extends Control
signal dialog_ended

#todo: add a DialogBottom TextBox, if needed
func _ready():
	$DialogTop.visible = false

func show_message(text : String):
	$DialogTop.visible = true
	$DialogTop/RichTextLabel.text = text
	PrototypeGlobals.set_deferred("pause", true)

func show_message_not_blocking(text : String):
	$DialogTop.visible = true
	$DialogTop/RichTextLabel.text = text
	$Timer.start(1)
	yield($Timer, "timeout")
	$DialogTop.visible = false
	
func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_accept") && $DialogTop.visible:
		$DialogTop.visible = false
		PrototypeGlobals.set_deferred("pause", false)
		emit_signal("dialog_ended")
