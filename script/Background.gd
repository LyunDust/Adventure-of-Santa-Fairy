extends StaticBody2D

class_name gameBackground

func _on_Area2D_body_exited(body):
	$StaticBody2D2/startPosition.set_deferred("disabled", false)
