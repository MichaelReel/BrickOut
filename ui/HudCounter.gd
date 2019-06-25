extends Node2D

const max_visible_digits = 9
# N.B.: I've avoided using get_child_count here to allow other children to be placed with this counter
export (int) var visible_digits = max_visible_digits

func _ready():
	# Hide any digits we don't need and move the rest to the left
	var move_x : int = 0
	for i in range(max_visible_digits - 1, -1, -1):
		var digit : Sprite = get_node("digit_" + str(i))
		if i >= visible_digits:
			# Hide digits we don't need
			digit.visible = false
			move_x += 20
		else:
			# move the rest to the left
			digit.position.x -= move_x

func update_counter(var c : int):
	var count := c
	for i in range(0, visible_digits):
		var digit_value : int = count % 10
		count /= 10
		get_node("digit_" + str(i)).frame = digit_value