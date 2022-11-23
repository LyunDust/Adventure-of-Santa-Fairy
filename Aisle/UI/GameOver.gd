extends Control

class_name AisleUI

onready var gameover = get_node("GameOver")


func _on_Player_isHeAlived(isHeAlive):
	if !isHeAlive:
		gameover.visible = !gameover.visible
