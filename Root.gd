extends Node2D

func _ready():
	print ("_ready")
	$MenuScreen.connect("start_button", self, "start_new_game")
	$MenuScreen.connect("resume_button", self, "resume")
	$PlayField.connect("pause_button", self, "pause")
	pause()

func pause():
	print ("pause")
	$PlayField.get_tree().paused = true
	$MenuScreen.visible = true

func resume():
	print ("resume")
	$PlayField.get_tree().paused = false
	$MenuScreen.visible = false

func start_new_game():
	print ("Start signal received")
	$PlayField.get_tree().paused = false
	$PlayField.reset()
	$MenuScreen.visible = false