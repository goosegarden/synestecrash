shader_type spatial;


uniform float max_dot_size = 12.0;
varying vec2 suv;
//uniform float brightness = 0.2;
//uniform float darkness = 0.005;

void fragment()
{
	suv = SCREEN_UV ;
//	suv = SCREEN_UV + sin(TIME*0.5)*0.1;
	ALBEDO = vec3(0.8,0.1,0.1);
}

void light()
{
//	vec3 shade = dot(NORMAL, LIGHT) * ATTENUATION;
//	float smdt = max_dot_size + sin(TIME);
	float smdt = max_dot_size  ;

	float att_val = (ATTENUATION.r + ATTENUATION.g + ATTENUATION.b) /3.0; 
	float shade = dot(NORMAL, LIGHT) * att_val;
//	float shade = clamp(dot(NORMAL, LIGHT) * att_val, 0.0, 1.0);
//	float shade = dot(NORMAL, LIGHT) * length(ATTENUATION);
//	vec3 half_tone = vec3(1.0,1.0,1.0);
	vec3 half_tone =ALBEDO;
	vec4 dfc = mod(vec4(suv,1.0,1.0) * vec4(VIEWPORT_SIZE, 1.0,1.0), vec4(smdt,smdt,1.0,1.0)) ;
//	vec4 dfc = mod(FRAGCOORD, vec4(smdt,smdt,1.0,1.0)) ;
	

	float dist = length(dfc.xy - vec2(smdt/2.0, smdt/2.0));
	float dist_norm = dist / (smdt * 0.7071);
//	float stepdist = sin(TIME) - shade;
	float stepdist = 0.2- shade;
	
	if (dist_norm < stepdist ){
		half_tone = vec3(0.0,0.0,0.0);
	}
	
//	half_tone *= step(stepdist , shade );
//	half_tone = step(max_dot_size * darkness , shade * (dist  * brightness));
//	half_tone = step(max_dot_size * darkness , shade * (dist_norm  * brightness));
	
	
	
	 DIFFUSE_LIGHT =  half_tone ;
//	 DIFFUSE_LIGHT +=  col_dist;
}