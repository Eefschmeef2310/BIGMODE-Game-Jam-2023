# NyanConsole by Tom v0.3
# need to do:
#	add more commands 


extends Node

const VERSION = "0.5"
const HELP ="Available commands:
help
nya
freecam - switch to freecam mode and fly around the scene
gamecam - revert to normal camera functionality (doesnt always work)
stonks [amount] - adds [amount] to the plaeyers gears
godmode - NOT YET IMPLEMENTED
stuck - teleport the tank up to get it unstuck
upgrade <name> - apply the supplied upgrade to the tank/player
upload <username> <score> <version> - upload a record to the leaderboard
reset - restarts the game"

var active = false as bool
@onready var inputBox : LineEdit = $CanvasLayer/LineEdit
@onready var outputBox : TextEdit =  $CanvasLayer/TextEdit
@export var freeCam : Camera2D
@export var gameCam : Camera2D
@export var spawnables : Array[PackedScene]
#var lastCommand : String #redundant?
var command : String


signal cmdFreecam
signal cmdGamecam
signal cmdStonks
signal cmdGodmode
signal cmdStuck
signal cmdUpload(username, score, version)
signal cmdUpgrade(upgrade)

# Called when the node enters the scene tree for the first time.
func _ready():
	meow("NyanConsole Version " + VERSION)
	meow("============================================")
	meow("type 'help' for a list of commands")
	setDisplay(false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("toggleConsole"):
		active = !active
		setDisplay(active)
	if Input.is_key_pressed(KEY_UP):
		inputBox.text = command


func _on_line_edit_text_submitted(new_text):
	command = new_text
	command = command.to_lower()
	var argCount = command.get_slice_count(" ")
	var arg = new_text.split(" ", false, 0) as PackedStringArray
	inputBox.clear()
	if(argCount > 0):
		match arg[0]:
			
			"help":
				# standard "help" command
				meow("hehehe, use 'nya' to view the list of commands")
			"nya":
				# actual help command
				meow(HELP)
			"meow":
				# nya nya~!
				meow("the console meows back happily :3")
			"freecam":
				#enter freecam mode 
				freeCam.make_current()
				freeCam.process_mode = Node.PROCESS_MODE_INHERIT
				meow("entered freecam mode")
				meow("use WASD to pan, Q to zoom out and E to zoom in")
				cmdFreecam.emit()
			"gamecam":
				#return camera to normal mode
				gameCam.make_current()
				freeCam.process_mode = Node.PROCESS_MODE_DISABLED
				meow("switched to normal camera")
				cmdGamecam.emit()
			"stonks":
				if argCount > 1:
					GameManager.gears += int(arg[1])
				else:
					#infinite gears
					GameManager.gears += 9999
				meow("money go up!!!")
				cmdStonks.emit()
			"godmode":
				# infinite health
				meow("NOT YET IMPLEMENTED")
				cmdGodmode.emit()
				meow("Life, it never die")
			"stuck":
				#teleport player up like 1 units or smething to get them unstuck
				meow("door stuck!")
				cmdStuck.emit()
			"upgrade":
				if argCount>1:
					print(arg[1]) # arg[1] is the 1st argument of the command, in this case the upgrade name
					cmdUpgrade.emit(arg[1]) #optonally use this signal!
					
					UpgradeManager.purchase_upgrade(arg[1].replace("_", " "))
					meow(arg[1].replace("_", " ") + " upgrade attempted!")
					
				else:
					meow("the name of an upgrade must be given!")
					meow("usage: upgrade <name>")
			"upload":
				meow("usage: upload <username> <score> <version>")
				
				if argCount>=4:
					cmdUpload.emit(arg[1], arg[2], arg[3])
					meow("attempted to send data, make sure the arguments are correct")
				else:
					meow("too few arguments!")
			"reset":
				get_tree().change_scene_to_file("res://Levels/world.tscn")
			"spawn":
				#spawn prefab from the spawnables array - enimies, gears, ect
				meow("NOT YET IMPLEMENTED :(")
				pass
			_: #wildcard
				meow("command: '" + command + "' not found" )
	else:
		meow("0w0 please enter a command! - use 'help' for a list")
		

func meow(text):
	outputBox.text += "\n" + text
	outputBox.scroll_vertical = 9999

func setDisplay(active):
	inputBox.set_visible(active)
	outputBox.set_visible(active)
	inputBox.clear()
	inputBox.select()
	if active:
		inputBox.grab_focus()


func _on_http_request_response(string):
	meow("Uplaod response: " + string)
