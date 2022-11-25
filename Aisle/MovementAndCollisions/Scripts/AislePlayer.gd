extends KinematicBody2D

class_name AislePlayer

export (int) var playerSpeed = 150

var velocity = Vector2()

var input = false
var sitdown = false
var collideWithBox = false

var itemList = 7
var itemCount = 0
var decoPossible = false

signal isHeAlived (isHeAlive)
signal getItem (getItem)
signal itemReset (itemReset)

onready var itemText = get_node("UI_Text/ItemCount")
onready var animation = $AnimationPlayer


func _ready():
	itemText.text = "Items: " + str(itemCount) + " / " + str(itemList)


func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
		animation.play("run")
		input = true
		sitdown = false
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		animation.play("run_left")
		input = true
		sitdown = false
	if Input.is_action_pressed("down"):
		animation.play("sitdown")
		sitdown = true
		input = true
	if Input.is_action_pressed("interact"):
		if collideWithBox:
			animation.play("inTheBox")
		if decoPossible:
			$UI_Text/Decorate.visible = true
			$UI_Text/PressKey_hide.visible = false
			$UI_Text/PressKey_deco.visible = false
			get_tree().paused = true
		input = true
		
	if !sitdown:
		velocity = velocity.normalized() * playerSpeed


func _physics_process(delta):
	get_input()
	
	itemText.text = "Items: " + str(itemCount) + " / " + str(itemList)
	
	var collision = move_and_collide(velocity*delta)
	
	if collision:
		emit_signal("isHeAlived", false)
		get_tree().paused = true
	
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
		$UI_Text/Decorate.visible = false


func _on_Item_body_entered(body):
	itemCount += 1


func _on_Area2D_body_entered(body):
	if body is MonsterMan or body is MonsterWoman:
		emit_signal("isHeAlived", false)
		get_tree().paused = true
	if body is EvilSantaFairy:
		emit_signal("itemReset", true)


func _on_Player_itemReset(itemReset):
	print("itemReset")
	var itemCount = 0
	var decoPossible = false
