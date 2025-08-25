extends Node2D

var bullet_scene = preload("res://Scenes/minigun_bullet.tscn")

var cooldown = 0.1

func _ready() -> void:
	PlayerStats.weapon_cooldown = cooldown
	PlayerStats.weapon = self
	PlayerStats.weapon_file = "res://Scenes/minigun.tscn"

func _process(delta: float) -> void:
	if PlayerStats.weapon_flip:
		rotation = PI
		$Sprite2D.flip_v = true
	else:
		rotation = 0
		$Sprite2D.flip_v = false
		
func shoot(direction):
	var bullet = bullet_scene.instantiate()
	bullet.position = global_position
	bullet.direction = direction
	get_tree().get_root().add_child(bullet)
