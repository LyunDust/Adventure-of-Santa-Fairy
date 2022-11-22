extends KinematicBody2D

class_name EvilSantaFairy

export (int) var evilSantaFairySpeed = 100

var velocity = Vector2()

var evilSantaFairyBlocked = false;

const DIRECTION_RIGHT = 1
const DIRECTION_LEFT = -1
var evilSantaFairyDirection = Vector2(DIRECTION_RIGHT, 1)


func _physics_process(delta):	
	velocity = Vector2()
	
	if !evilSantaFairyBlocked:
		velocity.x -= 1
		set_direction(DIRECTION_LEFT)
	if evilSantaFairyBlocked:
		velocity.x += 1
		set_direction(DIRECTION_RIGHT)
	
	velocity = velocity.normalized() * evilSantaFairySpeed
	
	var collision = move_and_collide(velocity*delta)
	
	if collision:
		evilSantaFairyBlocked = !evilSantaFairyBlocked


func set_direction(hor_direction):
	if hor_direction == 0:
		hor_direction = DIRECTION_RIGHT
	var hor_dir_mod = hor_direction / abs(hor_direction)
	apply_scale(Vector2(hor_dir_mod * evilSantaFairyDirection.x, 1))
	evilSantaFairyDirection = Vector2(hor_dir_mod, evilSantaFairyDirection.y)
