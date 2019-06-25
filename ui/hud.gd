extends Node2D

func update_brick_count(var c : int):
	$BrickCount.update_counter(c)

func update_lost_balls(var c : int):
	$LostBalls.update_counter(c)

func update_ball_speed(var c : int):
	$BallSpeed.update_counter(c)

func update_paddle_speed(var c : int):
	$PaddleSpeed.update_counter(c)

func update_score(var c : int):
	$Score.update_counter(c)
