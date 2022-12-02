# Owner: Kim Hyeri
# This script is attached to UI_Text node

extends CanvasLayer

class_name AisleUI

# UI texts
onready var text_pressKeyHide = $PressKey_hide
onready var text_pressKeyDeco = $PressKey_deco
onready var text_itemCount = $ItemCount
onready var text_gameover = $GameOver


func _on_Player_isHeAlived(isHeAlive):
	
	# when the player is dead, all UI text isn't visible except the text of gameover
	if !isHeAlive:
		text_pressKeyHide.visible = false
		text_pressKeyDeco.visible = false
		text_itemCount.visible = false
		text_gameover.visible = true
		
	# when the player restart the game, the text of gameover isn't visible and the text of item is visible
	else:
		text_itemCount.visible = true
		text_gameover.visible = false
