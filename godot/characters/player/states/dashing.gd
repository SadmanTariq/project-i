extends GameState

signal dash_finished

export var duration = 0.2
export var speed = 2000

var dash_available = true
var direction: Vector2
var acting_body: Player
var velocity: Vector2
var velocity_key = "velocity"

func enter():
	if !can_dash():
		fsm.back()
		return
	
	direction = get_direction()
	
	if direction.x > 0:
		acting_body.move_direction = acting_body.RIGHT
	elif direction.x < 0:
		acting_body.move_direction = acting_body.LEFT
	
	dash_available = false
	
	velocity = direction * speed
	
	$Timer.start(duration)

func physics_process(_delta):
	velocity = acting_body.move_and_slide(velocity)
#	if acting_body.is_on_floor():
	fsm.context["jumps_left"] = 2

func get_direction():
	if Input.is_action_pressed("move_left"):
		return Vector2.LEFT
	elif Input.is_action_pressed("move_right"):
		return Vector2.RIGHT
	else:
		# move direction is enum where left is 0 and right is 1
		return [Vector2.LEFT, Vector2.RIGHT][acting_body.move_direction]

func can_dash():
	return dash_available or acting_body.is_on_floor()


func _on_Player_touched_ground():
	dash_available = true


func _on_Timer_timeout():
	emit_signal("dash_finished")
	fsm.context[velocity_key] = velocity
	fsm.change_to("Walking")
