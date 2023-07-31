extends CharacterBody2D

var deathb: bool = false
var stop: bool = false
var can_explode: bool = false

@export var SPEED: float = 40


@onready var player: CharacterBody2D = get_node("../Player")
@onready var cooldown: Timer = get_node("Cooldown")

@export var Shot: PackedScene


func _process(delta):
	pass

func _physics_process(delta):
	if !deathb:
		if !stop:
			velocity = position.direction_to(player.position) * SPEED
		else:
			velocity = Vector2.ZERO
		look_at(player.global_position)
	move_and_slide()

func death():
	set_collision_layer_value(3, false)
	$ExplosionParticle.emitting = true
	can_explode = false
	$CollisionShape2D.disabled = true
	$AnimatedSprite2D.visible = false
	$ExplosionParticle.emitting = true
	$Area2D.monitoring = false
	deathb = true
	velocity = Vector2.ZERO
	Game.score += 100

func _on_cooldown_timeout():
	can_explode = true
	death()




func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		stop = true


func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		stop = false
