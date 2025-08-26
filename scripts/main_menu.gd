extends Node2D

var level: int = 1


func _ready() -> void:
	$CenterContainer/mainButtons/play.grab_focus()
	$CenterContainer/settingsMenu/fullscreen.button_pressed = true if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN else false
	$CenterContainer/settingsMenu/mainvolSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	$CenterContainer/settingsMenu/musicvolSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	$CenterContainer/settingsMenu/sfxvolSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_settings_pressed() -> void:
	$CenterContainer/mainButtons.visible = false
	$CenterContainer/settingsMenu.visible = true


func _on_credits_pressed() -> void:
	$CenterContainer/mainButtons.visible = false
	$CenterContainer/creditsMenu.visible = true


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_back_pressed() -> void:
	$CenterContainer/mainButtons.visible = true
	if $CenterContainer/creditsMenu.visible:
		$CenterContainer/creditsMenu.visible = false
		$CenterContainer/mainButtons/credits.grab_focus()
	
	if $CenterContainer/settingsMenu.visible:
		$CenterContainer/settingsMenu.visible = false
		$CenterContainer/mainButtons/settings.grab_focus()


func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)


func _on_mainvol_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), value)


func _on_musicvol_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Music"), value)


func _on_sfxvol_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"), value)
