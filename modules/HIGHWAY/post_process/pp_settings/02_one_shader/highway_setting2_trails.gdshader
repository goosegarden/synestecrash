shader_type canvas_item;

uniform sampler2D vp;


uniform sampler2D t1;
uniform sampler2D t2;
uniform sampler2D t3;
uniform sampler2D t4;
uniform sampler2D t5;
uniform sampler2D t6;



void fragment(){
	
	vec4 screen_tex = texture(vp, SCREEN_UV);
	vec2 uv = SCREEN_UV ;


	vec4 c1 = texture(t1, uv) ;
	vec4 c2 = texture(t2, uv) ;
	vec4 c3 = texture(t3, uv) ;
	vec4 c4 = texture(t4, uv) ;
	vec4 c5 = texture(t5, uv) ;
	vec4 c6 = texture(t6, uv) ;

	vec4 trail = vec4(0.0,0.0,0.0,1.0);

//	trail = max(trail,c1);
//	trail = max(trail,c2);
//	trail = max(trail,c3);
//	trail = max(trail,c4);
//	trail = max(trail,c5);
//	trail = max(trail,c6);
	
	trail = c1 + c2 + c3 + c4 + c5 + c6;
	
	trail *= .1;

	COLOR =  trail ;

	
}