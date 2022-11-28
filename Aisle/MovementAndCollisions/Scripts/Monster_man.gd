# Owner: Kim Hyeri

extends KinematicBody2D

class_name MonsterMan

export (int) var monsterManSpeed = 350

var velocity = Vector2()
var monsterManXPos = 3700
var monsterManYPos = 331
var monsterManBlocked = false;

const DIRECTION_RIGHT = 1
const DIRECTION_LEFT = -1
var monsterManDirection = Vector2(DIRECTION_RIGHT, 1)


func _ready():
	self.set_position(Vector2(monsterManXPos, monsterManYPos))


func _physics_process(delta):	
	velocity = Vector2()
	
	if !monsterManBlocked:
		velocity.x -= 1
		set_direction(DIRECTION_LEFT)
	if monsterManBlocked:
		velocity.x += 1
		set_direction(DIRECTION_RIGHT)
	
	velocity = velocity.normalized() * monsterManSpeed
	
	var collision = move_and_collide(velocity*delta)
	
	if collision:
		monsterManBlocked = !monsterManBlocked
		


func set_direction(hor_direction):
	if hor_direction == 0:
		hor_direction = DIRECTION_RIGHT
	var hor_dir_mod = hor_direction / abs(hor_direction)
	apply_scale(Vector2(hor_dir_mod * monsterManDirection.x, 1))
	monsterManDirection = Vector2(hor_dir_mod, monsterManDirection.y)
