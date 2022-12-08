#Owner: LeeSoyoung
extends Area2D

#It is the same as ray.gd except probability and sensor orientation

var num
var isSeeing = false
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
	$sensor1.position.y = $CollisionShape2D.shape.get_extents().y-12
	$sensor2.position.y = $CollisionShape2D.shape.get_extents().y-3

func _physics_process(_delta):
	if isSeeing == true:
		if $sensor1.is_colliding() or $sensor2.is_colliding():
			emit_signal("gameOver")
			if !gameOverSound.is_playing():
				gameOverSound.play()
			$Timer2.start()
			isSeeing = false


func _on_rayTimer_timeout():
	$raySprite.visible = false
	isSeeing = false	


func _on_textBalloonTimer_timeout():
	num = rand_range(0, 10)
	if num > 6:
		$textBalloon.visible = true
		$raySprite.visible = true
		$raySprite.set_modulate(Color(1, 1, 1, 0.3))
		$textBalloonTimer/smallTimer.start()


func _on_smallTimer_timeout():
	$textBalloon.visible = false
	isSeeing = true
	if !laserBeamSound.is_playing():
		laserBeamSound.play()
	$raySprite.set_modulate(Color(1, 1, 1, 1))
	$rayTimer.start()


func _on_Player_pauseRay():
	$rayTimer.paused = true
	$textBalloonTimer.paused = true
	$textBalloonTimer/smallTimer.paused = true


func _on_Player_startRay():
	$rayTimer.paused = false
	$textBalloonTimer.paused = false
	$textBalloonTimer/smallTimer.paused = false


func _on_Timer2_timeout():
	get_tree().change_scene("res://scene/GameOver.tscn")


func _on_sideRay_gameOver():
	$rayTimer.paused = true
	$textBalloonTimer.paused = true
	$textBalloonTimer/smallTimer.paused = true
