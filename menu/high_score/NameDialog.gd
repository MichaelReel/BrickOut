extends AcceptDialog

signal name_entered

var highscore : int
var name_field

func _ready():
	name_field = $LineEdit

func _on_Control_confirmed():
	emit_signal("name_entered", name_field.text)

func set_highscore(score : int):
	highscore = score

func _on_Control_about_to_show():
	self.dialog_text = "Enter name for highscore " + str(highscore) + ":"
