extends CharacterBody2D


const SPEED = 300.0

var movement := Vector2()

var my_score = 0
@onready var label: Label = $CanvasLayer/Label

func _ready() -> void:
	my_score = Global.my_score
	label.set_text(str(my_score))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if Input.is_action_pressed("ui_left"):
		movement.x = -1
	elif Input.is_action_pressed("ui_right"):
		movement.x = 1
	else:
		movement.x = 0
	
	if Input.is_action_pressed("ui_down"):
		movement.y = 1
	elif Input.is_action_pressed("ui_up"):
		movement.y = -1
	else:
		movement.y = 0
	velocity = movement.normalized() * SPEED
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Item"):
		my_score += 1
		body.queue_free()
		label.set_text(str(my_score))
	elif body.is_in_group("Change"):
		Global.my_score = my_score
		get_tree().change_scene_to_file(body.to_level)
