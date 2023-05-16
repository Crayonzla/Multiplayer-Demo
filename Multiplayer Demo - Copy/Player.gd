extends RigidBody2D

const SPEED = 4

@onready var synchronizer = $MultiplayerSynchronizer
@onready var animationPlayer = $AnimationPlayer

var PlayerID = ""

func _ready():
	synchronizer.set_multiplayer_authority(str(name).to_int())
	PlayerID = str(name)

	collision_layer = 2 
	collision_mask = 1    

func _process(_delta):
	var animation = ""
	
	if Input.is_action_pressed("ui_up"):
		move(0, -SPEED)
		animation = "B_Walk"
	elif Input.is_action_pressed("ui_down"):
		move(0, SPEED)
		animation = "F_Walk"
	elif Input.is_action_pressed("ui_right"):
		move(SPEED, 0)
		animation = "R_Walk"
	elif Input.is_action_pressed("ui_left"):
		move(-SPEED, 0)
		animation = "L_Walk"

	if animation != "" and PlayerID == str(name):
		animationPlayer.play(animation)

	synchronizer.position = global_position

func move(xspeed, yspeed):
	position.x += xspeed
	position.y += yspeed

