extends RigidBody2D
var shoot_pressed = false
@export var speed = 3000 #get this to a sweet spot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed('shoot'):
		shoot_pressed = true
		
func _physics_process(delta: float) -> void:
	var force = Vector2(0,0)
	if shoot_pressed:
		force  = ( get_global_mouse_position()-position).normalized() * speed
		reparent(get_tree().root)
		shoot_pressed = false
		freeze  = false
	apply_central_force(force)
	
