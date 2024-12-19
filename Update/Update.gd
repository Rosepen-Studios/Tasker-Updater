extends Control

@onready var exit: Button = $VBoxContainer/HBoxContainer/TextureRect/MarginContainer/VBoxContainer2/Control/HBoxContainer2/Button
@onready var update: Button = $VBoxContainer/HBoxContainer/TextureRect/MarginContainer/VBoxContainer2/Control/HBoxContainer/Button
@onready var text: Label = $VBoxContainer/HBoxContainer/TextureRect/MarginContainer/VBoxContainer/Label2
@onready var title: Label = $VBoxContainer/HBoxContainer/TextureRect/MarginContainer/VBoxContainer/Label

func _ready() -> void:
	text.text = "A new version of Tasker is available, click “Update” to install version "+global.latest_version+"."
func _on_update_pressed() -> void:
	get_tree().change_scene_to_file("res://Updating/Updating.tscn")
