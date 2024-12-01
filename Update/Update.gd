extends Control

@onready var exit: Button = $MarginContainer/VBoxContainer2/Control/HBoxContainer/Exit
@onready var update: Button = $MarginContainer/VBoxContainer2/Control/HBoxContainer2/Update
@onready var text: Label = $MarginContainer/VBoxContainer/Label2
@onready var title: Label = $MarginContainer/VBoxContainer/Label
@onready var ver: Label = $MarginContainer/VBoxContainer/VBoxContainer/Label3
@onready var ver2: Label = $MarginContainer/VBoxContainer/VBoxContainer/Label4
@onready var timer: Timer = $Timer
@onready var web: HTTPRequest = $HTTPRequest

var os = "MAC"

func _on_update_pressed() -> void:
	var release_link:String = "https://github.com/Firepixel85/Tasker-Labs/releases/download/"+global.latest_version.split(",")[0]+"/Tasker."
	print(release_link+"Mac.zip")
	var user = OS.get_user_data_dir().split("/")[2]
	if os == "MAC":
		update.visible = false
		exit.visible = false
		ver.visible = false
		ver2.visible = false
		title.text = "Updating"
		text.text = "Removing past installations"
		var output = []
		var term = OS.execute("/bin/bash",["-c"]+["cd .. && cd .. && cd .. && cd .. && cd .. && rm -rf /Applications/Tasker.app"],output)
		
		timer.start()
		await timer.timeout
		text.text = "Getting file from remote server (This might take some time)"
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
		update.visible = false
		exit.visible = false
		title.text = "Downloading"
		title.text = "Updating"
		text.text = "Removing past installations"
		var output = []
		var term
		
		text.text = "Getting file from remote server             (This might take some time)"
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
