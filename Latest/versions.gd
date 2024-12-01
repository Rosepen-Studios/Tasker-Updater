extends VBoxContainer

@onready var c: Label = $Label3
@onready var l: Label = $Label4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	l.text = "Latest version: "+global.latest_version.split(",")[0]
	c.text = "Current version: "+global.current_version.split(",")[0]
