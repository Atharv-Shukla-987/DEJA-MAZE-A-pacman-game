extends Node
var bgmusic = AudioStreamPlayer.new(
	
)



func _ready() -> void:
	add_child(bgmusic)
	bgmusic.stream = load("res://scens/mondamusic-retro-arcade-game-music-512837.mp3")
	bgmusic.volume_db = -10
	bgmusic.play()
	
	
func _on_finished():
	bgmusic.play()
	
