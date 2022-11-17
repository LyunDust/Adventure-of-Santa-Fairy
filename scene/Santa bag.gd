extends StaticBody2D

signal bagBoom

func _on_Area2D_body_entered(body):
	body.robotError()
	boom()
	

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
	emit_signal("bagBoom")
