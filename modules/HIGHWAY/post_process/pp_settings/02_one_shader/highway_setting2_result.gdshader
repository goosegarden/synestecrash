shader_type canvas_item;


uniform sampler2D vp;
uniform sampler2D dither_tex;
uniform float blur_fac = 0.0125;
uniform float dither_scale = 13.0;
uniform float dither_fac = 0.05;
uniform float trail_fac = 0.2;

void fragment(){
	
	vec4 screen_tex = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec4 vp_tex = texture(vp, SCREEN_UV);
	
	vec2 dith_uv = SCREEN_UV * vec2(1.0, 0.5625)  ;
	dith_uv = SCREEN_UV *16.0  ;

	vec4 dither = texture(dither_tex,dith_uv);
	

	vec2 buv = SCREEN_UV - vec2(0.5);
	vec4 blur_tex = vec4(0,0,0,1);
	
	
    for(int i = 0; i <6; i++)
    {
        float scale = 1.0 + (float(i)* blur_fac);
        blur_tex += texture(SCREEN_TEXTURE, buv * scale + vec2(0.5)) - vec4(0.0,0.2,0.0,0.1) * (trail_fac *0.05);
        blur_tex += (texture(vp, buv * scale + vec2(0.5))- vec4(0.0,0.2,0.0,0.1)) *(1.0 - trail_fac) * 0.05
    }

	vec4 endcol = vec4(1,1,1,1);

	endcol.rgb = blur_tex.rgb *0.1 ;

	vec4 dithered_screen = step(dither.r, endcol);
	
	float r = endcol.r * (1.0 - dither_fac +0.03) + dithered_screen.b * (dither_fac - 0.03);
	float b = endcol.b * (1.0 - dither_fac) + dithered_screen.b * (dither_fac) ;
	float g = endcol.g * (1.0 - dither_fac +0.02) + dithered_screen.g * (dither_fac + 0.02) ;
//	endcol.rgb *= .02;
	endcol.rgb += vp_tex.rgb * 1.3;
	COLOR = endcol ;
//	COLOR= vec4(r,g,b, 1.0)*1.6;

	
}