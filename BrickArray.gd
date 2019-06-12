extends Node2D

export (int) var max_bricks_per_row   = 15
export (int) var max_brick_rows       = 5
export (Vector2) var brick_dimensions = Vector2(64,32)

var bricks : Array = []
var brick_scene : = load("res://Brick.tscn")

func _ready():
	# Place a bunch of bricks and make sure we monitor how many are left
	var center_of_bricks : Vector2 = Vector2(get_viewport().size.x / 2 ,max_brick_rows * brick_dimensions.y)
	
	# Create each row
	for row in max_brick_rows:
		var y : int = center_of_bricks.y - (max_brick_rows * brick_dimensions.y / 2) + (row * brick_dimensions.y)
		# Odd or even brick count in this row?
		var row_brick_count : int = max_bricks_per_row - randi() % 2
		print ("row: " + str(row) + " has " + str(row_brick_count) + " bricks, max")
		
		# Create each brick in the row
		for col in row_brick_count:
			var x : int = center_of_bricks.x - (row_brick_count * brick_dimensions.x / 2) + (col * brick_dimensions.x)
			
			var brick : Brick = brick_scene.instance()
			brick.position.x = x
			brick.position.y = y
			
			print ("placing brick at " + str(brick.position))
			
			get_parent().call_deferred("add_child", brick)
			bricks.append(brick)