extends MarginContainer

signal start_button
signal resume_button

var last_high_score 

func _ready():
	$GetNamePopup.connect("name_entered", self, "high_score_name_entered")

func _on_Start_pressed():
	print ("Start Button Pressed")
	emit_signal("start_button")

func _on_ResumeButton_pressed():
	print ("Resume Button Pressed")
	emit_signal("resume_button")

func game_cleared(score : int):
	 # TODO: Think about passing the high score to the popup:
	last_high_score = score
	$GetNamePopup.popup()

func can_resume(enabled : bool):
	$Panel/HBoxContainer/VBoxContainer/ResumeButton.disabled = !enabled

func high_score_name_entered(name: String):
	$Panel/HBoxContainer/HighScore.insert_new_highscore(name, last_high_score)