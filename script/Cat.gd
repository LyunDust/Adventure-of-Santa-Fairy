extends KinematicBody2D

class_name Cat

export (int) var speed = 140

var velocity = Vector2()
var yValue
export var direction = 1
var isMoving = true
signal vacuumsPause
signal aimingPause
var target
var isFollowing = false


func _ready():
	randomize()
	isMoving = true
	yValue = rand_range(-1, 1)
	if direction == -1:
		$AnimatedSprite.flip_h = true;
	$sideSensor.position.x = $CollisionShape2D.shape.get_extents().x * direction * 0.5
	$AnimatedSprite.playing = true
	target = position


func _physics_process(delta):
	if Global.toyArrive == true:
		isFollowing = true
		if target > position:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
	else:
		isFollowing = false
	
	velocity = velocity.normalized() * speed
	
	if $sideSensor.is_colliding():
		direction = direction * -1
		yValue = rand_range(-2, 2)
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$sideSensor.position.x = $CollisionShape2D.shape.get_extents().x * direction * 0.5
		
	if is_on_wall():
		yValue = rand_range(-2, 2)
	
	if isMoving == true:
		if isFollowing == false:
			if direction == 1:
				velocity.x += 1
				velocity.y += yValue
			else:
				velocity.x -= 1
				velocity.y += yValue
			velocity = move_and_slide(velocity)
		else: #isFollowing이 true인 경우에는 타겟 위치를 따라감, 위치에 도착해도 isFollowing이 true가 되기 전까지는 그 자리에 있음
			velocity = position.direction_to(target) * speed
			if position.distance_to(target) > 5:
				velocity = move_and_slide(velocity)
		
		
	
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
		

func _on_Timer_timeout():
	$Timer/blink.stop()
	visible = true
	set_modulate(Color(1, 1, 1))
	isMoving = true
	$AnimatedSprite.playing = true


func _on_blink_timeout():
	visible = !visible


func _on_Area2D_body_entered(body):
	if body is player:
		body.pausePlayer()
		catCollision()
		emit_signal("vacuumsPause")
		emit_signal("aimingPause")

func _on_Santa_bag_catPause():
	isMoving = false
	$AnimatedSprite.playing = false
	emit_signal("aimingPause")
	$Timer.start()


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


func _on_Robot_vacuums_catPause():
	isMoving = false
	$AnimatedSprite.playing = false
	$Timer.start()

func _on_Level_2_toyArrive(pos):
	target = pos
