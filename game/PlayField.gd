extends Node2D

signal pause_button
signal game_cleared

func _ready():
	$BrickArray.connect("bricks_cleared", self, "game_complete")
	$BrickArray.connect("brick_broken", self, "on_brick_broken")
	$BallLost.connect("fell_out", self, "item_fell_out")

func reset():
	$Paddle.reset()
	$Ball.reset()
	$BrickArray.reset()
	$PowerUpArray.clear_power_ups()

func _physics_process(delta):
	if Input.is_action_pressed('ui_cancel'):
		emit_signal("pause_button")

func game_complete(score : int):
	$PowerUpArray.clear_power_ups()
	emit_signal("game_cleared", score)

func item_fell_out(item):
	if item == $Ball:
		$Ball.call_deferred("fell_out")
		$Paddle.call_deferred("strip_powerups")
		$PowerUpArray.clear_power_ups()

func on_brick_broken(pos : Vector2):
	$PowerUpArray.create_power_up(pos, $Ball.speed)
