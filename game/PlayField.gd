extends Node2D

signal pause_button

func reset():
	$Paddle.reset()
	$Ball.reset()
	$BrickArray.reset()

func _physics_process(delta):
	if Input.is_action_pressed('ui_cancel'):
		emit_signal("pause_button")