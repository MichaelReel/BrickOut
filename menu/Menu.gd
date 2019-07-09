extends MarginContainer

signal start_button
signal resume_button

var last_high_score

var resume_button
var highscores
var done_popup

func _ready():
	resume_button = $Panel/HBoxContainer/VBoxContainer/ResumeButton
	highscores = $Panel/HBoxContainer/HighScore
	done_popup = $GetNamePopup
	
	done_popup.connect("name_entered", self, "high_score_name_entered")

func _physics_process(delta):
	if visible and Input.is_action_just_released('ui_cancel'):
		emit_signal("resume_button")

func _on_Start_pressed():
	print ("Start Button Pressed")
	emit_signal("start_button")

func _on_ResumeButton_pressed():
	print ("Resume Button Pressed")
	emit_signal("resume_button")

func game_cleared(score : int):
	last_high_score = score
	done_popup.set_highscore(last_high_score)
	done_popup.popup()

func can_resume(enabled : bool):
	resume_button.disabled = !enabled

func high_score_name_entered(name: String):
	highscores.insert_new_highscore(name, last_high_score)