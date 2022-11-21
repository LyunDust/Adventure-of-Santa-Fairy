extends KinematicBody2D

class_name player

export (int) var speed = 300
var isMoving = true
var blinking = false
var life = 3
signal playerDamage
signal pauseRay
signal startRay

var velocity = Vector2()

func _ready():
	isMoving = true

func get_input():
	velocity = Vector2()
	if isMoving == true and Global.aiming == false:
		if Input.is_action_pressed("ui_right"):
			velocity.x += 1
		if Input.is_action_pressed("ui_left"):
			velocity.x -= 1
		if Input.is_action_pressed("ui_up"):
			velocity.y -= 1
		if Input.is_action_pressed("ui_down"):
			velocity.y += 1
		velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	
func pausePlayer():
	isMoving = false
	$Timer.start()
	$Timer/blink.start()
	life -= 1
	emit_signal("playerDamage")
	emit_signal("pauseRay")
	
	if life == 0:
		Global.playerDie = true
		$Timer2.start()
		
		
func _on_Timer_timeout():
	isMoving = true
	$Timer/blink.stop()
	set_modulate(Color(1, 1, 1))
	emit_signal("startRay")

func _on_blink_timeout():
	if blinking == false:
		set_modulate(Color(0.5, 0.5, 0.5))
		blinking = !blinking
	else: 
		set_modulate(Color(1, 1, 1))
		blinking = !blinking


func _on_Timer2_timeout():
	get_tree().change_scene("res://scene/GameOver.tscn")
	

func _on_Santa_bag_playerPause():
	isMoving = false
	$Timer.start()
	emit_signal("pauseRay")


func _on_ray_gameOver():
	isMoving = false

func _on_ray2_gameOver():
	isMoving = false


func _on_ray3_gameOver():
	isMoving = false


func _on_ray4_gameOver():
	isMoving = false


func _on_sideRay_gameOver():
	isMoving = false


func _on_sideRay2_gameOver():
	isMoving = false


func _on_sideRay3_gameOver():
	isMoving = false
