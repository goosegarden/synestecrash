shader_type canvas_item;

uniform sampler2D vp;


void fragment(){
	
	vec2 suv = SCREEN_UV;
	vec4 v_tex = texture(SCREEN_TEXTURE, suv);
	
	vec4 screen_tex = texture(vp, suv);
	
	float intensity = v_tex.r * 0.3 + v_tex.g *0.5 + v_tex.b*0.2;
	vec2 buv = suv - vec2(0.5);
	vec4 blurcol = vec4(0,0,0,1);
    for(int i = 0; i <6; i++)
    {
        float scale = 1.0 + (float(i)* 0.0125);
        blurcol += texture(SCREEN_TEXTURE, buv * scale + vec2(0.5)) - vec4(0.0,0.2,0.0,0.1);
		blurcol *= 0.9;
//		blurcol *= intensity;
		
        blurcol += (texture(vp, buv * scale + vec2(0.5))- vec4(0.0,0.2,0.0,0.1)) *0.02;
//        blurcol += screen_tex *(0.2 + 1.0- intensity);
//        blurcol += screen_tex *0.35;
    }
//	blurcol /= 9.0;
	blurcol /= 2.0;
	vec4 endcol = vec4(1,1,1,1);
	endcol.rgb = blurcol.rgb * 0.5 + (screen_tex.rgb*0.4) + v_tex.rgb * 0.1 ;
//	endcol.rgb = blurcol.rgb * (intensity ) + (screen_tex.rgb*0.5) * (1.0 - intensity );
//	endcol *= 1.1;
//	COLOR = blurcol  ;
	COLOR = endcol  ;
//	COLOR = v_tex  ;
}