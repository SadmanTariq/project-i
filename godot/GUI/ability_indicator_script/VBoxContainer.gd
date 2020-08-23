extends VBoxContainer

func _process(_delta):
	var player = Globals.player
	
	$Dash.visible = player.dash_available
	$DoubleJump.visible = player.double_jump_available
	$Teleport.visible = player.teleport_available
