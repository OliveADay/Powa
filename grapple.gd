extends RigidBody2D
var shoot_pressed = false
var touching_ground = false
@export var speed = 3000 #get this to a sweet spot
var grappleArm: Node2D
var timeafterRelease = 0.3
var currentTimeAfter = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grappleArm = get_tree().get_first_node_in_group("grappleArm")# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_parent().is_in_group("grappleArm"):
		if Input.is_action_pressed('shoot'):
			shoot_pressed = true
	
		
func _physics_process(delta: float) -> void:
	var force = Vector2(0,0)
	if touching_ground:
		freeze = true
	if shoot_pressed:
		force  = (get_global_mouse_position()-global_position).normalized() * speed
		reparent(get_tree().root)
		shoot_pressed = false
		freeze  = false
		$grapplegrabber.monitoring = true
	apply_central_force(force)
	


func _on_body_entered(body: Node) -> void:
	if body.is_in_group('ground'):
		touching_ground = true # Replace with function body.
	else:
		touching_ground = false


func _on_grapplegrabber_body_entered(body: Node2D) -> void:
	reparent(grappleArm)
	$grapplegrabber.monitoring = false
	position = Vector2(0,0)
