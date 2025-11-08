extends Area2D

@export var death_sound: AudioStream
var target_position = Vector2(368,314)
var speed = 60.0

func _ready():
	speed = randf_range(50.0, 100.0)

func _process(_delta):
	var direction = (target_position - global_position)

	if direction.length() < 10:
		print("Ateş söndü!")
		get_tree().call_group("GameManager", "game_over")
		queue_free() 
		return

	global_position += direction.normalized() * speed * _delta

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		AudioManager.play_sfx(death_sound)
		print("Hayalet yakalandı!")
		queue_free() 
