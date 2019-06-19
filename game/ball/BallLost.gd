extends StaticBody2D

func hit(ball : KinematicBody2D):
	if ball.has_method("fell_out"):
		ball.call_deferred("fell_out")