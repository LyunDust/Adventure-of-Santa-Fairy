# Owner: Kim Hyeri
# This script is attached to AislePlayer.tscn

extends KinematicBody2D

class_name AislePlayer

# variables for moving
export (int) var playerSpeed = 150
var velocity = Vector2()

# variables for setting player's first position
var aislePlayerXPos
var aislePlayerYPos

# variables for animation 
var input = false		# if input is false, the animation is stopped
var sitdown = false		# if sitdown is false, the player can move left or right
var collideWithBox = false		# if collideWithBox is true, the player can hide in the box to press key

# variables for items
var itemNoReset = false		# if the player hided in the box, it is changed to true (if it is true, item doesn't reset eventhough the player collided with EvilSantaFairy)
var itemList = 7		# the number of total items
var itemCount = 0		# the number of items collected by the player
var decoPossible = false		# if the player collect all items, it is changed to true (if it is true, the player can decorate the tree)

# variable for gameover and restart
var playerDie = false

# signals about gameover, getting items, resetting items
signal isHeAlived (isHeAlive)
signal getItem (getItem)
signal itemReset (itemReset)

# UI texts
onready var text_pressKeyHide = get_node("/root/Aisle/UI_Text/PressKey_hide")
onready var text_pressKeyDeco = get_node("/root/Aisle/UI_Text/PressKey_deco")
onready var text_decorate =  get_node("/root/Aisle/UI_Text/Decorate")
onready var text_itemCount =  get_node("/root/Aisle/UI_Text/ItemCount")

# animation and audio
onready var animation = $AnimationPlayer
onready var audio_player = $AudioStreamPlayer

# set the player's position
func _init():
	aislePlayerXPos = 1920
	aislePlayerYPos = 500


func _ready():
	itemCount = 0
	decoPossible = false	
	self.set_position(Vector2(aislePlayerXPos, aislePlayerYPos))
	# set the text about items collected
	text_itemCount.text = "Items: " + str(itemCount) + " / " + str(itemList)


# getting input and playing animations, audio
func get_input():
	velocity = Vector2()
	
	if !playerDie:
		
		# the player move right
		if Input.is_action_pressed("ui_right"):
			velocity.x += 1
			animation.play("run")
			if !audio_player.is_playing():
				audio_player.play()	
			input = true
			sitdown = false
			itemNoReset = false
		
		# the player move left
		if Input.is_action_pressed("ui_left"):
			velocity.x -= 1
			animation.play("run_left")
			if !audio_player.is_playing():
				audio_player.play()	
			input = true
			sitdown = false
			itemNoReset = false
		
		# the player sit down
		if Input.is_action_pressed("ui_down"):
			animation.play("sitdown")
			audio_player.stop()
			sitdown = true
			input = true
			itemNoReset = false
		
		if Input.is_action_pressed("interact"):
			
			# the player hide in the box
			if collideWithBox:
				animation.play("inTheBox")
				text_pressKeyHide.visible = false
				itemNoReset = true
			
			# the player decorate the tree and the scene is changed to the next scene
			if decoPossible:
				text_decorate.visible = true
				text_pressKeyHide.visible = false
				text_pressKeyDeco.visible = false
				#get_tree().paused = true
				get_tree().change_scene("res://scenes/HumanWorldStory.tscn")
				#PSY added

	# when the player is dead, the player try to restart

	else:
		if Input.is_action_pressed("interact"):
			emit_signal("isHeAlived", true)
	
	# if the player doesn't sit, the player can move
	if !sitdown:
		velocity = velocity.normalized() * playerSpeed


func _physics_process(delta):
	get_input()
	
	# set the text about items collected
	text_itemCount.text = "Items: " + str(itemCount) + " / " + str(itemList)
	
	# if the player doesn't die, the player can move
	if !playerDie:
		move_and_collide(velocity*delta)

	# if the player doesn't move, the player's animation is stopped
	if !input:
		animation.stop()
		audio_player.stop()
	
	input = false


# the player collide with box, the player can hide in the box
func _on_Box_body_entered(body):
	collideWithBox = true

# the player doesn't collide with box, the player can't hide in the box
func _on_Box_body_exited(body):
	collideWithBox = false


# the player collide with tree
func _on_ChirstmasTree_body_entered(body):
	# the player has full items, the player can decorate the tree
	if itemCount == itemList:
		decoPossible = true

# the player doesn't collide with tree
func _on_ChirstmasTree_body_exited(body):
	if itemCount == itemList:
		text_decorate.visible = false


# the player get the item
func _on_Item_body_entered(body):
	itemCount += 1


# the player collide with enemy
func _on_Area2D_body_entered(body):
	
	# the player is dead
	if body is MonsterMan or body is MonsterWoman:
		emit_signal("isHeAlived", false)
	
	# the player lose all the items
	if body is EvilSantaFairy and !itemNoReset:
		emit_signal("itemReset", true)


# the player lose all the items
func _on_Player_itemReset(itemReset):
	itemCount = 0
	decoPossible = false
	text_itemCount.text = "Items: " + str(itemCount) + " / " + str(itemList)


# is the player is alived?
func _on_Player_isHeAlived(isHeAlive):
	
	# if the player is dead, animation and audio are stopped
	if !isHeAlive:
		playerDie = true
		animation.stop()
		audio_player.stop()
	
	# the player try to restart the game
	else:
		playerDie = false
		self._ready()
