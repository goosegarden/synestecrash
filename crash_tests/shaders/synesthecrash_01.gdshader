shader_type spatial;
render_mode unshaded;

uniform float f0;
uniform float f1;
uniform float f2;
uniform float f3;
uniform float f4;
uniform float f5;
uniform float f6;
uniform float f7;
uniform float f8;
uniform float f9;
uniform float f10;
uniform float f11;
uniform float f12;
uniform float f13;
uniform float f14;
uniform float f15;

uniform sampler2D dither_tex;
const float dither_size = 16.0;
uniform bool playing = false;

void fragment(){
	float bass = (f0 + f1 + f2 ) /3.0;
	float lowmid = (f3 + f4 + f5) /3.0;
	float mid = (f6 + f7 + f8) /3.0;
	float himid = (f11 + f12 + f13) /3.0;
	vec4 screen_tex = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	vec2 buv = SCREEN_UV - vec2(0.5);
	vec4 blur_tex = vec4(0,0,0,1);
	
	vec2 dith_uv = SCREEN_UV *  (dither_size * mid)  ;
	vec4 dither = texture(dither_tex,dith_uv);
	
	
	
	for(int i = 0; i <6; i++)
    {
        float scale = 1.0 + (float(i)*bass*0.25);
        blur_tex += texture(SCREEN_TEXTURE, buv * scale + vec2(0.5)) - vec4(0.0,0.2,0.0,0.0);
		blur_tex.rgb *= 0.9;
      
    }
	
//	screen_tex.rgb *= .5;
//	float bass = (f0 + f1 + f2 + f3) /4.0;
//	screen_tex.g += f7 *.1;
//	screen_tex.r += bass;
	vec3 blur_screen = screen_tex.rgb * .5 + blur_tex.rgb *.5;
	vec3 dithered_screen = step(dither.r, blur_screen);
	vec3 first_mix = dithered_screen + blur_screen;
	first_mix.r += f4 * .5;
	first_mix.g -= f4 *.5;

	first_mix.b += himid;
	if(playing){ALBEDO = first_mix ;}
	else{ALBEDO = screen_tex.rgb ;}
//	ALBEDO = first_mix ;
//	ALBEDO = blur_tex.rgb ;
//	ALBEDO = screen_tex.rgb ;
	
}