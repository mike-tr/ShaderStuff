shader_type spatial;
render_mode unshaded;
render_mode cull_front;
//render_mode skip_vertex_transform;

const vec3 centerA = vec3(0.0);
const float radiusA = 0.1;
const vec3 centerB = vec3(0.3);
const float radiusB = 0.2;

uniform sampler2D noise_tex;

uniform vec3 oscale = vec3(1.0);
uniform float droplet_size = 1.;
uniform float droplet_frequency = 1.;
uniform float rain_speed = 1.;


float map(vec3 p){
	
	vec3 q = p;
	q.y += TIME *2. * rain_speed ;
	//if(wave < 0.){
		//wave = 0.;
	//}
	//q.x += wave * 5.;
	//q.x += sin(TIME * 0.1) * 2.;
	//q.z += sin(TIME * 0.1 + 0.5) * 1.;
	//q += 1.2*p;
	q = fract(q) - .5;
	//q -= p * 0.01;
	
	float p1 = length(q - (centerA)) - radiusA * droplet_size;
	float p2 = length(p - (centerB)) - radiusB;
	
	//vec3 q = fract(p1) - .5;
	//return min(p2,p1) / length(wscale);
	return p1;
}

varying vec3 vert;
varying vec3 ray_origin;
varying vec3 wscale;

const float minDistance = 0.001;
const float maxDistance = 25.0;
vec3 ray_match(vec3 start, vec3 dir){
	float d;
	float depth = 0.;
	vec3 current_pos = start;
	
	vec3 v = wscale * droplet_frequency * 0.01 / oscale;
	float vs = length(v);

	for(int i=0; i < 80; i++){
		d = map(current_pos * v) / vs;
		depth += d;
		current_pos += dir * d;
		if(d < minDistance || depth > maxDistance){
			return vec3(d, depth, float(i));
		}
	}
	return vec3(d, depth, 80);
}

void vertex() {
	//mat4 normalMatrix = mat4(
	    //normalize(MODEL_MATRIX[0]),
	    //normalize(MODEL_MATRIX[1]),
	    //normalize(MODEL_MATRIX[2]),
		//MODEL_MATRIX[3]);
	ray_origin = (inverse(MODEL_MATRIX) * vec4(CAMERA_POSITION_WORLD, 1)).xyz;
	//ray_origin = CAMERA_POSITION_WORLD;
	
	// Called for every vertex the material is visible on.
	//VERTEX -= vec3(1);
	//translatedVertex = (INV_VIEW_MATRIX * vec4(VERTEX,1)).xyz;
	//VERTEX = translatedVertex;
	//float scale = length(MODEL_MATRIX[0]);
	//vec3 scale;
	wscale.x = length(MODEL_MATRIX[0]);
	wscale.y = length(MODEL_MATRIX[1]);
	wscale.z = length(MODEL_MATRIX[2]);
	//ray_origin *= 2.0;
	//VERTEX = VERTEX / scale;
	
	//VERTEX = (VIEW_MATRIX * MODELVIEW_MATRIX * vec4(VERTEX,1)).xyz;
	vert = VERTEX;
	
	//vec3 scale;
	//scale.x = length(MODEL_MATRIX[0]);
	//scale.y = length(MODEL_MATRIX[1]);
	//scale.z = length(MODEL_MATRIX[2]);
	//VERTEX = VERTEX / scale;
	//VERTEX = vert;
}

void fragment() {
	// Calculate the uv's since we are using a box, the following line is the way
	// We also make sure that the center (0,0) is has the value (0,0).
	// note that uvs are from (0 to 1) by default so we subtract 0.5
	vec2 uv = fract(UV * vec2(3,2))*1.0 - 0.5;
	// Get camera at object local space
	vec3 ray_dir = normalize(vert - ray_origin);
	
	//ray_origin = vec3(0,0,-3);
	//ray_dir = normalize(vec3(uv, 1));
	
	//ray_dir = normalize((INV_VIEW_MATRIX * vec4(VERTEX,1)).xyz - ray_origin);
	//vec3 ray_dir = normalize(translatedVertex - ray_origin);
	vec3 color = vec3(0,0.4,1);
	vec3 r = ray_origin + ray_dir * 0.5 + fract(CAMERA_POSITION_WORLD * 0.05);
	vec3 ray = ray_match(r, ray_dir);
	//vec3 ray = ray_match(ray_origin, ray_dir);
	
	//color *= ray.y;
	//if(ray.y < 0.5){
		//discard;
	//}
	//color = vec3(ray.x);
	// Check if there is hit
	if(ray.x > minDistance){
		discard;
	}
	//color.rb = uv;
	//color = vec3(depth * 0.02);
	ALBEDO = color;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
