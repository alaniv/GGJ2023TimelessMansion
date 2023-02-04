extends Node

# shity way for pausing Maincharacter _physics_process
# Will be replaced with a better option: get_tree().paused = true,  
# and pause_mode property (just via the inspector) to process
var pause = false
