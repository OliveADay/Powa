extends RigidBody2D
var shoot_pressed = false
@export var speed = 3000 #get this to a sweet spot
var grappleArm: Node2D
var timeafterRelease = 0.3
var currentTimeAfter = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grappleArm = get_tree().get_first_node_in_group("grappleArm")
	# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_parent().is_in_group("grappleArm"):
		if Input.is_action_pressed('shoot'):
			shoot_pressed = true
	if currentTimeAfter > 0:
		currentTimeAfter -= delta
	
		
func _physics_process(delta: float) -> void:
	var force = Vector2(0,0)
	if shoot_pressed:
		force  = (get_global_mouse_position()-global_position).normalized() * speed
		reparent(get_tree().root)
		currentTimeAfter = timeafterRelease
		shoot_pressed = false
		freeze  = false
		$grapplegrabber.monitoring = true
		gravity_scale = 1
	apply_central_force(force)
	


func _on_body_entered(body: Node) -> void:
	if body.is_in_group('ground'):
		freeze = true
		gravity_scale = 1 # Replace with function body.


func _on_grapplegrabber_body_entered(body: Node2D) -> void:
	if currentTimeAfter <= 0:
		reparent(grappleArm)
		freeze = true
		$grapplegrabber.monitoring = false
		position = Vector2(0,0)
		gravity_scale = 0
		rotation = 0
