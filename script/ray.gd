extends Area2D

var num
var isSeeing = false
signal gameOver

func _ready():
	$textBalloon.visible = false
	randomize()
	$raySprite.visible = false
	$textBalloonTimer.start()
	$sensor.position.x = $CollisionShape2D.shape.get_extents().x-12
	$sensor2.position.x = $CollisionShape2D.shape.get_extents().x-3

func _physics_process(delta):
	if isSeeing == true:
		if $sensor.is_colliding() or $sensor2.is_colliding():
			emit_signal("gameOver")
			$Timer2.start()
			isSeeing = false


func _on_rayTimer_timeout():
	$raySprite.visible = false
	isSeeing = false


func _on_textBalloonTimer_timeout():
	num = rand_range(0, 10)
	if num > 2:
		$textBalloon.visible = true
		$raySprite.visible = true
		$raySprite.set_modulate(Color(1, 1, 1, 0.3))
		$textBalloonTimer/smallTimer.start()


func _on_smallTimer_timeout():
	$textBalloon.visible = false
	isSeeing = true
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


func _on_ray_gameOver():
	$rayTimer.paused = true
	$textBalloonTimer.paused = true
	$textBalloonTimer/smallTimer.paused = true
