class_name Player extends CharacterBody2D

var cardinal_direction: Vector2 = Vector2.DOWN
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]
var direction: Vector2 = Vector2.ZERO
var invulnerable: bool = false
var hp: int = 6
var max_hp: int = 6

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var effect_animation_player: AnimationPlayer = $EffectAnimationPlayer
@onready var hit_box: HitBox = $HitBox
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine

signal direction_changed(new_direction: Vector2)
signal player_damaged(hurt_box: HurtBox)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerManager.player = self
	state_machine.initialize(self)
	hit_box.damaged.connect(_take_damage)
	update_hp(99)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	#direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	#direction = direction.normalized()
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down"),
	).normalized()
	
	
func _physics_process(_delta: float) -> void:
	move_and_slide()

func set_direction() -> bool:
	var direction_id: int = int(round((direction * 0.99 + cardinal_direction * 0.01).angle() / TAU * DIR_4.size()))
	var new_direction: Vector2 = DIR_4[direction_id]
	if new_direction == cardinal_direction:
		return false
	cardinal_direction = new_direction
	direction_changed.emit(new_direction)
	sprite_2d.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

func update_animation(state: String) -> void:
	animation_player.play(state + "_" + anim_direction())

func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"

func _take_damage(hurt_box: HurtBox) -> void:
	if invulnerable:
		return
	update_hp(-hurt_box.damage)
	if hp > 0:
		player_damaged.emit(hurt_box)
	else:
		player_damaged.emit(hurt_box)
		update_hp(99)
	return

func update_hp(delta: int) -> void:
	hp = clampi(hp + delta, 0, max_hp)
	return
	
func make_invulerable(duration: float = 1.0) -> void:
	invulnerable = true
	hit_box.monitoring = false
	await get_tree().create_timer(duration).timeout
	invulnerable = false
	hit_box.monitoring = true
	pass
