extends AudioStreamPlayer2D

const level_music = preload("res://Assets/Soundtracks/Lighthouse Theme Lucid Fog.mp3")

func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()

func play_music_level():
	_play_music(level_music)

func stop_main_music():
	stop()

func _on_finished() -> void:
	_play_music(level_music)
