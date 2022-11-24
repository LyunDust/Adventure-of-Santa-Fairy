#Owner: LeeSoyoung
extends Node2D

var alpha = 0

func _ready():
	$Label.modulate.a = alpha #Set transparency of "Game Over"
	$Label2.visible = false #Hide "Press any key"

func _process(delta):
	if($Label.modulate.a < 1): #Increase transparency of "Game Over" until alpha become 1
		$Label.modulate.a += 0.5*delta
	else:
		$Label2.visible = true #show "Press any key"
		
func _input(event):
	if event is InputEventKey && $Label2.visible == true: #if press any key
		if event.pressed:
			get_tree().change_scene("res://scene/Level 2.tscn") #change scene(restart)
