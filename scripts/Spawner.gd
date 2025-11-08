extends Node2D

@export var ghost_scene: PackedScene # Editörden Ghost.tscn'i buraya sürükleyin
@export var target_node: Marker2D # Editörden Campfire'ı buraya sürükleyin
@export var ghost_scene_2: PackedScene

func _on_timer_timeout():
	# 1. Yeni bir hayalet kopyası oluştur
	var new_ghost = ghost_scene.instantiate()
	var new_ghost_2 = ghost_scene_2.instantiate()
	
	# 2. Rastgele bir başlangıç pozisyonu seç (Ekran dışından)
	# Bu biraz matematik gerektirir, basitlik için sadece yukarıdan gelsinler:
	var offset_right = Vector2(randf_range(500, 400), randf_range(-50, 50))
	var offset_left = Vector2(randf_range(-500,-400), randf_range(-50,50))
	new_ghost.global_position = self.global_position + offset_right
	new_ghost_2.global_position = self.global_position + offset_left
	
	# 3. Hayalete hedefini söyle (En kritik kısım!)
	# Ghost.gd içindeki 'target_position' değişkenini ayarlıyoruz.
	new_ghost.target_position = target_node.global_position
	new_ghost_2.target_position = target_node.global_position
	# 4. Sahneye ekle
	get_parent().add_child(new_ghost)
	get_parent().add_child(new_ghost_2)
