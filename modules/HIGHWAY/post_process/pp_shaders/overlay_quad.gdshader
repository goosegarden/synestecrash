shader_type canvas_item;

uniform sampler2D vp2;



void fragment(){

	vec4 screen_tex = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec4 vp2_tex = texture(vp2, SCREEN_UV);

	COLOR = vp2_tex;
}