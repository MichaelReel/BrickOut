extends MarginContainer

signal start_button

func _on_Start_pressed():
	print ("Start Button Pressed")
	emit_signal("start_button")
