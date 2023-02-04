extends Area2D

export var message : String #TODO: replace with string id

# precondition:
onready var dialogManager = $"../DialogManager"

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_accept") && $ChatBubble.visible:
		dialogManager.call_deferred("show_message", message) 
		$ChatBubble.visible = false
		yield(dialogManager, "dialog_ended")
		$ChatBubble.visible = true

func _on_NPC_body_shape_entered(_body_rid, _body, _body_shape_index, _local_shape_index):
	$ChatBubble.visible = true

func _on_NPC_body_shape_exited(_body_rid, _body, _body_shape_index, _local_shape_index):
	$ChatBubble.visible = false
