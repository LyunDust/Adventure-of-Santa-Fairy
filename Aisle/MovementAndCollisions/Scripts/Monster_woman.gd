# Owner: Kim Hyeri
# This script is attached to Monster_woman.tscn

extends KinematicBody2D

class_name MonsterWoman

# variables for moving
export (int) var monsterWomanSpeed = 250
var velocity = Vector2()

# variables for monster woman's position
var monsterwomanXPos
var monsterwomanYPos 

# variable for bouncing when the woman collide with blocks
var monsterWomanBlocked = false

# variable for gameover and restart
var playerDie = false

# variables for flip horizontally
const DIRECTION_RIGHT = 1
const DIRECTION_LEFT = -1
var monsterWomanDirection = Vector2(DIRECTION_RIGHT, 1)

# audio
onready var audio_player = $AudioStreamPlayer2D


# set the monster woman's position
func _init():
	monsterwomanXPos = 153
	monsterwomanYPos = 343


func _ready():
	self.set_position(Vector2(monsterwomanXPos, monsterwomanYPos))
	

func _physics_process(delta):	
	velocity = Vector2()
	
	if !playerDie:
		# when the monster woman collide with something, the woman's direction is changed
		if !monsterWomanBlocked:
			velocity.x -= 1
			set_direction(DIRECTION_LEFT)
		if monsterWomanBlocked:
			velocity.x += 1
			set_direction(DIRECTION_RIGHT)
		if !audio_player.is_playing():
			audio_player.play()	
	
	# when the player is dead, the woman stop to move
	else:
		velocity.x += 0
	
	velocity = velocity.normalized() * monsterWomanSpeed
	
	var collision = move_and_collide(velocity*delta)
	
	if collision:
		monsterWomanBlocked = !monsterWomanBlocked


# function for changing the woman's direction
func set_direction(hor_direction):
	if hor_direction == 0:
		hor_direction = DIRECTION_RIGHT
	var hor_dir_mod = hor_direction / abs(hor_direction)
	apply_scale(Vector2(hor_dir_mod * monsterWomanDirection.x, 1))
	monsterWomanDirection = Vector2(hor_dir_mod, monsterWomanDirection.y)


func _on_Player_isHeAlived(isHeAlive):
	
	# if the player is dead, the woman's audio is stopped and change the variable's state for gameover
	if !isHeAlive:
		audio_player.stop()
		playerDie = true
	
	# if the player try to restart, the woman's position is reset
	else:
		playerDie = false
		self._ready()
