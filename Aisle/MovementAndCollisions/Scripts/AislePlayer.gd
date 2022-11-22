extends KinematicBody2D

class_name AislePlayer

export (int) var playerSpeed = 150

var velocity = Vector2()

var sitdown = false
var isHeAlive = true

signal isHeAlived (isHeAlive)

onready var animation = $AnimationPlayer


func get_input():
	velocity = Vector2()
	sitdown = false
	if Input.is_action_pressed("right"):
		velocity.x += 1
		animation.play("run")
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		animation.play("run_left")
	if Input.is_action_pressed("down"):
		sitdown = true
		print("He sit down")
	if Input.is_action_pressed("interact"):
		print("He interact")
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


func check_collider(collision):
	if !sitdown:
		isHeAlive = false
		emit_signal("isHeAlived", isHeAlive)
#		if collision.collider is MonsterMan:
#			print("Collided with an MonsterMan!")
#			isHeAlive = false
#		if collision.collider is MonsterWoman:
#			print("Collided with an MonsterWoman!")
#			isHeAlive = false
#		if collision.collider is EvilSantaFairy:
#			print("Collided with an EvilSantaFairy!")
	if sitdown:
		isHeAlive = true
		emit_signal("isHeAlived", isHeAlive)
#		if collision.collider is MonsterMan:
#			print("Escape from an MonsterMan!")
#		if collision.collider is MonsterWoman:
#			print("Escape from an MonsterWoman!")
#		if collision.collider is EvilSantaFairy:
#			print("Escape from an EvilSantaFairy!")
