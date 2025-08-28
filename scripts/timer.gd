extends Node2D

var seconds_passed = 0
@onready var timer: Timer = $Timer
@onready var label: Label = $Label

func _ready() -> void:
	timer.start()

func _on_timer_timeout() -> void:
	seconds_passed += 1
	label.text = "Time passed: " + str(seconds_passed) + "s"
