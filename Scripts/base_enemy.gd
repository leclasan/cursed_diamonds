extends CharacterBody2D

class_name enemy

@export var speed = 300
@export var life = 50
@export var points_given = 1

var direction = 1

var powerup_scene = preload("res://Scenes/powerup.tscn")

func _ready() -> void:
	direction *= chose_initial_direction()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += WorldStats.gravity * delta
	
	velocity.x = speed * direction
	
	move_and_slide()
	
	if position.x > get_viewport_rect().size.x :
		position.x = 0
	elif position.x < 0:
		position.x = get_viewport_rect().size.x
	
	if position.y > get_viewport_rect().size.y :
		position.y = 0
	
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
	
	if life <= 0:
		get_parent().points += points_given
		if PlayerStats.has_powerup == false:
			if randi_range(1, 25) == 25:
				var powerup = powerup_scene.instantiate()
				powerup.position = position
				add_sibling(powerup)
				PlayerStats.has_powerup = true
		queue_free()



func chose_initial_direction() -> int:
	if randi() % 2 == 0:
		return 1
	else:
		return -1

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is TileMap:
		direction *= -1


func _on_detect_area_entered(area: Area2D) -> void:
	if area.is_in_group("Weapons"):
		life -= area.damage


func _on_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		PlayerStats.lives -= 1
		queue_free()
