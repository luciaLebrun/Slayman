extends KinematicBody2D

onready var player = get_node("/root/Game/Player")
onready var _animated_sprite = $AnimatedSprite
onready var hitbox = $Hitbox/CollisionShape2D
onready var playerDetectionZone = $PlayerDetectionZone
onready var stats = $Stats
onready var hitTimer = $Hitbox/HitTimer

export var WALK_SPEED = 50
export var GRAVITY = 600

var attack = false
var velocity = Vector2.ZERO

func _ready():
	stats.connect("no_health", self, "queue_free")

func _physics_process(_delta):
	var direction = (player.position - position).normalized()
	var flip = _animated_sprite.flip_h
	
	seek_player()
	
	if is_instance_valid(player) and !attack:
		_animated_sprite.animation = "Walk"

		if direction.x < 0:
			_animated_sprite.flip_h = 1
			
		else:
			_animated_sprite.flip_h = 0
			
		if flip != _animated_sprite.flip_h:
				hitbox.position.x = -hitbox.position.x
			
		if not is_on_floor():
			direction.y += GRAVITY
		
		velocity = move_and_slide(direction * WALK_SPEED)

func seek_player():
	if playerDetectionZone.can_see_player():
		hitbox.disabled = 0
		_animated_sprite.animation = "Attack"
		attack = true
	elif !attack:
		_animated_sprite.animation = "Walk"
		hitbox.disabled = 1

func _on_AnimatedSprite_animation_finished():
	attack = false

func _on_Hurtbox_area_entered(area):
	print(stats.health)
	stats.health -= area.damage
