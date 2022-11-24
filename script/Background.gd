#Owner: LeeSoyoung
extends StaticBody2D

class_name gameBackground

func _on_Area2D_body_exited(_body):
	#Prevent the player from entering again when player leaves the start position (door)
	$StaticBody2D2/startPosition.set_deferred("disabled", false)
