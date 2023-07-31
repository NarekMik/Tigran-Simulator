extends CharacterBody2D

var deathb: bool = false
var stop: bool = false
var can_explode: bool = false

@export var SPEED: float = 30

@onready var player: CharacterBody2D = get_node("../Player")
@onready var cooldown: Timer = get_node("Cooldown")

@export var Shot: PackedScene

func _ready():
	cooldown.start()

func _process(delta):
	if deathb && !$DeathParticles.emitting:
		queue_free()
	if !deathb:
		explode()

func _physics_process(delta):
	if !deathb:
		if !stop:
			velocity = position.direction_to(player.position) * SPEED
		else:
			velocity = Vector2.ZERO
		look_at(player.global_position)
	move_and_slide()

func death():
	can_explode = false
	$CollisionShape2D.disabled = true
	$AnimatedSprite2D.visible = false
	$ExplosionParticle.emitting = true
	$Area2D.monitoring = false
	deathb = true
	velocity = Vector2.ZERO


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		stop = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		stop = false

func explode():
	if can_explode:
		can_explode = false

func _on_cooldown_timeout():
	can_explode = true
