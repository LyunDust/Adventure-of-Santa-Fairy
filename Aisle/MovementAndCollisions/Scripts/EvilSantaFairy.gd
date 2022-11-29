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
		if !evilSantaFairyBlocked:
			velocity.x += 1
			animation.play("run")
	else:
		velocity.x += 0
	
	velocity = velocity.normalized() * evilSantaFairySpeed
	
	var collision = move_and_collide(velocity*delta)
	
	if collision:
		evilSantaFairyBlocked = !evilSantaFairyBlocked


func _on_Player_isHeAlived(isHeAlive):
	if !isHeAlive:
		animation.stop()
		playerDie = true
	else:
		playerDie = false
		self._ready()
