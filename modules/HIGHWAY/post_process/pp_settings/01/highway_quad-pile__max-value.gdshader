shader_type canvas_item;

uniform sampler2D vp;

uniform sampler2D bg_tex;

uniform sampler2D t1;
uniform sampler2D t2;
uniform sampler2D t3;
uniform sampler2D t4;
uniform sampler2D t5;
uniform sampler2D t6;
//uniform sampler2D t7;
//uniform sampler2D t8;




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
//	vec4 c7 = texture(t7, uv) ;
//	vec4 c8 = texture(t8, uv) ;
	
//	vec4 trail = (c1+ c2 + c3 + c4 + c5 + c6 + c7) *0.18 ;
//	vec4 trail = (c1+ c2 + c3 + c4 + c5 + c6 ) *0.13 ;
//	vec4 trail = (c1+ c2 + c3 + c4 ) *0.18 ;
	vec4 trail = vec4(0.0,0.0,0.0,1.0);
//	trail.r = max(c1.r, trail.r);
	trail = max(trail,c1);
	trail = max(trail,c2);
	trail = max(trail,c3);
	trail = max(trail,c4);
	trail = max(trail,c5);
	trail = max(trail,c6);
	
//	if(screen_tex.a == 0.0){
//		COLOR = bg_col;
//	}else{
//		COLOR =  trail;
//	}
	
	
	COLOR =  trail;
	
}