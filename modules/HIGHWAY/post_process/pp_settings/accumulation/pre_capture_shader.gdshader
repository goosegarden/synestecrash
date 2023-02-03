shader_type canvas_item;

uniform sampler2D vp;
uniform sampler2D vp_copy;
uniform sampler2D post_capture;


void fragment(){
	
	
	vec4 direct_tex = texture(vp, SCREEN_UV);
	vec4 copy_tex = texture(vp_copy, SCREEN_UV);
	vec4 post_tex = texture(post_capture, SCREEN_UV);
	
	

	COLOR = direct_tex * 0.5 + copy_tex *0.3 + post_tex *0.2 ;

}