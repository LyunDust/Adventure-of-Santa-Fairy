extends Area2D

func _on_bluePresnet_body_entered(body):
	queue_free()
	Global.presentNum -= 1
	print(Global.presentNum)
	
	if Global.presentNum == 0:
		get_tree().paused = true
		print('game clear!!')
