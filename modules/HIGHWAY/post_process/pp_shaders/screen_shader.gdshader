shader_type canvas_item;

uniform sampler2D vp;
//const vec3 c = vec3(0.0,0.1,1.0);

void fragment(){
	
	vec4 sc = texture(vp, SCREEN_UV);
	vec4 b = vec4(0.0,0.0,0.0,1.0);
	b.r = ceil(sc.r * 0.1);
	b.g = ceil(sc.g * 0.1);
	b.b = ceil(sc.b * 0.1);
	vec4 c= vec4(0.0,0.0,0.0,1.0);
	
	float y = 0.4;
	
	c.r = max(b.r * y , sc.r);
	c.g = max(b.g * y, sc.g);
	c.b = max(b.b * y, sc.b);
	
	COLOR = sc;
	
}