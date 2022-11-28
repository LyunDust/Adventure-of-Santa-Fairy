extends KinematicBody2D

class_name Player

export (int) var speed = 200
var velocity = Vector2()
var collectedClothes = 0
var cloth
	
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

	velocity = velocity.normalized() * speed


func _physics_process(delta):
	get_input()	
	velocity = move_and_slide(velocity)
	

func _on_Cloth_body_entered(body):
	pass
