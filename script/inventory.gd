extends Area2D

func _ready():
	$item1.visible = true
	$item2.visible = false


func _on_Level_2_changeItem():
	$item1.visible = !$item1.visible
	$item2.visible = !$item2.visible
