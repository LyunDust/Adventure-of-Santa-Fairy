extends KinematicBody2D

class_name AislePlayer

export (int) var playerSpeed = 150

var velocity = Vector2()

var sitdown = false
var isHeAlive = true
var input = false

signal isHeAlived (isHeAlive)

onready var animation = $AnimationPlayer


func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
		animation.play("run")
		input = true
		sitdown = false
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		animation.play("run_left")
		input = true
		sitdown = false
	if Input.is_action_pressed("down"):
		animation.play("sitdown")
		sitdown = true
		input = true
	if Input.is_action_pressed("interact"):
		print("He interact")
		input = true
		
	if !sitdown:
		velocity = velocity.normalized() * playerSpeed


func _physics_process(delta):
	get_input()
	
	var collision = move_and_collide(velocity*delta)
	
	if collision:
		check_collider(collision)
		print("Is he alive? ", isHeAlive)
		
	if !isHeAlive:
		print("He is dead")
		get_tree().paused = true
	
	if !input:
		animation.stop()
	
	input = false


func check_collider(collision):
	isHeAlive = false
	emit_signal("isHeAlived", isHeAlive)
