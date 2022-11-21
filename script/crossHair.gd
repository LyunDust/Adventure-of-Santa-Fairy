extends KinematicBody2D

var velocity = Vector2()
var speed = 300
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
	Global.targetPos = body.position

func _on_Area2D_body_exited(body):
	if Global.aiming == true:
		Global.target = false
