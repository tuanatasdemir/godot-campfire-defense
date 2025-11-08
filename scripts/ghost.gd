extends Area2D

@export var death_sound: AudioStream
var target_position = Vector2(368,314)
var speed = 60.0

func _ready():
	# (Opsiyonel) Rastgele bir hız vererek çeşitlilik sağlayabilirsiniz
	speed = randf_range(50.0, 100.0)

func _process(_delta):
	# 1. Hedefe giden vektörü bul: (Hedef - Ben)
	var direction = (target_position - global_position)

	# 2. Eğer hedefe çok yaklaştıysam (örn: ateşe değdim)
	if direction.length() < 10:
		print("Ateş söndü!")
		get_tree().call_group("GameManager", "game_over")
		queue_free() # Kendini yok et (veya can azalt)
		return

	# 3. Hareketi uygula (Vektörü normalize et ki sabit hızda gitsin)
	global_position += direction.normalized() * speed * _delta

# --- TIKLAMA İLE YOK ETME ---
func _on_input_event(_viewport, event, _shape_idx):
	# Sadece sol tık basıldığında
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		AudioManager.play_sfx(death_sound)
		print("Hayalet yakalandı!")
		# Buraya bir "puf" efekti veya ses eklenebilir.
		queue_free() # Nesneyi hafızadan sil
