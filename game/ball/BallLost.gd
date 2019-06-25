extends StaticBody2D

signal fell_out

func hit(item : KinematicBody2D):
	emit_signal("fell_out", item)