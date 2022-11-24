extends Control

class_name AisleUI

onready var gameover = get_node("GameOver")
onready var hide = get_node("/root/Aisle/Player/UI_Text/PressKey_hide")
onready var deco = get_node("/root/Aisle/Player/UI_Text/PressKey_deco")


func _on_Player_isHeAlived(isHeAlive):
	if !isHeAlive:
		hide.visible = false
		deco.visible = false
		gameover.visible = true
		print("gameover")
