shader_type canvas_item;

uniform sampler2D vp;

uniform sampler2D bg_tex;

uniform sampler2D t1;
uniform sampler2D t2;
uniform sampler2D t3;
uniform sampler2D t4;
uniform sampler2D t5;
uniform sampler2D t6;



void fragment(){
	
	vec4 screen_tex = texture(vp, SCREEN_UV);
	vec2 uv = SCREEN_UV ;
	vec4 bg_col = texture(bg_tex, SCREEN_UV*2.0);

	vec4 c1 = texture(t1, uv) ;
	vec4 c2 = texture(t2, uv) ;
	vec4 c3 = texture(t3, uv) ;
	vec4 c4 = texture(t4, uv) ;
	vec4 c5 = texture(t5, uv) ;
	vec4 c6 = texture(t6, uv) ;

	vec4 trail = vec4(0.0,0.0,0.0,1.0);

	trail = max(trail,c1);
	trail = max(trail,c2);
	trail = max(trail,c3);
	trail = max(trail,c4);
	trail = max(trail,c5);
	trail = max(trail,c6);
	
	vec2 suv = SCREEN_UV;

	vec2 buv = suv - vec2(0.5);
	vec4 blur_tex = vec4(0,0,0,1);
	
	float st = sin(TIME);
	
    for(int i = 0; i <6; i++)
    {
        float scale = 1.0 + (float(i)* 0.0125);
        blur_tex += texture(vp, buv * scale + vec2(0.5)) - vec4(0.0,0.2,0.0,0.1);
//		blur_tex *= 0.9;
//        blur_tex += (texture(trail, buv * scale + vec2(0.5))- vec4(0.0,0.2,0.0,0.1)) *0.02;
    }

	vec4 endcol = vec4(1,1,1,1);
	vec4 endtrails = vec4(1,1,1,1);
	endtrails.rgb = (screen_tex.rgb*0.6) + trail.rgb * 0.4;
	endcol.rgb = blur_tex.rgb * 0.3 + endtrails.rgb *1.1 ;
//	endcol *= 0.9;
	
	COLOR = endcol  ;
	
//	COLOR =  trail *.5 + screen_tex *.5;
	
}