# Owner: Kim Hyeri
# This script is attached to Monster_man.tscn

extends KinematicBody2D

class_name MonsterMan

# variables for moving
export (int) var monsterManSpeed = 350
var velocity = Vector2()

# variables for monster man's position
var monsterManXPos
var monsterManYPos

# variable for bouncing when man collide with blocks
var monsterManBlocked = false

# variable for gameover and restart
var playerDie = false

# variables for flip horizontally
const DIRECTION_RIGHT = 1
const DIRECTION_LEFT = -1
var monsterManDirection = Vector2(DIRECTION_RIGHT, 1)

# audio
onready var audio_player = $AudioStreamPlayer2D


# set the monster man's position
func _init():
	monsterManXPos = 3700
	monsterManYPos = 331
	

func _ready():
	self.set_position(Vector2(monsterManXPos, monsterManYPos))


func _physics_process(delta):	
	velocity = Vector2()
	
	if !playerDie:
		# when the monster man collide with something, the man's direction is changed
		if !monsterManBlocked:
			velocity.x -= 1
			set_direction(DIRECTION_LEFT)
		if monsterManBlocked:
			velocity.x += 1
			set_direction(DIRECTION_RIGHT)
		if !audio_player.is_playing():
			audio_player.play()	
	
	# when the player is dead, the man stop to move
	else:
		velocity.x += 0
	
	velocity = velocity.normalized() * monsterManSpeed
	
	var collision = move_and_collide(velocity*delta)
	
	if collision:
		monsterManBlocked = !monsterManBlocked


# function for changing the man's direction
func set_direction(hor_direction):
	if hor_direction == 0:
		hor_direction = DIRECTION_RIGHT
	var hor_dir_mod = hor_direction / abs(hor_direction)
	apply_scale(Vector2(hor_dir_mod * monsterManDirection.x, 1))
	monsterManDirection = Vector2(hor_dir_mod, monsterManDirection.y)


func _on_Player_isHeAlived(isHeAlive):
	
	# if the player is dead, the man's audio is stopped and change the variable's state for gameover
	if !isHeAlive:
		audio_player.stop()
		playerDie = true
	
	# if the player try to restart, the man's position is reset
	else:
		playerDie = false
		self._ready()
