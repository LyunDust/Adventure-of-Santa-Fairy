extends KinematicBody2D

var velocity = Vector2()
var speed = 500

func _physics_process(delta):
	if Global.aiming == true:
		get_input()
		velocity = move_and_slide(velocity)
	
func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	velocity = velocity.normalized() * speed

func _on_Area2D_body_entered(body):
	Global.target = true

func _on_Area2D_body_exited(body):
	if Global.aiming == true:
		Global.target = false
