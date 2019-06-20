extends MarginContainer

signal start_button
signal resume_button

func _on_Start_pressed():
	print ("Start Button Pressed")
	emit_signal("start_button")


func _on_ResumeButton_pressed():
	print ("Resume Button Pressed")
	emit_signal("resume_button")