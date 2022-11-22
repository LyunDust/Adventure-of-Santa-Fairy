extends Control

class_name AisleUI

onready var player = get_node("root/Aisle/Player")


func _on_Player_isHeAlived(isHeAlive):
	if !isHeAlive:
		get_node("GameOver").visible = !get_node("GameOver").visible
