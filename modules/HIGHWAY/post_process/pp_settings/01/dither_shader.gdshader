shader_type canvas_item;

uniform sampler2D dither_tex;



void fragment(){

	vec4 screen_tex = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec2 dith_uv = SCREEN_UV *12.0;
//	dith_uv *= SCREEN_PIXEL_SIZE * 16.0;
	vec4 dither = texture(dither_tex,dith_uv);
	vec4 dithered_screen = step(dither.r, screen_tex);

//	COLOR= screen_tex *0.8 + dithered_screen * 0.2 ;
//	COLOR = dithered_screen;
	float r = screen_tex.r * 0.98 + dithered_screen.b * 0.02;
//	float r = min(screen_tex.r, dithered_screen.r);
//	float r = screen_tex.r *0.8 + dithered_screen.r * 0.2 ;
//	float b = screen_tex.b;
	float b = screen_tex.b * 0.95 + dithered_screen.b * 0.05 ;
//	float b = max(screen_tex.b, dithered_screen.b);
//	float g = max(screen_tex.g, dithered_screen.g);
//	float g = screen_tex.g;
	float g = screen_tex.g *0.96 + dithered_screen.g * 0.04 ;
	

	COLOR= vec4(r,g,b, 1.0)*1.1;
//	COLOR= screen_tex *1.8;


	
}