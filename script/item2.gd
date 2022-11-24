#Owner: LeeSoyoung
extends KinematicBody2D

class_name item2Class

var target = Vector2()
var velocity = Vector2()
var speed = 700
var arrive = false
var enterArea = false

func _ready():
	arrive = false
	enterArea = false
	Global.toyArrive = false
	
func _physics_process(_delta):
	#Move the item to the target position
	velocity = position.direction_to(target) * speed
	if arrive == false:
		if position.distance_to(target) > 6:
			velocity = move_and_slide(velocity)
		else:
			arrive = true
			Global.toyArrive = true
		
	#queue_free() if the arrived location is where the item should not exist
	if enterArea == true and arrive == true:
		Global.toyArrive = false
		Global.toyCount -= 1
		queue_free()
		
#Save target Location
func targetPos(pos):
	target = pos

func _on_Area2D_body_entered(body):
	#Check if item is in a position where it should not be present
	if body is gameBackground or (position.y > 0 and position.y < 85) or body is santaBag:
		enterArea = true
	if body is Cat and arrive == true: #If the item is in the target position and the body is a cat,
		$Timer.start()

#Function to prevent issues that conflict with the background
#and disappear when an item is thrown from the player's starting position
func _on_Area2D_body_exited(_body):
	if position.y > 85:
		enterArea = false

#When a cat enter a item2 area, the item disappears after a certain period of time
func _on_Timer_timeout():
	Global.toyArrive = false
	Global.toyCount -= 1
	queue_free()
