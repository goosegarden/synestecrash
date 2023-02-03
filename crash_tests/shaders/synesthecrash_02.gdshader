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

uniform vec3 col1; 
uniform vec3 col2; 
uniform vec3 col3; 
uniform vec3 col4; 


uniform sampler2D dither_tex;
uniform sampler2D grain_tex;

const float dither_size = 36.0;
uniform bool playing = false;

void fragment(){
	float lobass = (f0 + f1 + f2 ) /3.0;
	float bass = ( f5 + f2 +f3 + f4) /4.0;
	float lowmid = (f5 + f6 + f7) /3.0;
	float mid = (f8 + f9 + f10) /3.0;
	float himid = (f10 + f11 + f12) /3.0;
	float highs = (f13 + f14 + f15) / 3.0 ;
	vec4 screen_tex = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	vec2 buv = SCREEN_UV - vec2(0.5);
	vec4 blur_tex = vec4(0,0,0,1);
	float dither_fac = max((dither_size * mid * 0.5),0.05);
	vec2 dith_uv = SCREEN_UV * dither_fac;
	vec4 dither = texture(dither_tex,dith_uv);
	
	vec4 grain = texture(grain_tex, SCREEN_UV * 13.0 * (himid));
	
	
	for(int i = 0; i <7; i++)
    {
        float scale = 1.0 + (float(i)*lobass*0.073);
        blur_tex += texture(SCREEN_TEXTURE, buv * scale + vec2(0.5)  )- vec4(0.01,0.01,0.01,0.0);
//        blur_tex += texture(SCREEN_TEXTURE, buv * scale + vec2(0.5)) - vec4(0.012,0.012,0.012,0.0);
//        blur_tex += texture(SCREEN_TEXTURE, buv * scale + vec2(0.5)) - vec4(0.0,0.2,0.0,0.0);
		blur_tex.rgb *= 0.7 + bass;
      
    }
	
//	screen_tex.rgb *= .5;
//	float bass = (f0 + f1 + f2 + f3) /4.0;
//	screen_tex.g += f7 *.1;
//	screen_tex.r += bass;
	vec3 blur_screen = screen_tex.rgb * .5 + blur_tex.rgb *.5;
	vec3 dithered_screen = step(dither.r, blur_screen);
	vec3 grain_screen = step(grain.r, screen_tex.rgb) * 2.0;
//	vec3 first_mix = dithered_screen *.2 + blur_screen *.6 + screen_tex.rgb *1.1 + ((1.0 - grain.r) * highs * 8.0 * vec3(0.07,0.08,0.01));
	vec3 first_mix = dithered_screen *.08  + blur_screen *.5 + screen_tex.rgb * 0.8 + grain_screen * highs * .4 * col4;
//	first_mix.r += f4 * .5;
//	first_mix.g -= f4 *.5;

	first_mix += col1 * lobass *.02 ;
	first_mix += col4 * highs *.02 ;
//	first_mix += vec3(lobass * 1.1 , -lobass *1.1  , -lobass *1.1 ) * .3;


//	first_mix += vec3(bass , -bass , -bass ) * .1;
//	first_mix += vec3(himid , himid *1.5 , -himid *2.0 ) * .1;
//	first_mix += vec3(-himid , himid , -himid ) * .1;
//	first_mix += vec3(highs , highs , highs ) * .2;
//	first_mix = normalize(first_mix)*0.3;

	if(playing){ALBEDO = first_mix ;}
	else{ALBEDO = screen_tex.rgb *0.9 ;}
//	ALBEDO = first_mix ;
//	ALBEDO = blur_tex.rgb ;
//	ALBEDO = screen_tex.rgb ;
	
}