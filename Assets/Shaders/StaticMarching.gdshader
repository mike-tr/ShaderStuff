shader_type spatial;
render_mode unshaded;

const vec3 centerA = vec3(0.0);
const vec3 centerB = vec3(0.9,0,0);
const float radiusA = 1.0;
const float radiusB = 1.0;
float map(vec3 p){
	float p1 = length(p - (centerA)) - radiusA;
	float p2 = length(p - (centerB)) - radiusB;
	return min(p1,p2);
}

varying vec3 vert;
void vertex() {
	// Called for every vertex the material is visible on.
	//VERTEX -= vec3(1);
	//translatedVertex = (INV_VIEW_MATRIX * vec4(VERTEX,1)).xyz;
	//VERTEX = translatedVertex;

	//vert = (INV_VIEW_MATRIX * vec4(VERTEX,1)).xyz;
}

const float midance = 0.001;
const float maxDistance = 100.0;

void fragment() {
	// Calculate the uv's since we are using a box, the following line is the way
	// We also make sure that the center (0,0) is has the value (0,0).
	// note that uvs are from (0 to 1) by default so we subtract 0.5
	//vec3 world_position = MODEL_MATRIX[3].xyz;

	vec2 uv = fract(UV * vec2(3,2))*4.0 - 2.;
	vec3 ray_origin = vec3(0,0,-2);
	vec3 ray_dir = normalize(vec3(uv, 1));


	//vec3 ray_dir = normalize((INV_VIEW_MATRIX * vec4(VERTEX,1)).xyz - ray_origin);
	//vec3 ray_dir = normalize(translatedVertex - ray_origin);
	vec3 color = vec3(0);


	float d = map(ray_origin);
	float depth = d;
	vec3 p = ray_origin + ray_dir * d;

	for(int i=0; i < 80; i++){
		if(d < midance || depth > maxDistance){
			break;
		}
		d = map(p);
		p = p + ray_dir * d;
		depth += d;
		color = vec3(float(i)) / 80.0;
	}

	color = vec3(depth * 0.02);
	//color = vec3(1);
	//color.rb = uv;
	//if(depth > maxDistance){
		////color = vec3(0);
		//ALPHA = 0.0;
	//}
	ALBEDO = color;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
