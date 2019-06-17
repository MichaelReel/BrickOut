extends Node2D

func update_brick_count(var c : int):
	var count := c
	for i in range(0, $BrickCount.get_child_count()):
		var digit_value : int = count % 10
		count /= 10
		$BrickCount.get_node("digit_" + str(i)).frame = digit_value
