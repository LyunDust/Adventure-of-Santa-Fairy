#Owner: LeeSoyoung
extends KinematicBody2D

class_name Cat

var speed = 140

var velocity = Vector2()
var yValue
export var direction = 1
var isMoving = true #Variables to Control Cat's movement
signal vacuumsPause
signal aimingPause
var target
var isFollowing = false #Variables to Determine How Cats Move


func _ready():
	randomize()
	isMoving = true
	yValue = rand_range(-1, 1)
	if direction == -1:
		$AnimatedSprite.flip_h = true;
	$sideSensor.position.x = $CollisionShape2D.shape.get_extents().x * direction * 0.5
	$AnimatedSprite.playing = true
	target = position
	Global.toyArrive = false


func _physics_process(_delta):
	#If the item is in the target position, change isFollowing to true and change the direction 
	#of the cat's sprite, movement direction, and sensor direction depending on the item's position
	if Global.toyArrive == true:
		isFollowing = true
		if target > position:
			$AnimatedSprite.flip_h = false
			direction = 1
			$sideSensor.position.x = $CollisionShape2D.shape.get_extents().x * direction * 0.5
		elif target < position:
			$AnimatedSprite.flip_h = true
			direction = -1
			$sideSensor.position.x = $CollisionShape2D.shape.get_extents().x * direction * 0.5
	else:
		isFollowing = false
	
	velocity = velocity.normalized() * speed
	
	#When the sensor collides, it reverses the direction of movement with the sensor 
	#and randomly changes the amount of movement in the y direction.
	if $sideSensor.is_colliding():
		direction = direction * -1
		yValue = rand_range(-2, 2)
		$sideSensor.position.x = $CollisionShape2D.shape.get_extents().x * direction * 0.5
		
	#If it collides with the wall, it randomly changes the amount to move in the y direction
	if is_on_wall():
		yValue = rand_range(-2, 2)
	
	if isMoving == true:
		#If isFollowing is false, it moves consistently according to the direction until it hits the wall
		if isFollowing == false:
			if direction == 1:
				$AnimatedSprite.flip_h = false
				velocity.x += 1
				velocity.y += yValue
			else:
				velocity.x -= 1
				$AnimatedSprite.flip_h = true
				velocity.y += yValue
			velocity = move_and_slide(velocity)
		#If isFollowing is true, follow the target position. Even if cat arrive at the location,
		#cat will be there until isFollowing is false
		else:
			velocity = position.direction_to(target) * speed
			if position.distance_to(target) > 5:
				velocity = move_and_slide(velocity)
		
	
#After changing the cat a little dark, stop moving for a certain amount of time
func catCollision():
	set_modulate(Color(0.5, 0.5, 0.5))
	isMoving = false
	if Global.playerDie ==  false:
		visible = false
	else:
		visible = true
	velocity.x = 0
	$AnimatedSprite.playing = false
	
	$Timer.start()
	$Timer/blink.start()
		
#When the timer is over, stop the blinking effect and allow the cat to move again.
func _on_Timer_timeout():
	$Timer/blink.stop()
	visible = true
	set_modulate(Color(1, 1, 1))
	isMoving = true
	$AnimatedSprite.playing = true

#the effect of a cat blinking
func _on_blink_timeout():
	visible = !visible

#When a cat collides with a player, it stops the player, cat, robot vacuum, and aiming
func _on_Area2D_body_entered(body):
	if body is player:
		body.pausePlayer()
		catCollision()
		emit_signal("vacuumsPause")
		emit_signal("aimingPause")

#When Santa bag collides with the cat, it stops aiming and cat
func _on_Santa_bag_catPause():
	isMoving = false
	$AnimatedSprite.playing = false
	emit_signal("aimingPause")
	$Timer.start()

#_on_ray_gameOver() ~ _on_sideRay3_gameOver():
#When the game is over, the cat stops moving and animation
func _on_ray_gameOver():
	isMoving = false
	$AnimatedSprite.playing = false

func _on_ray2_gameOver():
	isMoving = false
	$AnimatedSprite.playing = false

func _on_ray3_gameOver():
	isMoving = false
	$AnimatedSprite.playing = false

func _on_ray4_gameOver():
	isMoving = false
	$AnimatedSprite.playing = false

func _on_sideRay_gameOver():
	isMoving = false
	$AnimatedSprite.playing = false

func _on_sideRay2_gameOver():
	isMoving = false
	$AnimatedSprite.playing = false

func _on_sideRay3_gameOver():
	isMoving = false
	$AnimatedSprite.playing = false

#When a robot vacuum and player collide, the cat stops moving and animation
func _on_Robot_vacuums_catPause():
	isMoving = false
	$AnimatedSprite.playing = false
	$Timer.start()

#Save the location where the thrown item will arrive in the variable target
func _on_Level_2_toyArrive(pos):
	target = pos
