extends StaticBody2D

class_name santaBag

signal bagBoom
signal playerPause
signal startRay
signal pauseRay
signal catInterruption
signal catPause
signal vacuumsPause
var node

func _on_Area2D_body_entered(body):
	Global.playerDie = false
	if body is vacuums:
		emit_signal("catPause")
		body.robotError()
	elif body is Cat:
		emit_signal("vacuumsPause")
		body.catCollision()
	
	node = body
		
	boom()
	emit_signal("playerPause")
	emit_signal("pauseRay")
	

func boom():
	set_modulate(Color(0.5, 0.5, 0.5))
	visible = false
	$Timer.start()
	$Timer/blink.start()


func _on_blink_timeout():
	visible = !visible


func _on_Timer_timeout():
	$Timer/blink.stop()
	visible = true
	set_modulate(Color(1, 1, 1))
	if node is vacuums:
		emit_signal("bagBoom")
	elif node is Cat :
		emit_signal("catInterruption")
	emit_signal("startRay")
