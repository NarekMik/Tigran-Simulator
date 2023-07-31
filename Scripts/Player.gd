extends CharacterBody2D

var health = 3

signal dameged

@export var SPEED: float = 300.0
@export var Shot : PackedScene

func _physics_process(delta):
	var direction_x = Input.get_axis("left", "right")
	var direction_y = Input.get_axis("forwards", "backwards")
	
	if direction_x:
		velocity.x = direction_x
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction_y:
		velocity.y = direction_y
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	velocity = velocity.normalized() * SPEED
	
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("shoot"):
			shoot()
	move_and_slide()

func shoot():
	var s = Shot.instantiate()
	owner.add_child(s)
	s.transform = $Eyes.global_transform

func damage():
	health -= 1
	dameged.emit()
	$DamageParticle.emitting = true
