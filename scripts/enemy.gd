extends CharacterBody2D

var speed = 40
var player_chase = false
var player = null

func _ready() -> void:
	$AnimatedSprite2D.play("idle_front")

func _physics_process(delta: float) -> void:
	if player_chase and player:
		var diff = player.position - position
		
		if abs(diff.x) > abs(diff.y):
			velocity.x = speed * sign(diff.x)
			velocity.y = 0
		else:
			velocity.y = speed * sign(diff.y)
			velocity.x = 0
		
		move_and_slide()
		
		if velocity.x != 0:
			$AnimatedSprite2D.play("walk_side")
			$AnimatedSprite2D.flip_h = (velocity.x < 0)
		elif velocity.y < 0:
			$AnimatedSprite2D.play("walk_back")
		elif velocity.y > 0:
			$AnimatedSprite2D.play("walk_front")

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true

func _on_detection_area_body_exited(body: Node2D) -> void:
	if velocity.x != 0:
		$AnimatedSprite2D.play("idle_side")
		$AnimatedSprite2D.flip_h = (velocity.x < 0)
	elif velocity.y < 0:
		$AnimatedSprite2D.play("idle_back")
	elif velocity.y > 0:
		$AnimatedSprite2D.play("idle_front")
	player = null
	player_chase = false
