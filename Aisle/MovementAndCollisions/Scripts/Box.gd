# Owner: Kim Hyeri

extends Area2D

class_name Box

onready var text_pressKeyHide = get_node("/root/Aisle/Player/UI_Text/PressKey_hide")

var boxXPos
var boxYPos


func _init():
	boxXPos = 0
	boxYPos = 517


func _ready():
	boxXPos = rand_range(80, 3700)	
	self.set_position(Vector2(boxXPos, boxYPos))


func _on_Box_body_entered(body):
	if body is AislePlayer:
		text_pressKeyHide.visible = true


func _on_Box_body_exited(body):
	if body is AislePlayer:
		text_pressKeyHide.visible = false


func _on_Player_isHeAlived(isHeAlive):
	if isHeAlive:
		self._ready()
