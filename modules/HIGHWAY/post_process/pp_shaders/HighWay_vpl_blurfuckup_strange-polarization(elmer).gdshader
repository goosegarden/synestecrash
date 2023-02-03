shader_type canvas_item;

uniform sampler2D vp;


void fragment(){
	
	vec2 suv = SCREEN_UV;
	vec4 trail_tex = texture(SCREEN_TEXTURE, suv);
	
	vec4 direct_tex = texture(vp, suv);
	
	float intensity = trail_tex.r * 0.3 + trail_tex.g *0.5 + trail_tex.b*0.2;
	vec2 buv = suv - vec2(0.5);
	vec4 blur_tex = vec4(0,0,0,1);
    for(int i = 0; i <6; i++)
    {
        float scale = 1.0 + (float(i)* 0.0125);
        blur_tex += texture(SCREEN_TEXTURE, buv * scale + vec2(0.5)) - vec4(0.0,0.2,0.0,0.1);
		blur_tex *= 0.9;

		
        blur_tex += (texture(vp, buv * scale + vec2(0.5))- vec4(0.0,0.2,0.0,0.1)) *0.02;

    }

//	blur_tex /= 2.0;
	vec4 endcol = vec4(1,1,1,1);
	endcol.rgb = blur_tex.rgb * 0.1 + (direct_tex.rgb*0.4) ;
//	endcol.rgb = blur_tex.rgb * 0.1 + (direct_tex.rgb*0.3) + trail_tex.rgb * 0.3 ;
	
	blur_tex.rgb *=0.3;
	COLOR = blur_tex  ;

}