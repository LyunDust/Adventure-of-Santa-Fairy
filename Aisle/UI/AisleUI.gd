extends Control

class_name AisleUI



func _on_Player_isHeAlived(isHeAlive):
	if !isHeAlive:
		get_node("GameOver").visible = !get_node("GameOver").visible
