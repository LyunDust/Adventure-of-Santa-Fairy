extends KinematicBody2D

export (int) var speed = 100

var velocity = Vector2()
export var direction = 1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if direction == -1:
		$AnimatedSprite.flip_h = true;
	$sideSensor.position.x = $CollisionShape2D.shape.get_extents().x * direction * 0.5


func _physics_process(delta):
	velocity = velocity.normalized() * speed
	
	if $sideSensor.is_colliding():
		direction = direction * -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$sideSensor.position.x = $CollisionShape2D.shape.get_extents().x * direction * 0.5
	
	if direction == 1:
		velocity.x += 1
	else:
		velocity.x -= 1
		
	velocity = move_and_slide(velocity)
