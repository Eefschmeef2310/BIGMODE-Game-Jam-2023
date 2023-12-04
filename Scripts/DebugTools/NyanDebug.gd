# NyanConsole by Tom v0.1
# need to do:
#	add more commands 
#	add support for commands with arguments

extends Node

var active = false
@onready var inputBox : LineEdit = $CanvasLayer/LineEdit
@onready var outputBox : TextEdit =  $CanvasLayer/TextEdit
@export var freeCamNode : Camera2D
@export var gameCamNode : Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	setDisplay(false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("toggleConsole"):
		active = !active
		setDisplay(active)
		


func _on_line_edit_text_submitted(new_text):
	var command = new_text
	inputBox.clear()
	match command:
		"help":
			meow("use 'nya' to view the list of commands")
		"nya":
			meow("Available commands:")
			meow("help, nya, freecam, gamecam")
		"freecam":
			freeCamNode.make_current()
			freeCamNode.process_mode = Node.PROCESS_MODE_INHERIT
			meow("entered freecam mode")
			meow("use WASD to pan, Q to zoom out and E to zoom in")
		"gamecam":
			gameCamNode.make_current()
			freeCamNode.process_mode = Node.PROCESS_MODE_DISABLED
			meow("switched to normal camera")
		_:
			meow("command: '" + command + "' not found" )
		

func meow(text):
	outputBox.text += text + "\n"
	outputBox.scroll_vertical = 9999

func setDisplay(active):
	inputBox.set_visible(active)
	outputBox.set_visible(active)
	inputBox.clear()
	inputBox.select()
	if active:
		inputBox.grab_focus()
