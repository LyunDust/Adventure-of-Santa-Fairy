extends Area2D

func _on_bluePresnet_body_entered(body):
	queue_free()
	Global.presentNum -= 1
