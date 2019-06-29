extends Node2D

var power_up_scene : = load("res://game/power_up/PowerUp.tscn")
var power_up_list : Array
var paddle
var ball

func _ready():
	paddle = get_parent().get_node("Paddle")
	ball = get_parent().get_node("Ball")
	power_up_list = []

func create_power_up(pos : Vector2, speed : float):
	# Create a power-up
	var power_up = power_up_scene.instance()
	power_up.position = pos
	power_up.set_speed(speed / 10.0)
	power_up.connect("power_up", self, "on_power_up")
	get_parent().add_child(power_up)
	power_up_list.append(power_up)

func clear_power_ups():
	var power_up = power_up_list.pop_front()
	while power_up:
		power_up.call_deferred("queue_free")
		power_up = power_up_list.pop_front()

func on_power_up(power_up, collider):
	if collider == paddle:
		# Do something depending on the power_up type
		if power_up.type == PowerUp.Power_Type.SPEED:
			paddle.speed += 10
		elif power_up.type == PowerUp.Power_Type.WIDTH:
			paddle.width_set(paddle.width + 1)
		elif power_up.type == PowerUp.Power_Type.HARD:
			pass
		elif power_up.type == PowerUp.Power_Type.STICKY:
			paddle.set_sticky(3)
	# Paddle or ball lost pit, remove powerup
	power_up_list.erase(power_up)
	power_up.call_deferred("queue_free")