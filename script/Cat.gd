extends KinematicBody2D

class_name Cat

export (int) var speed = 170

var velocity = Vector2()
var yValue
export var direction = 1
var isMoving = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	yValue = rand_range(-1, 1)
	if direction == -1:
		$AnimatedSprite.flip_h = true;
	$sideSensor.position.x = $CollisionShape2D.shape.get_extents().x * direction * 0.5


func _physics_process(delta):
	velocity = velocity.normalized() * speed
	
	if $sideSensor.is_colliding():
		direction = direction * -1
		yValue = rand_range(-2, 2)
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$sideSensor.position.x = $CollisionShape2D.shape.get_extents().x * direction * 0.5
		
	if is_on_wall():
		yValue = rand_range(-2, 2)
	
	if isMoving == true:
		if direction == 1:
			velocity.x += 1
			velocity.y += yValue
		else:
			velocity.x -= 1
			velocity.y += yValue
		
		velocity = move_and_slide(velocity)
	
func catCollision():
	set_modulate(Color(0.5, 0.5, 0.5))
	isMoving = false
	if Global.playerDie ==  false:
		visible = false
	else:
		visible = true
	velocity.x = 0
	$Timer.start()
	$Timer/blink.start()
		

func _on_Timer_timeout():
	$Timer/blink.stop()
	visible = true
	set_modulate(Color(1, 1, 1))
	isMoving = true


func _on_blink_timeout():
	visible = !visible


func _on_Area2D_body_entered(body):
	body.pausePlayer()
	catCollision()

func _on_Santa_bag_catPause():
	isMoving = false
	$Timer.start()
