# Owner: Kim Hyeri

extends KinematicBody2D

class_name AislePlayer

export (int) var playerSpeed = 150

var velocity = Vector2()
var aislePlayerXPos
var aislePlayerYPos

var input = false
var sitdown = false
var collideWithBox = false
var itemNoReset = false

var itemList = 7
var itemCount = 0
var decoPossible = false

var playerDie = false

signal isHeAlived (isHeAlive)
signal getItem (getItem)
signal itemReset (itemReset)

onready var text_pressKeyHide = $UI_Text/PressKey_hide
onready var text_pressKeyDeco = $UI_Text/PressKey_deco
onready var text_decorate = $UI_Text/Decorate
onready var text_itemCount = $UI_Text/ItemCount

onready var animation = $AnimationPlayer
onready var audio_player = $AudioStreamPlayer


func _init():
	aislePlayerXPos = 1920
	aislePlayerYPos = 500


func _ready():
	itemCount = 0
	decoPossible = false	
	self.set_position(Vector2(aislePlayerXPos, aislePlayerYPos))
	text_itemCount.text = "Items: " + str(itemCount) + " / " + str(itemList)


func get_input():
	velocity = Vector2()
	if !playerDie:
		if Input.is_action_pressed("ui_right"):
			velocity.x += 1
			animation.play("run")
			if !audio_player.is_playing():
				audio_player.play()	
			input = true
			sitdown = false
			itemNoReset = false
		if Input.is_action_pressed("ui_left"):
			velocity.x -= 1
			animation.play("run_left")
			if !audio_player.is_playing():
				audio_player.play()	
			input = true
			sitdown = false
			itemNoReset = false
		if Input.is_action_pressed("ui_down"):
			animation.play("sitdown")
			audio_player.stop()
			sitdown = true
			input = true
			itemNoReset = false
		if Input.is_action_pressed("interact"):
			audio_player.stop()
			if collideWithBox:
				animation.play("inTheBox")
				text_pressKeyHide.visible = false
				itemNoReset = true
			if decoPossible:
				text_decorate.visible = true
				text_pressKeyHide.visible = false
				text_pressKeyDeco.visible = false
				get_tree().paused = true
		input = true
	else:
		if Input.is_action_pressed("interact"):
			emit_signal("isHeAlived", true)
		
		
	if !sitdown:
		velocity = velocity.normalized() * playerSpeed


func _physics_process(delta):
	get_input()
	
	text_itemCount.text = "Items: " + str(itemCount) + " / " + str(itemList)
	
	if !playerDie:
		move_and_collide(velocity*delta)

	if !input:
		animation.stop()
	
	input = false


func _on_Box_body_entered(body):
	collideWithBox = true


func _on_Box_body_exited(body):
	collideWithBox = false


func _on_ChirstmasTree_body_entered(body):
	if itemCount == itemList:
		decoPossible = true


func _on_ChirstmasTree_body_exited(body):
	if itemCount == itemList:
		text_decorate.visible = false


func _on_Item_body_entered(body):
	itemCount += 1


func _on_Area2D_body_entered(body):
	if body is MonsterMan or body is MonsterWoman:
		emit_signal("isHeAlived", false)
	if body is EvilSantaFairy and !itemNoReset:
		emit_signal("itemReset", true)


func _on_Player_itemReset(itemReset):
	itemCount = 0
	decoPossible = false
	text_itemCount.text = "Items: " + str(itemCount) + " / " + str(itemList)


func _on_Player_isHeAlived(isHeAlive):
	if !isHeAlive:
		playerDie = true
		animation.stop()
		audio_player.stop()
	else:
		playerDie = false
		self._ready()
