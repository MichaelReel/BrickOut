extends Node2D

var power_up_scene : = load("res://game/power_up/PowerUp.tscn")
var power_up_list : Array
var paddle

func _ready():
	paddle = get_parent().get_node("Paddle")
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
		paddle.speed += 10
	# Paddle or ball lost pit, remove powerup
	power_up_list.erase(power_up)
	power_up.call_deferred("queue_free")