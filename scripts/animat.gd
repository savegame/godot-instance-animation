extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

# скорость перемещения
var velocity  = 200.0;
var moving    = false;
var use_nimator = true;
var next_pos  = Vector2();
var direction = Vector2();

onready var anim = get_node("anim");

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#anim.add_animation( "move_to", get_node("anim").get_animation("move_to").duplicate() );
	#anim.add_animation( "cool", get_node("anim").get_animation("cool").duplicate() );
	set_process(true);
	pass

func move_to( pos = Vector2(0,0) ):
	print( " -------------------------------- " );
	print( "  Animator ID " + String(anim.get_instance_ID()) );
	print( "  Node ID " + String(get_instance_ID()) );
	var anim_move_to = anim.get_animation("move_to");
	anim_move_to.track_set_key_value( 0, 0, get_pos() );
	anim_move_to.track_set_key_value( 0, 1, pos );
	anim.play( anim_move_to.get_name() );

func move_to_2(pos = Vector2() ):
	direction = pos - get_pos();
	direction = direction.normalized();
	next_pos = pos;
	moving = true;
	pass;

func aka( a ) :
	if a < 0 :
		return -a;
	else :
		return a;

func _process(delta):
	if use_nimator == false : 
		if moving :
			var shift = direction * velocity * delta;
			var cur = next_pos - get_pos();
			if aka(cur.x) < aka(shift.x) :
				set_pos(next_pos);
				moving = false;
			elif aka(cur.y) < aka(shift.y) :
				set_pos(next_pos);
				moving = false;
			else :
				set_pos( get_pos() + shift );
		else :
			var pos = Vector2();
			pos.x = rand_range(0, get_viewport_rect().size.width);
			pos.y = rand_range(0, get_viewport_rect().size.height);
			move_to_2( pos );
	pass;

func _on_anim_finished():
	var view_size = get_viewport_rect().size;
	var animat_size = Vector2(1,1);
	var s = get_node("sprite");
	var t = s.get_texture();
	if t != null :
		animat_size = t.get_size() * s.get_scale().x;
		view_size = view_size - animat_size;
	var pos = Vector2();
	pos.x = rand_range(animat_size.width  * 0.5, view_size.width);
	pos.y = rand_range(animat_size.height * 0.5, view_size.height);
	move_to( pos );
	pass # replace with function body
