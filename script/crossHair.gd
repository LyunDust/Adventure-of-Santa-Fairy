#Owner: LeeSoyoung
extends KinematicBody2D

var velocity = Vector2()
var speed = 500

func _physics_process(_delta):
	if Global.aiming == true: #If user is aiming
		get_input()
		velocity = move_and_slide(velocity)
	
func get_input(): #Control crosshair
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

#body_entered & body_exited: Check if the player succeeded in aiming(body is only Robot vacuums)
#timing of determining whether the aim is successful is 'Global.aiming' is false, keep checking until then
func _on_Area2D_body_entered(_body):
	Global.target = true

func _on_Area2D_body_exited(_body):
	if Global.aiming == true:
		Global.target = false
