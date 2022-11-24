#Owner: LeeSoyoung
extends KinematicBody2D

class_name vacuums

var speed = 150

var velocity = Vector2()
var direction = 1
var yValue
var isMoving = true
signal catPause
signal aimingPause
signal sendPos(pos)

func _ready():
	randomize()
	yValue = rand_range(-1, 1)
	isMoving = true

func _physics_process(_delta):
	velocity = velocity.normalized() * speed
	
	if is_on_wall():
		direction = direction * -1
		yValue = rand_range(-1, 1)
	
	if isMoving == true:
		if direction == 1:
			velocity = Vector2(1, yValue) * speed
		else:
			velocity = Vector2(-1, yValue) * speed
		velocity = move_and_slide(velocity)
		
	emit_signal("sendPos", position)
		

func robotError():
	set_modulate(Color(0.5, 0.5, 0.5))
	isMoving = false
	if Global.playerDie ==  false:
		visible = false
	else:
		visible = true
	velocity.x = 0
	$Timer.start()
	$Timer/blink.start()


func _on_blink_timeout():
	visible = !visible


func _on_Timer_timeout():
	$Timer/blink.stop()
	visible = true
	set_modulate(Color(1, 1, 1))
	isMoving = true


func _on_Area2D_body_entered(body):
	if body is player:
		body.pausePlayer()
		robotError()
		emit_signal("catPause")
		emit_signal("aimingPause")


func _on_Santa_bag_vacuumsPause():
	isMoving = false
	emit_signal("aimingPause")
	$Timer.start()


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

func _on_Cat_vacuumsPause():
	isMoving = false
	$Timer.start()
	
func teleport():
	position = Vector2(40, 200)
	isMoving = false
	$hit.start()

func _on_hit_timeout():
	isMoving = true
