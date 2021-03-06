extends GameState

func input(event: InputEvent):
	if event.is_action_pressed("jump"):
		fsm.change_to("Jumping")
	if event.is_action_pressed("dash"):
		fsm.change_to("DashStarting")
	if event.is_action_pressed("teleport"):
		fsm.change_to("TeleportOut")
	if event.is_action_pressed("grapple"):
		fsm.change_to("GrappleStarting")
	if event.is_action_pressed("attack"):
		fsm.change_to("Attacking")

func physics_process(_delta):
	var x = 0
	if Input.is_action_pressed("move_right"):
		x += 1
	if Input.is_action_pressed("move_left"):
		x -= 1
		
	if x != 0:
		fsm.change_to("Walking")
	if fsm.context.has("velocity") and fsm.context["velocity"].length() > 70:
		fsm.change_to(("Walking"))
