extends AcceptDialog

signal name_entered

func _on_Control_confirmed():
	emit_signal("name_entered", $LineEdit.text)