shader_type spatial;
render_mode skip_vertex_transform;
//render_mode cull_front;

uniform sampler2D noise_tex;

void vertex() {
	// Called for every vertex the material is visible on.
	//VERTEX = (inverse(MODEL_MATRIX) * vec4(VERTEX, 1)).xyz;
	//vec3 scale;
	//scale.x = length(MODEL_MATRIX[0]);
	//scale.y = length(MODEL_MATRIX[1]);
	//scale.z = length(MODEL_MATRIX[2]);
	//VERTEX = VERTEX / scale;
	//VERTEX = (MODEL_MATRIX * vec4(VERTEX, 1)).xyz;
	VERTEX = (MODELVIEW_MATRIX * vec4(VERTEX, 1)).xyz;
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
