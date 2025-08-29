extends Node2D

@export var next_scene: PackedScene
@export var skip_scene: PackedScene

@onready var points = PlayerStats.points

@export var time: int = 120
var initial_time

var big_enemy_scene = preload("res://Scenes/big_enemy.tscn")
var enemy_scene = preload("res://Scenes/base_enemy.tscn")
var last_enemy_spawn_pos 

var diamond_scene = preload("res://Scenes/diamond.tscn")
var last_diamond_spawn_pos

var enemy_spawn_time = 3

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
	
	initial_time = Time.get_ticks_msec()


func _process(delta: float) -> void:
	$PointsLabel.text = str(points)
	var passed_time = int((Time.get_ticks_msec() - initial_time) / 1000)
	var remaining_time = time - passed_time
	$TimeLabel.text = str(remaining_time) + "s"
	if remaining_time <= 0:
		for i in get_child_count():
			get_child(0).queue_free()
		get_tree().change_scene_to_packed(next_scene)
	
	PlayerStats.points = points
	
	if Input.is_action_just_pressed("skip_level"):
		if skip_scene:
			get_tree().change_scene_to_packed(skip_scene)
		else:
			get_tree().change_scene_to_packed(next_scene)

func _on_enemy_spawn_timer_timeout() -> void:
	var enemi_pos = $EnemySpawn.get_child(randi_range(0,$EnemySpawn.get_child_count()-1)).position
	var repeat = true
	while repeat:
		if enemi_pos == last_enemy_spawn_pos:
			enemi_pos = $EnemySpawn.get_child(randi_range(0,$EnemySpawn.get_child_count()-1)).position
		else:
			repeat = false
	last_enemy_spawn_pos = enemi_pos
	spawn_enemy_group(enemi_pos)


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

func spawn_enemy_group(pos):
	var random_number = randi_range(1, 40)
	if random_number > 10:
		var small_enemi = enemy_scene.instantiate()
		small_enemi.position = pos
		add_child(small_enemi)
	if random_number > 10 and random_number < 14:
		var small_enemi = enemy_scene.instantiate()
		small_enemi.position = pos
		add_child(small_enemi)
		await get_tree().create_timer(0.3).timeout
		small_enemi = enemy_scene.instantiate()
		small_enemi.position = pos
		add_child(small_enemi)
		await get_tree().create_timer(0.3).timeout
		small_enemi = enemy_scene.instantiate()
		small_enemi.position = pos
		add_child(small_enemi)
	if random_number > 3 and random_number < 7:
		var big_enemy = big_enemy_scene.instantiate()
		big_enemy.position = pos
		add_child(big_enemy)
	if random_number > 6 and random_number < 9:
		var big_enemy = big_enemy_scene.instantiate()
		big_enemy.position = pos
		add_child(big_enemy)
		await get_tree().create_timer(0.3).timeout
		big_enemy = big_enemy_scene.instantiate()
		big_enemy.position = pos
		add_child(big_enemy)
	if random_number > 8 and random_number < 11:
		var small_enemi = enemy_scene.instantiate()
		small_enemi.position = pos
		add_child(small_enemi)
		await get_tree().create_timer(0.3).timeout
		small_enemi = enemy_scene.instantiate()
		small_enemi.position = pos
		add_child(small_enemi)
		await get_tree().create_timer(0.3).timeout
		var big_enemy = big_enemy_scene.instantiate()
		big_enemy.position = pos
		add_child(big_enemy)
	if enemy_spawn_time > 2.5:
		enemy_spawn_time -= 0.1 
	$EnemySpawnTimer.start(enemy_spawn_time)
