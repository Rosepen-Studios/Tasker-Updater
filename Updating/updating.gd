extends Control
@onready var text: Label = $VBoxContainer/TextureRect/MarginContainer/VBoxContainer/Label2
@onready var web: HTTPRequest = $HTTPRequest
@onready var timer: Timer = $Timer
@onready var background: TextureRect = $TextureRect

var os:String = "MAC"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background.texture = load("res://Backgrounds/"+str(randi_range(1,2))+".png")
	var release_link:String = "https://github.com/Firepixel85/Tasker-Labs/releases/download/"+global.latest_version.split(",")[0]+"/Tasker."
	var user = OS.get_user_data_dir().split("/")[2]
	if os == "MAC":
		text.text = "Removing past installations"
		var output = []
		var term = OS.execute("/bin/bash",["-c"]+["cd .. && cd .. && cd .. && cd .. && cd .. && rm -rf /Applications/Tasker.app"],output)
		
		timer.start()
		await timer.timeout
		text.text = "Getting file from remote server"
		web.set_download_file("user://Tasker.zip")
		web.request(release_link+"Mac.zip")
		
		await web.request_completed
		text.text = "File retrived, expanding ZIP"
		
		term = OS.execute("/bin/bash",["-c"]+["cd .. && cd .. && cd .. && cd .. && cd .. && unzip '/Users/"+user+"/Library/Application Support/Godot/app_userdata/Tasker Updater/Tasker.zip' -d  '/Users/"+user+"/Library/Application Support/Godot/app_userdata/Tasker Updater'"],output)
		timer.start()
		await timer.timeout
		text.text = "Moving app to Applications folder"
		
		term = OS.execute("/bin/bash",["-c"]+["cd .. && cd .. && cd .. && cd .. && cd .. && mv '/Users/"+user+"/Library/Application Support/Godot/app_userdata/Tasker Updater/Tasker.app' /Applications"],output)
		timer.start()
		await timer.timeout
		term = OS.execute("/bin/bash",["-c"]+["cd .. && cd .. && cd .. && cd .. && cd .. && rm '/Users/"+user+"/Library/Application Support/Godot/app_userdata/Tasker Updater/Tasker.zip'"],output)
		text.text = "Deleting ZIP file"
		timer.start()
		await timer.timeout
		OS.shell_open("/Applications/Tasker.app")
		get_tree().quit()

	elif os == "WIN":
		text.text = "Removing past installations"
		var output = []
		var term
		
		text.text = "Getting file from remote server"
		web.set_download_file("user://Tasker.zip")
		web.request(release_link+"Windows.zip")
		
		await web.request_completed
		text.text = "Removing past installations"
		
		term = OS.execute("POWERSHELL.exe", ["Remove-Item -Path \"C:\\Tasker\\Tasker.exe\""],output)
		timer.start()
		await timer.timeout
		text.text = "File retrived, expanding ZIP"


		term = OS.execute("POWERSHELL.exe", ["tar -xf C:\\Users\\"+user+"\\AppData\\Roaming\\Godot\\app_userdata\\Tasker Updater\\Tasker.zip -C C:\\Users\\"+user+"\\AppData\\Roaming\\Godot\\app_userdata\\Tasker Updater"],output)
		timer.start()
		await timer.timeout
		
		term = OS.execute("POWERSHELL.exe", ["Remove-Item -Path C:\\Users\\"+user+"\\AppData\\Roaming\\Godot\\app_userdata\\Tasker Updater\\Tasker.zip"],output)
		text.text = "Deleting ZIP file"
		timer.start()
		await timer.timeout
		
		term = OS.execute("POWERSHELL.exe", ["New-Item -Path \"C:\\Tasker\" -ItemType Directory"],output)
		text.text = "Creating storage directory"
		timer.start()
		await timer.timeout
		
		output = []
		term = OS.execute("POWERSHELL.exe", [ "Move-Item -Path \"C:\\Users\\"+user+"\\AppData\\Roaming\\Godot\\app_userdata\\Tasker Updater\\Tasker.exe\"  -Destination \"C:\\Tasker\""],output)
		text.text = "Moving extracted file"
