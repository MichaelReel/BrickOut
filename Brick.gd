extends StaticBody2D

class_name Brick

func hit(ball : KinematicBody2D):
	# Score should be incremented, ball sped up, whatever
	
	ball.speed += 1

	# Remove this brick
	queue_free()
