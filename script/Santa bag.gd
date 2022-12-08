#Owner: LeeSoyoung
extends StaticBody2D

class_name santaBag

signal bagBoom #All the presents player collected were scattered
signal playerPause
signal catInterruption #One of the presents player collected was scattered
signal catPause
signal vacuumsPause
var node

func _on_Area2D_body_entered(body):
	#Invoke a function to pause the vacuum vacuum and send a signal to pause the cat
	if body is vacuums:
		emit_signal("catPause")
		body.robotError()

	#Invoke a function to pause the cat and send a signal to pause the robot vacuum
	elif body is Cat:
		emit_signal("vacuumsPause")
		body.catCollision()

	
	#Save body for use in other functions
	node = body
		
	boom()
	#Sends a signal that pauses the player
	emit_signal("playerPause")
	
#Effect over a period of time
func boom():
	
	var t = Timer.new()
	t.set_wait_time(0.5)
	t.set_one_shot(true)
	self.add_child(t)
	if !$"../EffectSound/ResetGift".is_playing():
			$"../EffectSound/ResetGift".play()
	t.start()
	yield(t, "timeout")
	if !$"../EffectSound/ResetGift".is_playing():
			$"../EffectSound/ResetGift".play()
	t.queue_free()
	
	set_modulate(Color(0.5, 0.5, 0.5))
	visible = false
	$Timer.start()
	$Timer/blink.start()

#the effect of blinking
func _on_blink_timeout():
	visible = !visible

#Stop the blinking effect and send a different signal depending on the node
func _on_Timer_timeout():
	$Timer/blink.stop()
	visible = true
	set_modulate(Color(1, 1, 1))
	if node is vacuums:
		emit_signal("bagBoom")
	elif node is Cat :
		emit_signal("catInterruption")
