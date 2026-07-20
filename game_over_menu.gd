extends CanvasLayer

@onready var audio = $AudioStreamPlayer
signal restart

func _on_restart_button_pressed() -> void:
	restart.emit()
	audio.play()
