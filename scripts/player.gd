extends CharacterBody2D

const speed = 100
var current_direction = "none"

func _ready() -> void:
	$AnimatedSprite2D.play("idle_front")

func _physics_process(delta: float) -> void:
	player_movement(delta)
	
func player_movement(delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		current_direction = "right"
		play_animation(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_direction = "left"
		play_animation(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_direction = "down"
		play_animation(1)
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("ui_up"):
		current_direction = "up"
		play_animation(1)
		velocity.y = -speed
		velocity.x = 0
	else:
		play_animation(0)
		velocity.y = 0
		velocity.x = 0
	
	move_and_slide()

func play_animation(movement: int) -> void:
	var direction = current_direction
	var animation = $AnimatedSprite2D
	
	if direction == "right":
		animation.flip_h = false
		if movement == 1:
			animation.play("walk_side")
		elif movement == 0:
			animation.play("idle_side")
	if direction == "left":
		animation.flip_h = true
		if movement == 1:
			animation.play("walk_side")
		elif movement == 0:
			animation.play("idle_side")
	if direction == "down":
		animation.flip_h = false
		if movement == 1:
			animation.play("walk_front")
		elif movement == 0:
			animation.play("idle_front")
	if direction == "up":
		animation.flip_h = false
		if movement == 1:
			animation.play("walk_back")
		elif movement == 0:
			animation.play("idle_back")
