# Owner: Kim Hyeri
# This script is attached to Item1.tscn ~ Item7.tscn

extends Area2D

class_name Item

# variables for item's position
var itemXPos
var itemYPos


# set the item's position
func _init():
	itemXPos = 0
	itemYPos = 520


# set the item's position randomly
func _ready():
	var tmpXPos1 = rand_range(100, 1700)	
	var tmpXPos2 = rand_range(2140, 3700)
	var randomValue = randf()
	if randomValue < 0.5:
		itemXPos = tmpXPos1
	else:
		itemXPos = tmpXPos2
	self.set_position(Vector2(itemXPos, itemYPos))


# if the player collide with item, the item move to the position that the player can't see it
func _on_Item_body_entered(body):
	if body is AislePlayer:
		self.set_position(Vector2(-100, -100))


# if the player collide with the evil, all the items' position is reset randomly
func _on_Player_itemReset(itemReset):
	itemXPos = rand_range(100, 3700)	
	self.set_position(Vector2(itemXPos, itemYPos))


# if the player try to restart, the item's position is reset
func _on_Player_isHeAlived(isHeAlive):
	if isHeAlive:
		self._ready()
