extends Control
signal dialog_ended

# todo: put everything in another child, to avoid having to set visible false in Main Node

func show_message(text : String):
	visible = true
	$RichTextLabel.text = text
	PrototypeGlobals.set_deferred("pause", true)

func show_message_not_blocking(text : String):
	visible = true
	$RichTextLabel.text = text
	$Timer.start(1)
	yield($Timer, "timeout")
	visible = false
	
func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_accept") && visible:
		visible = false
		PrototypeGlobals.set_deferred("pause", false)
		emit_signal("dialog_ended")
