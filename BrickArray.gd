extends Node2D

export (int) var max_bricks_per_row   = 16
export (int) var max_brick_rows       = 7
export (Vector2) var brick_dimensions = Vector2(64,32)

#var bricks : Array = []
var brick_scene : = load("res://Brick.tscn")
var brick_count = 0

func _ready():
	# Find the center of the 'playable' area
	var center_of_bricks : Vector2 = Vector2(get_viewport().size.x / 2 ,max_brick_rows * brick_dimensions.y)
	# Place a bunch of bricks and make sure we monitor how many are left
	randomize()
	
	# Create each row
	for row in max_brick_rows:
		var y : int = center_of_bricks.y - (max_brick_rows * brick_dimensions.y / 2) + (row * brick_dimensions.y) + brick_dimensions.y / 2
		# Variable row length
		var row_brick_count : int = max_bricks_per_row - randi() % 3
		# Create each brick in the row
		for col in row_brick_count:
			var x : int = center_of_bricks.x - (row_brick_count * brick_dimensions.x / 2) + (col * brick_dimensions.x) + brick_dimensions.x / 2
			create_brick(x, y)

func create_brick(x, y):
	var brick : Brick = brick_scene.instance()
	brick.connect("brick_destroyed", self, "_on_brick_destroyed")
	brick.position.x = x
	brick.position.y = y
	
	get_parent().call_deferred("add_child", brick)
	brick_count += 1
#	bricks.append(brick)

func _on_brick_destroyed(var brick, var ball):
	
	brick_count -= 1
	get_parent().get_node("Hud").update_brick_count(brick_count)
	if (brick_count == 0):
		# Doesn't stop the ball here, but on the next collision
		ball.speed = 0
		# Add/Display score, ect
		
	else:
		ball.speed += 10
	
	brick.queue_free()