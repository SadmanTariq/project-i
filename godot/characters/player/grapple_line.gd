extends Line2D

enum {
	LEFT,
	RIGHT
}

var _target: Node2D
var start_point setget _set_start_point, _get_start_point
var end_point setget _set_end_point, _get_end_point
var direction = RIGHT setget _set_direction

func _ready():
	set_process(false)

func _process(_delta):
	_set_end_point(_target.global_position - global_position)

func activate(duration=0.1):
	_target = get_tree().get_nodes_in_group("active_anchor")[0]
	points[0] = Vector2()
	points[1] = Vector2()
	var to_target = _target.global_position - global_position
	visible = true
#	$Tween.interpolate_property()
	$Tween.interpolate_property(self, "end_point", Vector2(), to_target,
								duration)
	$Tween.start()

func deactivate():
	visible = false
	set_process(false)
#	$Tween.interpolate_property(self, "start_point", start_point, end_point,
#								duration)
#	$Tween.start()
	

#func _input(event):
#	if event.is_action_pressed("move_right"):
#		activate(0.1)
#	elif event.is_action_pressed("move_left"):
#		deactivate()

func _set_direction(value):
	if direction == value:
		return
		
	direction = value
	position.x = -position.x
	

func _set_start_point(value):
	points[0] = value

func _get_start_point():
	return points[0]

func _set_end_point(value):
	points[1] = value

func _get_end_point():
	return points[1]


func _on_Grappling_state_entered():
	set_process(true)
