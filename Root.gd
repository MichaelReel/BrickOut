extends Node2D

func _ready():
	print ("_ready")
	$MenuScreen.can_resume(false)
	$MenuScreen.connect("start_button", self, "start_new_game")
	$MenuScreen.connect("resume_button", self, "resume")
	$PlayField.connect("pause_button", self, "pause")
	$PlayField.connect("game_cleared", self, "game_cleared")
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
	$MenuScreen.can_resume(true)
	$MenuScreen.visible = false

func game_cleared(score : int):
	pause()
	$MenuScreen.can_resume(false)
	$MenuScreen.game_cleared(score)