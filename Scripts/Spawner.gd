extends Node

@export var enemies: Array[PackedScene]
@onready var SpawnCooldown:Timer = get_node("SpawnCooldown")
const AREA = Vector2(704, 576)

var can_spawn = true
var RNG: RandomNumberGenerator

func _ready():
	RNG = RandomNumberGenerator.new()

func _process(delta):
	spawn(RNG.randf_range(0, AREA.x), RNG.randf_range(0, AREA.y))

func spawn(x: float, y: float):
	if can_spawn:
		SpawnCooldown.start(RNG.randf_range(0.0, 2.0))
		can_spawn = false
		var e = enemies[RNG.randi_range(0, enemies.size()-1)].instantiate()
		owner.add_child(e)
		e.global_position = Vector2(x, y)

func _on_spawn_cooldown_timeout():
	can_spawn = true
