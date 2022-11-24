extends KinematicBody2D

class_name Player

export (int) var speed = 200
var velocity = Vector2()
#var collectedClothes = 0

	
func get_input():
	# set velocity based on the keys pressed
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1

	# use normalized vector (length = 1) so that the velocity 
	# is calculated correctly based on the speed.
	velocity = velocity.normalized() * speed


func _physics_process(delta):
	get_input()	
	velocity = move_and_slide(velocity)
	

	

