extends Node2D

@onready var win_label = $Label_won
@onready var win_label_anim = $Label_won/AnimationPlayer
@onready var music_play = $Music
@onready var lose_label = $Label_lose
@onready var lose_label_anim = $Label_lose/AnimationPlayer

@onready var win_timer = $WinTimer

var game_won = false
var game_lose = false

func _ready():
	music_play.play()
func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
		
	if not game_won and not game_lose:
		$CanvasLayer/TimeLabel.text = str(ceil(win_timer.time_left)) + " seconds to win"
		
func game_over():
	if game_won: return 
	
	game_lose = true
	win_timer.stop()
	$CanvasLayer/TimeLabel.visible = false
	print("OYUN KAYBEDİLDİ!")
	
	lose_label.visible = true
	if lose_label_anim:
		lose_label_anim.play("sallanma")
		
	get_tree().paused = true

func game_win():
	if game_won: return
	
	game_won = true
	$CanvasLayer/TimeLabel.visible = false
	print("OYUN KAZANILDI!")
	
	win_label.visible = true
	if win_label_anim:
		win_label_anim.play("sallanma")
		
	get_tree().paused = true

func _on_win_timer_timeout():
	if not game_lose:
		game_win()
