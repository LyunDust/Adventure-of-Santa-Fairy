extends Node

# variable for gameover and restart
var playerDie = false

# audio for background music
onready var audio_player = $AudioStreamPlayer


func _ready():
	if !audio_player.is_playing():
		audio_player.play()	


func _on_Player_isHeAlived(isHeAlive):
	
	# if the player is dead, the audio is stopped and change the variable's state for gameover
	if !isHeAlive:
		audio_player.stop()
		playerDie = true
	
	# if the player try to restart, the audio is restart
	else:
		playerDie = false
		self._ready()
