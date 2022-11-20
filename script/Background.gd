extends StaticBody2D


func _on_Area2D_body_exited(body):
	$startPosition.set_deferred("disabled", false)
