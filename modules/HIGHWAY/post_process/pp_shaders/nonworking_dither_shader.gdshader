shader_type canvas_item;

uniform sampler2D vp;

void fragment(){
	
	vec4 sc = texture(vp, SCREEN_UV);

	COLOR = sc;
	
}