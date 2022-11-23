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
	
func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	if arrive == false:
		if position.distance_to(target) > 10:
			velocity = move_and_slide(velocity)
		else:
			arrive = true
			Global.toyArrive = true
		
	if enterArea == true and arrive == true:
		Global.toyArrive = false
		queue_free()
		
	
func targetPos(pos):
	target = pos

func _on_Area2D_body_entered(body):
	if body is gameBackground or (position.y > 0 and position.y < 85) or body is santaBag:
		enterArea = true
	if body is Cat and arrive == true:
		$Timer.start()


func _on_Area2D_body_exited(body):
	if position.y > 85:
		enterArea = false


func _on_Timer_timeout():
	Global.toyArrive = false
	queue_free()
