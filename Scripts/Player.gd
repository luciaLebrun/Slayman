extends KinematicBody2D

export var GRAVITY = 20
export var WALK_SPEED = 150
export var JUMP_FORCE = 300

enum {
	MOVE,
	ATTACK
}

var velocity = Vector2.ZERO
var state = MOVE
var stats = PlayerStats

onready var _animated_sprite = $AnimatedSprite
onready var hitbox = $SwordHitbox/CollisionShape2D
onready var game = get_node("/root/Game")
onready var hurtbox = $Hurtbox

func _ready():
	stats.connect("no_health", self, "death")
	
func _physics_process(_delta):
	velocity.y += GRAVITY
	match state:
		MOVE:
			move_state()
			
		ATTACK:
			attack_state()
			

func move_state():
		var input_vector = Vector2.ZERO
		input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		input_vector.y = 0
		input_vector.normalized()
		
		velocity.x = input_vector.x * WALK_SPEED
		
		if input_vector != Vector2.ZERO:
			_animated_sprite.animation = "Run"
			var flip = _animated_sprite.flip_h
			_animated_sprite.flip_h = verifyPosition(input_vector.x)
			if flip != _animated_sprite.flip_h:
				hitbox.position.x = -hitbox.position.x
			
		else:
			idle()
		
		if Input.is_action_pressed("jump") and is_on_floor():
			jump()
		
		move()
		
		if Input.is_action_pressed("attack") and is_on_floor():
			state = ATTACK

func jump():
	_animated_sprite.animation = "Jump"
	velocity.y = -JUMP_FORCE

func attack_state():
	_animated_sprite.animation = "Attack"
	hitbox.disabled = 0

func idle():
	# smoothen the stop
	_animated_sprite.animation = "Idle"
	velocity.x = lerp(velocity.x, 0, 0.1)

func move():
	velocity = move_and_slide(velocity, Vector2.UP)

func verifyPosition(x):
	return !bool(x + 1)

func damage(area):
	stats.health -= area.damage
	game.HPUpdate(stats.health)

func _on_AnimatedSprite_animation_finished():
	state = MOVE
	hitbox.disabled = 1

func _on_Hurtbox_area_entered(area):
	damage(area)
	hurtbox.start_invicibility(0.5)

func death():
	get_tree().change_scene("res://Scene/Menu.tscn")

func _on_Game_ready():
	game.HPUpdate(stats.health)
