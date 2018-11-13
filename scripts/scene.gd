extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var animat = preload("res://scenes/enemy_0.tscn");
var animats = [];
var animat_size = null;
onready var view_size = get_viewport_rect().size;

func _ready():
	randomize();
	for i in range(5):
		var e1 = animat.instance();
		if animat_size == null:
			var s = e1.get_node("sprite");
			var t = s.get_texture();
			if t != null :
				animat_size = t.get_size() * s.get_scale().x;
				view_size = view_size - animat_size;
			else:
				animat_size = Vector2(1,1);
		add_child(e1);
		animats.append(e1);
		var pos = Vector2(0,0);
		pos.x = rand_range(animat_size.width  * 0.5, view_size.width);
		pos.y = rand_range(animat_size.height * 0.5, view_size.height);
		e1.set_pos( pos );
		pos.x = rand_range(animat_size.width  * 0.5, view_size.width);
		pos.y = rand_range(animat_size.height * 0.5, view_size.height);
		#e1.move_to( pos );
		
	for i in range(2):
		var pos = Vector2();
		pos.x = rand_range(animat_size.width  * 0.5, view_size.width);
		pos.y = rand_range(animat_size.height * 0.5, view_size.height);
		#animats[i].move_to( pos );
	
	set_process_input(true);
	pass

func _input(event):
	if event.type == InputEvent.MOUSE_BUTTON :
		for i in range(animats.size()):
			var a = animats[i];
			var rect = Rect2( a.get_pos() - animat_size * 0.5, a.get_pos() + animat_size * 0.5);
			if rect.has_point( event.pos ):
				var pos = Vector2();
				pos.x = rand_range(animat_size.width  * 0.5, view_size.width);
				pos.y = rand_range(animat_size.height * 0.5, view_size.height);
				a.move_to(pos);
				break;
	pass;
