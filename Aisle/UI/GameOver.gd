# Owner: Kim Hyeri

extends Control

class_name AisleUI

onready var hide = get_node("/root/Aisle/Player/UI_Text/PressKey_hide")
onready var deco = get_node("/root/Aisle/Player/UI_Text/PressKey_deco")
onready var item = get_node("/root/Aisle/Player/UI_Text/ItemCount")
onready var gameover = get_node("/root/Aisle/Player/UI_Text/GameOver")

func _on_Player_isHeAlived(isHeAlive):
	if !isHeAlive:
		hide.visible = false
		deco.visible = false
		item.visible = false
		gameover.visible = true
		print("gameover")
