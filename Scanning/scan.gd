extends Control

@onready var web: HTTPRequest = $HTTPRequest

var current_version
var tasker_path = OS.get_user_data_dir().split("Tasker Updater")[0]+"/Tasker/taskdata.json"
func _ready() -> void:
	
	var file = FileAccess.open(tasker_path,FileAccess.READ).get_as_text()
	var data = JSON.parse_string(file)
	current_version = data["version"]
	global.current_version = current_version
	file = FileAccess.open(OS.get_user_data_dir()+"/latest.json",FileAccess.WRITE)
	file.store_string(JSON.stringify(global.version))
	file.close()
	
	
	web.set_download_file("user://latest_version.txt")
	web.request("https://github.com/Firepixel85/Tasker-Labs/releases/download/latest_pointer/latest_version.txt")
	await web.request_completed
	var latest_version = FileAccess.open("user://latest_version.txt",FileAccess.READ).get_as_text()
	global.latest_version = latest_version
	if latest_version == current_version:
		get_tree().change_scene_to_file("res://Latest/Latest.tscn")
	else:
		get_tree().change_scene_to_file("res://Update/Update.tscn")
