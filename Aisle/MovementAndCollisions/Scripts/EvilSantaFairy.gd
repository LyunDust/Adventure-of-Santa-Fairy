# Owner: Kim Hyeri

extends KinematicBody2D

class_name EvilSantaFairy

export (int) var evilSantaFairySpeed = 100

var velocity = Vector2()
var EvilSantaFairyXPos
var EvilSantaFairyYPos
var evilSantaFairyBlocked = false

var playerDie = false

const DIRECTION_RIGHT = 1
const DIRECTION_LEFT = -1
var evilSantaFairyDirection = Vector2(DIRECTION_RIGHT, 1)

onready var animation = $AnimationPlayer


func _init():
	EvilSantaFairyXPos = 0
	EvilSantaFairyYPos = 500


func _ready():
	EvilSantaFairyXPos = rand_range(100, 3700)	
	self.set_position(Vector2(EvilSantaFairyXPos, EvilSantaFairyYPos))


func _physics_process(delta):	
	velocity = Vector2()
	
	if !playerDie:
		if evilSantaFairyBlocked:
			velocity.x -= 1
			animation.play("run_left")
#			set_direction(DIRECTION_LEFT)
		if !evilSantaFairyBlocked:
			velocity.x += 1
			animation.play("run")
#			set_direction(DIRECTION_RIGHT)
	else:
		velocity.x += 0
	
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


func _on_Player_isHeAlived(isHeAlive):
	animation.stop()
	playerDie = true
