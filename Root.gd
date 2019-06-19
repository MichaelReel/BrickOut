extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	print ("_ready")
	$MenuScreen.connect("start_button", self, "start_new_game")
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
	resume()
	$PlayField.reset()