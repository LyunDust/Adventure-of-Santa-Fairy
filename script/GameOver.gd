extends Node2D


var alpha = 0

func _ready():
	$Label.modulate.a = alpha
	$Label2.visible = false


func _process(delta):
	if($Label.modulate.a < 1):
		$Label.modulate.a += 0.5*delta
	else:
		$Label2.visible = true
		

func _input(event):
	if event is InputEventKey && $Label2.visible == true:
		if event.pressed:
			get_tree().change_scene("res://scene/Level 2.tscn")
