extends StaticBody2D

signal brick_destroyed

class_name Brick

func hit(ball : KinematicBody2D):
	# Let something else handle the collision
	emit_signal("brick_destroyed", self, ball)
