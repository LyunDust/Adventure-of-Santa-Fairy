extends KinematicBody2D


var target = Vector2()
var velocity = Vector2()
var speed = 700
var arrive = false
var enterArea = false

func _ready():
	arrive = false
	enterArea = false

func _physics_process(delta):
	if Global.target == true:
		target = Global.vaccumsPos
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) > 10:
		velocity = move_and_slide(velocity)
	else:
		arrive = true
		
	if arrive == true:
		queue_free()


func _on_Area2D_body_entered(body):
	if body is gameBackground or (position.y > 0 and position.y < 85) or body is santaBag:
		enterArea = true
	if body is vacuums:
		Global.target = false
		body.teleport()
		queue_free()
		
func targetPos(pos):
	target = pos
