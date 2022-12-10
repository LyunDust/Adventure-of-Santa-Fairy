#Owner: LeeSoyoung
extends Area2D

var num
var isSeeing = false #Variables to distinguish when ray comes out
signal gameOver
var laserBeamSound
var gameOverSound

func _ready():
	laserBeamSound = $"../EffectSound/Laser Beam"
	gameOverSound = $"../EffectSound/GameOver"
	$textBalloon.visible = false
	randomize()
	$raySprite.visible = false
	$textBalloonTimer.start()
	#Setting the position of the sensor
	$sensor.position.x = $CollisionShape2D.shape.get_extents().x-12
	$sensor2.position.x = $CollisionShape2D.shape.get_extents().x-3

func _physics_process(_delta):
	if isSeeing == true:
		#When a sensor collides with a player, it sends a game over signal
		if $sensor.is_colliding() or $sensor2.is_colliding():			
			emit_signal("gameOver")
			if !gameOverSound.is_playing():
				gameOverSound.play()
			$Timer2.start()
			isSeeing = false

#If rayTimer times out, hide raySprite
func _on_rayTimer_timeout():
	$raySprite.visible = false
	isSeeing = false

func _on_textBalloonTimer_timeout():
	#If the random number is greater than 5, it shows the location of the ray in advance
	num = rand_range(0, 10)
	if num > 5:
		$textBalloon.visible = true
		$raySprite.visible = true
		$raySprite.set_modulate(Color(1, 1, 1, 0.3))
		$textBalloonTimer/smallTimer.start()


func _on_smallTimer_timeout():
	#Finish showing it in advance and shoot a ray
	$textBalloon.visible = false
	isSeeing = true
	if !laserBeamSound.is_playing():
		laserBeamSound.play()
	$raySprite.set_modulate(Color(1, 1, 1, 1))
	$rayTimer.start()


#Pause the timer to stop the ray
func _on_Player_pauseRay():
	$rayTimer.paused = true
	$textBalloonTimer.paused = true
	$textBalloonTimer/smallTimer.paused = true

#Unpause the timer to allow the ray to operate continuously
func _on_Player_startRay():
	$rayTimer.paused = false
	$textBalloonTimer.paused = false
	$textBalloonTimer/smallTimer.paused = false

#Change to game over scene after 0.5 second delay
func _on_Timer2_timeout():
	if !gameOverSound.is_playing():
		gameOverSound.play()
	get_tree().change_scene("res://scene/GameOver.tscn")

#When the game over signal is received, all timers except Timer 2 are stopped
func _on_ray_gameOver():
	BackGroundMusic.pause_level2SceneMusic()
	$rayTimer.paused = true
	$textBalloonTimer.paused = true
	$textBalloonTimer/smallTimer.paused = true
