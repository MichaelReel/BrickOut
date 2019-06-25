extends Node2D

signal pause_button
signal game_cleared

var power_up_scene : = load("res://game/power_up/PowerUp.tscn")

func _ready():
	$BrickArray.connect("bricks_cleared", self, "game_complete")
	$BrickArray.connect("brick_broken", self, "on_brick_broken")
	$BallLost.connect("fell_out", self, "item_fell_out")

func reset():
	$Paddle.reset()
	$Ball.reset()
	$BrickArray.reset()

func _physics_process(delta):
	if Input.is_action_pressed('ui_cancel'):
		emit_signal("pause_button")

func game_complete(score : int):
	emit_signal("game_cleared", score)

func item_fell_out(item):
	if item == $Ball:
		$Ball.call_deferred("fell_out")
		$Paddle.call_deferred("strip_powerups")

func on_brick_broken(pos : Vector2):
	# Create a power-up
	var power_up = power_up_scene.instance()
	power_up.position = pos
	power_up.set_speed($Ball.speed / 10.0)
	power_up.connect("power_up", self, "on_power_up")
	get_parent().call_deferred("add_child", power_up)

func on_power_up(power_up, collider):
	if collider == $Paddle:
		$Paddle.speed += 10
	# Whatever we hit, remove the power_up 
	# power_up should be on different collision mask from other bricks and the ball
	power_up.call_deferred("queue_free")