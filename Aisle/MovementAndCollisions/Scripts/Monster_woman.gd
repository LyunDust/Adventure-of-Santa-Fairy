# Owner: Kim Hyeri

extends KinematicBody2D

class_name MonsterWoman

export (int) var monsterWomanSpeed = 250

var velocity = Vector2()
var monsterwomanXPos
var monsterwomanYPos 
var monsterWomanBlocked = false;

const DIRECTION_RIGHT = 1
const DIRECTION_LEFT = -1
var monsterWomanDirection = Vector2(DIRECTION_RIGHT, 1)


func _init():
	monsterwomanXPos = 153
	monsterwomanYPos = 343


func _ready():
	self.set_position(Vector2(monsterwomanXPos, monsterwomanYPos))
	

func _physics_process(delta):	
	velocity = Vector2()
	
	if !monsterWomanBlocked:
		velocity.x -= 1
		set_direction(DIRECTION_LEFT)
	if monsterWomanBlocked:
		velocity.x += 1
		set_direction(DIRECTION_RIGHT)
	
	velocity = velocity.normalized() * monsterWomanSpeed
	
	var collision = move_and_collide(velocity*delta)
	
	if collision:
		monsterWomanBlocked = !monsterWomanBlocked


func set_direction(hor_direction):
	if hor_direction == 0:
		hor_direction = DIRECTION_RIGHT
	var hor_dir_mod = hor_direction / abs(hor_direction)
	apply_scale(Vector2(hor_dir_mod * monsterWomanDirection.x, 1))
	monsterWomanDirection = Vector2(hor_dir_mod, monsterWomanDirection.y)
