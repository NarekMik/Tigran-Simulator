extends Control

@onready var animSprite: AnimatedSprite2D = get_node("AnimatedSprite2D")

var animation_queue = ["lose2", "lose1", "lose0"]
var count = 0
func _ready():
	animSprite.play("3Life")
func _on_player_dameged():
	animSprite.play(animation_queue[count])
	count += 1


func _on_animated_sprite_2d_animation_finished():
	if count == 3:
		get_tree().change_scene_to_file("res://Scenes/DeathScreen.tscn")
