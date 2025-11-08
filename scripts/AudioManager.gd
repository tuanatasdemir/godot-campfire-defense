extends Node

var num_players = 30
var bus = "master"

var available_players = [] 

func _ready():
	for i in num_players:
		var p = AudioStreamPlayer.new()
		add_child(p)
		available_players.append(p)
		# Ses bitince havuza geri dönmesini sağla (Sinyal bağlantısı)
		p.finished.connect(_on_stream_finished.bind(p))
		p.bus = bus

func play_sfx(sound_stream: AudioStream, volume_db: float = 0.0, pitch_scale: float = 1.0):
	if sound_stream == null:
		return
		
	if available_players.size() > 0:
		# Havuzdan bir tane al (pop_front = kuyruğun başından al)
		var p = available_players.pop_front()
		p.stream = sound_stream
		p.volume_db = volume_db
		p.pitch_scale = pitch_scale
		p.play()
	else:
		print("AudioManager: Tüm ses kanalları dolu! Ses çalınamadı.")


func _on_stream_finished(player):
	available_players.append(player)
	
	
