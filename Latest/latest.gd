extends Control
@onready var text: Label = $VBoxContainer/HBoxContainer/TextureRect/MarginContainer/VBoxContainer/Label2

func _ready() -> void:
	text.text = "There are no versions of Tasker newer than "+global.current_version+" available, if you think this is wrong please press \"Rescan\"."
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("bipass"):
		get_tree().change_scene_to_file("res://Update/Update.tscn")
