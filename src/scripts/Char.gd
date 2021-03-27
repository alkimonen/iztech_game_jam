extends KinematicBody2D

const CLOSENESS_DISTANCE = 5
const MAX_SPEED = 360
const MIN_SPEED = 180
const DECELERATION = -20

onready var speed = MAX_SPEED
onready var motion = Vector2()
onready var move_direction = Vector2()

onready var animated_sprite = $AnimatedSprite

var locations = []
var loc_index = -1
var is_jumping = false

func _ready():
	add_new_location( Vector2(20, 20))
	add_new_location( Vector2(50, 100))
	add_new_location( Vector2(100, 70))
	add_new_location( Vector2(160, 50))
	add_new_location( Vector2(180, 50))
	
	_calculate_direction(0)
	_turn()

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept") && !is_jumping:
		if loc_index < locations.size()-1:
			loc_index += 1
		else:
			loc_index = 0
		_jump_to(locations[loc_index])
		
	if is_jumping && _close_to(locations[loc_index]):
		_land()
	_apply_movement()

func _calculate_direction(index):
	if index < locations.size():
		move_direction.x = locations[index].x - self.position.x
		move_direction.y = locations[index].y - self.position.y
		move_direction = move_direction.normalized()
	else:
		move_direction.x = 1
		move_direction.y = 0

func _turn():
	self.rotation = move_direction.angle()
	
func _close_to(next_pos):
	if abs(next_pos.x - self.position.x) <= CLOSENESS_DISTANCE && abs(next_pos.y - self.position.y) <= CLOSENESS_DISTANCE:
		return true
	return false

func _jump_to(next_pos):
	is_jumping = true
	animated_sprite.play("jump")

func _land():
	is_jumping = false
	self.position = locations[loc_index]
	animated_sprite.play("land")

func _apply_movement():
	if is_jumping:
		speed = max( speed + DECELERATION, MIN_SPEED)
		motion.x = speed * move_direction.x
		motion.y = speed * move_direction.y
	else:
		speed = MAX_SPEED
		motion.x = 0
		motion.y = 0
	move_and_slide(motion)

func add_new_location(new_pos):
	locations.append(new_pos)

func _on_AnimatedSprite_animation_finished():
	if animated_sprite.get_animation() == "land":
		animated_sprite.play("idle")
		_calculate_direction(loc_index+1)
		_turn()
