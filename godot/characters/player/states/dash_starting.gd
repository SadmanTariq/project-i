extends GameState

export var duration = 0.4
export(NodePath) var dashing_state
onready var dashing = get_node(dashing_state)

var acting_body: Player

func enter():
	if !acting_body.dash_unlocked:
		fsm.back()
		return
	if !dashing.can_dash():
		fsm.back()
		return
	$Timer.start(duration)
	$AudioStreamPlayer.play()

func _on_Timer_timeout():
	fsm.change_to("Dashing")
