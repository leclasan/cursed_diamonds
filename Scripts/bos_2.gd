extends Area2D

var state = STATES.FLY_HIGH
enum STATES {FLY_LOW, FLY_HIGH, ATTACK}

var life = 1000

var speed = 350

@onready var player: CharacterBody2D = $"../Player"

@onready var position_1: Vector2 = $"../BossPositions/Marker2D".position
@onready var position_2: Vector2 = $"../BossPositions/Marker2D2".position
@onready var position_3: Vector2 = $"../BossPositions/Marker2D3".position
@onready var position_4: Vector2 = $"../BossPositions/Marker2D4".position

@onready var next_state_timer: Timer = $NextStateTimer
@onready var diamond_timer: Timer = $DiamondTimer
@onready var go_down_timer: Timer = $GoDownTimer

var points = PlayerStats.points

var diamond_scene = preload("res://Scenes/diamond.tscn")

var is_timer_called = false

var is_above_player = false
var is_going_down = true 
var attack_times = 0
var diagonal_attack_direction = Vector2.ZERO
var diagonal_attack_player_position = Vector2.ZERO
var going_up = false

var attack = 0

func _ready() -> void:
	_on_diamond_timer_timeout()

func _process(delta: float) -> void:
	match state:
		STATES.FLY_LOW:
			var distance_pos_3 = position.distance_to(position_3)
			var distance_pos_4 = position.distance_to(position_4)
			if distance_pos_3 < distance_pos_4:
				var direction = (position_3 - position).normalized()
				var vel = speed * direction * delta 
				if distance_pos_3 < vel.length():
					vel = position_3 - position
				position += vel
				if position.distance_to(position_3) < 1:
					if is_timer_called == false:
						next_state_timer.start(5)
						is_timer_called = true
			else:
				var direction = (position_4 - position).normalized()
				var vel = speed * direction * delta 
				if distance_pos_4 < vel.length():
					vel = position_4 - position
				position += vel
				if position.distance_to(position_4) < 1:
					if is_timer_called == false:
						next_state_timer.start(5)
						is_timer_called = true
		STATES.FLY_HIGH:
			var distance_pos_1 = position.distance_to(position_1)
			var distance_pos_2 = position.distance_to(position_2)
			if distance_pos_1 < distance_pos_2:
				var direction = (position_1 - position).normalized()
				var vel = speed * direction * delta 
				if distance_pos_1 < vel.length():
					vel = position_1 - position
				position += vel
				if position.distance_to(position_1) < 1:
					if is_timer_called == false:
						next_state_timer.start(2.5)
						is_timer_called = true
			else:
				var direction = (position_2 - position).normalized()
				var vel = speed * direction * delta 
				if distance_pos_2 < vel.length():
					vel = position_2 - position
				position += vel
				if position.distance_to(position_2) < 1:
					if is_timer_called == false:
						next_state_timer.start(2)
						is_timer_called = true
		STATES.ATTACK:
			if attack == 0:
				attack = randi_range(1, 2)
			if attack == 1:
				attack_1()
			if attack == 2:
				attack_2(delta)
	
	PlayerStats.points = points
	
	if life <= 0:
		PlayerStats.points += 50
		get_tree().change_scene_to_file("res://Scenes/win.tscn")

func attack_1():
	if attack_times < 3:
		if position.distance_to(Vector2(player.position.x, 130)) < 1 and is_above_player == false:
			go_down_timer.start(0.5)
			is_above_player = true
		elif is_above_player:
			if is_going_down:
				if position == Vector2(position.x, 561):
					is_above_player = false
					is_going_down = false
					attack_times += 1
				else:
					var direction = (Vector2(position.x, 561) - position).normalized()
					var vel = speed * 2 * direction * get_process_delta_time()
					if position.distance_to(Vector2(position.x, 561)) < vel.length():
						vel = Vector2(position.x, 561) - position
					position += vel
		else:
			var direction = (Vector2(player.position.x, 130) - position).normalized()
			var vel = speed * direction * get_process_delta_time()
			if position.distance_to(Vector2(player.position.x, 130)) < vel.length():
				vel = Vector2(player.position.x, 130) - position
			position += vel
	else:
		attack_times = 0
		attack = 0
		state = STATES.FLY_LOW

func attack_2(delta: float):
	if attack_times < 3:
		if position.distance_to(diagonal_attack_player_position) < 1 and going_up == false:
			going_up = true
		elif going_up :
			var distance_pos_1 = position.distance_to(position_1)
			var distance_pos_2 = position.distance_to(position_2)
			if distance_pos_1 < distance_pos_2:
				var direction = (position_1 - position).normalized()
				var vel = speed * direction * delta
				if distance_pos_1 < vel.length():
					vel = position_1 - position
				position += vel
				if position.distance_to(position_1) < 1:
					attack_times += 1
					going_up = false
					diagonal_attack_direction = Vector2.ZERO
					diagonal_attack_player_position = Vector2.ZERO
			else:
				var direction = (position_2 - position).normalized()
				var vel = speed * direction * delta
				if distance_pos_2 < vel.length():
					vel = position_2 - position
				position += vel
				if position.distance_to(position_2) < 1:
					attack_times += 1
					going_up = false
					diagonal_attack_direction = Vector2.ZERO
					diagonal_attack_player_position = Vector2.ZERO
		else:
			if diagonal_attack_direction == Vector2.ZERO:
				diagonal_attack_direction = (player.position - position).normalized()
				diagonal_attack_player_position = player.position
			var vel = diagonal_attack_direction * speed * 2 * get_process_delta_time()
			if position.distance_to(diagonal_attack_player_position) < vel.length():
				vel = diagonal_attack_player_position - position
			position += vel
	else:
		attack_times = 0
		attack = 0
		state = STATES.FLY_LOW

func next_state():
	is_timer_called = false
	match state:
		STATES.FLY_LOW:
			state = STATES.FLY_HIGH
		STATES.FLY_HIGH:
			state = STATES.ATTACK

func spawn_diamond():
	diamond_timer.start(5)

func _on_diamond_timer_timeout() -> void:
	var diamond = diamond_scene.instantiate()
	diamond.position = Vector2(0.0, -8.0)
	diamond.bos_2 = true
	diamond.scale.x = 0.54
	diamond.scale.y = 0.54
	add_child(diamond)


func go_down() -> void:
	is_going_down = true


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Weapons"):
		life -= area.damage


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		PlayerStats.lives -= 1
