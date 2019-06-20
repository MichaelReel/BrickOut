extends Node2D

export (int) var max_bricks_per_row   = 16
export (int) var max_brick_rows       = 7
export (Vector2) var brick_dimensions = Vector2(64,32)

var center_of_bricks : Vector2
var brick_list : Array

var brick_scene : = load("res://game/brick/Brick.tscn")
var score : int = 0

var hud

func _ready():
	hud = get_parent().get_node("Hud")
	# Find the center of the 'playable' area
	center_of_bricks = Vector2(get_viewport().size.x / 2 ,((max_brick_rows + 2) * brick_dimensions.y) / 2)
	brick_list = []
	# Place a bunch of bricks and make sure we monitor how many are left
	randomize()

func reset():
	# Clear score
	score = 0
	# Clear any existing bricks
	for brick in brick_list:
		brick.queue_free()
	brick_list = []
	
	# Create each row
	for row in max_brick_rows:
		var y : int = center_of_bricks.y - (max_brick_rows * brick_dimensions.y / 2) + (row * brick_dimensions.y) + brick_dimensions.y / 2
		# Variable row length
		var row_brick_count : int = max_bricks_per_row - randi() % 3
		# Create each brick in the row
		for col in row_brick_count:
			var x : int = center_of_bricks.x - (row_brick_count * brick_dimensions.x / 2) + (col * brick_dimensions.x) + brick_dimensions.x / 2
			create_brick(x, y)
	
	hud.update_score(score)
	hud.update_brick_count(brick_list.size())

func create_brick(x, y):
	var brick : Brick = brick_scene.instance()
	brick.connect("brick_destroyed", self, "_on_brick_destroyed")
	brick.position.x = x
	brick.position.y = y
	
	brick_list.append(brick)
	get_parent().call_deferred("add_child", brick)

func _on_brick_destroyed(var brick, var ball):
	
	brick_list.erase(brick)
	hud.update_brick_count(brick_list.size())
	
	score += ball.speed
	hud.update_score(score)
	
	if (brick_list.size() == 0):
		# Doesn't stop the ball here, but on the next collision
		ball.speed = 0
		# Add/Display score, ect
		
	else:
		ball.speed += 10
	
	brick.queue_free()