extends Node2D

signal pause_button
signal game_cleared

func _ready():
	$BrickArray.connect("bricks_cleared", self, "game_complete")

func reset():
	$Paddle.reset()
	$Ball.reset()
	$BrickArray.reset()

func _physics_process(delta):
	if Input.is_action_pressed('ui_cancel'):
		emit_signal("pause_button")

func game_complete(score : int):
	emit_signal("game_cleared", score)