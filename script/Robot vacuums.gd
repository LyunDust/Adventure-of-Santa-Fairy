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
	
	#When colliding, change the x direction in reverse and determine a random value to move in the y direction
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
		
#It stops moving for a certain amount of time and gives the effect of blinking
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

#Blinking effect
func _on_blink_timeout():
	visible = !visible

#When the timer times out, stop the effect and allow it to move again
func _on_Timer_timeout():
	$Timer/blink.stop()
	visible = true
	set_modulate(Color(1, 1, 1))
	isMoving = true

#When a player and a robot vacuum collide, the player, robot vacuum, cat, and aim pause
func _on_Area2D_body_entered(body):
	if body is player:
		body.pausePlayer()
		robotError()
		emit_signal("catPause")
		emit_signal("aimingPause")

#When Santa's bag and robot vacuum collide, the robot vacuums's movement and aim are paused for a certain period of time
func _on_Santa_bag_vacuumsPause():
	isMoving = false
	emit_signal("aimingPause")
	$Timer.start()

#_on_ray_gameOver() ~ _on_sideRay3_gameOver(): When the game is over, the robot vacuum stops moving
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

#When a player and a cat collide, the robot vacuum stops for a certain amount of time
func _on_Cat_vacuumsPause():
	isMoving = false
	$Timer.start()
	
#Move the robot vacuum to a specific location
func teleport():
	position = Vector2(40, 200)
	isMoving = false
	$hit.start()

#Stop moving for a certain amount of time after teleporting
func _on_hit_timeout():
	isMoving = true
