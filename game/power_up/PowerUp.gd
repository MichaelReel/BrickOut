extends KinematicBody2D

class_name PowerUp
signal power_up

enum Power_Type { SPEED, WIDTH, HARD, STICKY }
const POWER_PROBABILITIES = { Power_Type.SPEED: 25, Power_Type.WIDTH: 25, Power_Type.HARD: 25, Power_Type.STICKY: 25}
const POWER_ANIMATIONS = {
		Power_Type.SPEED: "power_up_speed",
		Power_Type.WIDTH: "power_up_width", 
		Power_Type.HARD: "power_up_hard_ball", 
		Power_Type.STICKY: "power_up_sticky",
	}
var PROBABILITY_SUM # Calculate on _ready

export (float) var speed = 100
# Drop straight down
var velocity = Vector2(0,1).normalized() * speed
var type

func _ready():
	# Get drop table sum
	PROBABILITY_SUM = 0
	for i in POWER_PROBABILITIES.values():
		PROBABILITY_SUM += i
		
	# set this power up to a random one, based on odds
	type = get_random_power_type()
	$anim.play(POWER_ANIMATIONS[type])

func set_speed(s : float):
	speed = s
	velocity = Vector2(0,1).normalized() * speed

func _physics_process(delta):
	var collision : KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		emit_signal("power_up", self, collision.collider)

func get_random_power_type():
	var t_ind = randi() % PROBABILITY_SUM
	for prob_type in Power_Type.values():
		if t_ind < POWER_PROBABILITIES[prob_type]:
			return prob_type
		else:
			t_ind -= POWER_PROBABILITIES[prob_type]