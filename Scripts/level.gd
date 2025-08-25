extends Node2D

var points = 0

var enemy_scene = preload("res://Scenes/base_enemy.tscn")
var last_enemy_spawn_pos 

var diamond_scene = preload("res://Scenes/diamond.tscn")
var last_diamond_spawn_pos

func _ready() -> void:
	var enemi = enemy_scene.instantiate()
	var enemi_pos = $EnemySpawn.get_child(randi_range(0,$EnemySpawn.get_child_count()-1)).position
	enemi.position = enemi_pos
	last_enemy_spawn_pos = enemi_pos
	add_child(enemi)
	
	var diamond = diamond_scene.instantiate()
	var diamond_pos = $DiamondSpawn.get_child(randi_range(0,$DiamondSpawn.get_child_count()-1)).position
	diamond.position = diamond_pos
	last_diamond_spawn_pos = diamond_pos
	add_child(diamond)


func _process(delta: float) -> void:
	$Label.text = str(points)


func _on_enemy_spawn_timer_timeout() -> void:
	var enemi = enemy_scene.instantiate()
	var enemi_pos = $EnemySpawn.get_child(randi_range(0,$EnemySpawn.get_child_count()-1)).position
	var repeat = true
	while repeat:
		if enemi_pos == last_enemy_spawn_pos:
			enemi_pos = $EnemySpawn.get_child(randi_range(0,$EnemySpawn.get_child_count()-1)).position
		else:
			repeat = false
	last_enemy_spawn_pos = enemi_pos
	enemi.position = enemi_pos
	add_child(enemi)

func spawn_diamond():
	var diamond = diamond_scene.instantiate()
	var diamond_pos = $DiamondSpawn.get_child(randi_range(0,$DiamondSpawn.get_child_count()-1)).position
	var repeat = true
	while repeat:
		if diamond_pos == last_diamond_spawn_pos:
			diamond_pos = $DiamondSpawn.get_child(randi_range(0,$DiamondSpawn.get_child_count()-1)).position
		else:
			repeat = false
	last_diamond_spawn_pos = diamond_pos
	diamond.position = diamond_pos
	add_child(diamond)
