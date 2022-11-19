extends KinematicBody2D

class_name vacuums

export (int) var speed = 200

var velocity = Vector2()
var direction = 1
var yValue
var isMoving = true
signal pauseRay
signal startRay


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	yValue = rand_range(-1, 1)

func _physics_process(delta):
	velocity = velocity.normalized() * speed
	
	if is_on_wall():
		direction = direction * -1
		yValue = rand_range(-1, 1)
	
	if isMoving == true:
		if direction == 1:
			velocity = Vector2(1, yValue) * speed
		else:
			velocity = Vector2(-1, yValue) * speed
		velocity = move_and_slide(velocity)
		

func robotError():
	set_modulate(Color(0.5, 0.5, 0.5))
	isMoving = false
	if Global.playerDie ==  false:
		visible = false
	else:
		visible = true
	velocity.x = 0
	$Timer.start()
	$Timer/blink.start()


func _on_blink_timeout():
	visible = !visible


func _on_Timer_timeout():
	$Timer/blink.stop()
	visible = true
	set_modulate(Color(1, 1, 1))
	isMoving = true
	emit_signal("startRay")


func _on_Area2D_body_entered(body):
	body.pausePlayer()
	emit_signal("pauseRay")
	robotError()


func _on_Santa_bag_vacuumsPause():
	isMoving = false
	$Timer.start()
