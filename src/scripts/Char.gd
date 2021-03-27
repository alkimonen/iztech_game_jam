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
var is_jumping = false
var loc_index = 0

func _ready():
	add_new_location( Vector2(20, 20))
	add_new_location( Vector2(50, 100))
	add_new_location( Vector2(100, 70))
	add_new_location( Vector2(160, 50))
	add_new_location( Vector2(180, 50))
	
	self.position = locations[loc_index]
	
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept") && !is_jumping:
		if loc_index < locations.size()-1:
			loc_index += 1
		else:
			loc_index = 0
		
		_calculate_direction(locations[loc_index])
		is_jumping = true
		animated_sprite.play("jump")
	
	if is_jumping && _close_to(locations[loc_index]):
		is_jumping = false
		self.position.x = locations[loc_index].x
		self.position.y = locations[loc_index].y
		animated_sprite.play("land")
		
	if is_jumping:
		self.rotation = move_direction.angle()
		speed = max( speed + DECELERATION, MIN_SPEED)
		motion.x = speed * move_direction.x
		motion.y = speed * move_direction.y
	else:
		speed = MAX_SPEED
		motion.x = 0
		motion.y = 0
	
	move_and_slide(motion)
	

func _calculate_direction(next_pos):
	move_direction.x = next_pos.x - self.position.x
	move_direction.y = next_pos.y - self.position.y
	move_direction = move_direction.normalized()

func _close_to(next_pos):
	#print( abs(next_pos.x - self.position.x), " ", abs(next_pos.y - self.position.y))
	if abs(next_pos.x - self.position.x) <= CLOSENESS_DISTANCE && abs(next_pos.y - self.position.y) <= CLOSENESS_DISTANCE:
		return true
	return false

func _move_to(location):
	pass

func add_new_location(new_pos):
	locations.append(new_pos)

func _apply_animation():
	pass

func _on_AnimatedSprite_animation_finished():
	if animated_sprite.get_animation() == "land":
		animated_sprite.play("idle")
