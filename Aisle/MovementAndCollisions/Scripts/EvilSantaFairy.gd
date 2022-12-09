# Owner: Kim Hyeri
# This script is attached to EvilSantaFairy.tscn

extends KinematicBody2D

class_name EvilSantaFairy

# variables for moving
export (int) var evilSantaFairySpeed = 100
var velocity = Vector2()

# variables for evil's position
var EvilSantaFairyXPos
var EvilSantaFairyYPos

# variable for bouncing when he collide with something
var evilSantaFairyBlocked = false

# variable for gameover and restart
var playerDie = false

# animation and audio
onready var animation = $AnimationPlayer
onready var audio_player = $AudioStreamPlayer2D

# set the evil's position
func _init():
	EvilSantaFairyXPos = 0
	EvilSantaFairyYPos = 500


# set the evil's position randomly
func _ready():
	var tmpXPos1 = rand_range(100, 1700)	
	var tmpXPos2 = rand_range(2140, 3700)
	var randomValue = randf()
	if randomValue < 0.5:
		EvilSantaFairyXPos = tmpXPos1
	else:
		EvilSantaFairyXPos = tmpXPos2
	self.set_position(Vector2(EvilSantaFairyXPos, EvilSantaFairyYPos))


func _physics_process(delta):	
	velocity = Vector2()
	
	if !playerDie:
		# when the evil collide with something, the evil's direction is changed
		if evilSantaFairyBlocked:
			velocity.x -= 1
			animation.play("run_left")
		if !evilSantaFairyBlocked:
			velocity.x += 1
			animation.play("run")
		if !audio_player.is_playing():
			audio_player.play()	
	
	# when the player is dead, the evil stop to move
	else:
		velocity.x += 0
	
	velocity = velocity.normalized() * evilSantaFairySpeed
	
	var collision = move_and_collide(velocity*delta)
	
	if collision:
		evilSantaFairyBlocked = !evilSantaFairyBlocked
	
	


func _on_Player_isHeAlived(isHeAlive):
	
	# if the player is dead, the evil's animation and audio are stopped and change the variable's state for gameover
	if !isHeAlive:
		animation.stop()
		audio_player.stop()
		playerDie = true
	
	# if the player try to restart, the evil's position is reset
	else:
		playerDie = false
		self._ready()
