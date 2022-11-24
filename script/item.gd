#Owner: LeeSoyoung
extends KinematicBody2D

var target = Vector2()
var velocity = Vector2()
var speed = 700

func _physics_process(_delta):
	#If the player successfully aimed at the robot vacuum,
	#follow the position until the robot vacuum and the item collide
	#In case of failure, the target position is where the crosshair disappeared
	if Global.target == true:
		target = Global.vaccumsPos
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) > 10:
		velocity = move_and_slide(velocity)
	else: #queue_free() when it arrive at the target location
		queue_free()

#When a robot vacuum and an item collide, it teleports the vacuum to a specific location
func _on_Area2D_body_entered(body):
	if body is vacuums:
		Global.target = false
		body.teleport()
		queue_free()
		
#Save Target Location
func targetPos(pos):
	target = pos
