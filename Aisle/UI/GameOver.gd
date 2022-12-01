# Owner: Kim Hyeri

extends Control

class_name AisleUI

onready var text_pressKeyHide = $PressKey_hide
onready var text_pressKeyDeco = $PressKey_deco
onready var text_itemCount = $ItemCount
onready var text_gameover = $GameOver


func _on_Player_isHeAlived(isHeAlive):
	if !isHeAlive:
		text_pressKeyHide.visible = false
		text_pressKeyDeco.visible = false
		text_itemCount.visible = false
		text_gameover.visible = true
	else:
		text_itemCount.visible = true
		text_gameover.visible = false
