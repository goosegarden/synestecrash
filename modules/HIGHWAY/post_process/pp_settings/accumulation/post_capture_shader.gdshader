shader_type canvas_item;

uniform sampler2D pre_vp;
uniform sampler2D post_vp;


void fragment(){

	vec4 screen_tex = texture(pre_vp, SCREEN_UV);


	COLOR = screen_tex;

}