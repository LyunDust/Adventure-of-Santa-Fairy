# Owner: Kim Hyeri
# This script is attached to Box.tscn

extends Area2D

class_name Box

# UI texts
onready var text_pressKeyHide = get_node("/root/Aisle/UI_Text/PressKey_hide")

# variables for box's position
var boxXPos
var boxYPos


# set the box's position
func _init():
	boxXPos = 0
	boxYPos = 517


# set the box's position randomly
func _ready():
	boxXPos = rand_range(80, 3700)	
	self.set_position(Vector2(boxXPos, boxYPos))


# if the player collide with box, the UI text is visible
func _on_Box_body_entered(body):
	if body is AislePlayer:
		text_pressKeyHide.visible = true

# if the player doens't collide with box, the UI text isn't visible
func _on_Box_body_exited(body):
	if body is AislePlayer:
		text_pressKeyHide.visible = false


# if the player try to restart, the box's position is reset
func _on_Player_isHeAlived(isHeAlive):
	if isHeAlive:
		self._ready()
