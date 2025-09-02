extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	if PlayerStats.points >= 1000:
		$Bono1.show()
	if PlayerStats.points >= 2000:
		$Bono2.show()
	if PlayerStats.points >= 3000:
		$Bono3.show()
	reset_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if PlayerStats.points >= 1000 and PlayerStats.bono < 1:
		PlayerStats.lives += 1
		PlayerStats.bono = 1
	if PlayerStats.points >= 2000 and PlayerStats.bono < 2:
		PlayerStats.weapon_list.push_back("res://Scenes/bono_pistol.tscn")
		PlayerStats.bono = 2
	if PlayerStats.points >= 3000 and PlayerStats.bono < 3:
		PlayerStats.livesxx += 1
		PlayerStats.bono = 3


func _on_button_pressed() -> void:
	get_tree().paused = false
	queue_free()

func reset_focus():
	$Button.grab_focus()
