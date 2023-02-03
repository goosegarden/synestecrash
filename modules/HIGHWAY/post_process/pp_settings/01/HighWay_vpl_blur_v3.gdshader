shader_type canvas_item;

uniform sampler2D vp;


void fragment(){
	
	vec2 suv = SCREEN_UV;
	vec4 trail_tex = texture(SCREEN_TEXTURE, suv);
	
	vec4 direct_tex = texture(vp, suv);
	
	vec2 buv = suv - vec2(0.5);
	vec4 blur_tex = vec4(0,0,0,1);
	
	float st = sin(TIME);
	
    for(int i = 0; i <6; i++)
    {
        float scale = 1.0 + (float(i)* 0.03);
        blur_tex += texture(SCREEN_TEXTURE, buv * scale + vec2(0.5)) - vec4(0.0,0.2,0.0,0.1);
		blur_tex *= 0.9;
        blur_tex += (texture(vp, buv * scale + vec2(0.5))- vec4(0.0,0.2,0.0,0.1)) *0.02;
    }

	vec4 endcol = vec4(1,1,1,1);
	vec4 endtrails = vec4(1,1,1,1);
	endtrails.rgb = (direct_tex.rgb*0.6) + trail_tex.rgb * 0.4;
	endcol.rgb = direct_tex .rgb *0.3 + blur_tex.rgb * 0.1 + endtrails.rgb *1.0 ;
//	endcol *= 0.9;
	
	COLOR = endcol  ;

}