shader_type canvas_item;

uniform float radius_scale: hint_range(0.0, 1.0, 0.1) = 0.1;
uniform bool rounded_corner_top_left = true;
uniform bool rounded_corner_top_right = true;
uniform bool rounded_corner_bottom_left = true;
uniform bool rounded_corner_bottom_right = true;
uniform float width = 1.0;
uniform float height = 1.0;
uniform float opacity: hint_range(0.0, 1.0) = 1.0;
uniform bool isInRadians = false;

group_uniforms ShaderParameters.RadianRotation;
uniform float xRadians: hint_range(0, 6.2830); // X IS FIXED
uniform float yRadians: hint_range(0, 6.2830); // Y IS FIXED
uniform float zRadians: hint_range(0, 6.2830); // Z IS FIXED
group_uniforms;

group_uniforms ShaderParameters.DegreesRotation;
uniform float xDegrees: hint_range(0, 360); // X IS FIXED
uniform float yDegrees: hint_range(0, 360); // Y IS FIXED
uniform float zDegrees: hint_range(0, 360); // Z IS FIXED
group_uniforms;

void fragment() {
	vec4 image = texture(TEXTURE, UV);
	vec2 pos = vec2(UV.x*width, UV.y*height);
	float radius = min(width, height)*radius_scale/2.0;
	float dist;
	// Top left corner
	if (rounded_corner_top_left) {
		dist = length(pos - vec2(radius));
		if (dist > radius && pos.x < radius && pos.y < radius) {
			image.a = 0.0;
		}

	}

	if (rounded_corner_top_right) {
		dist = length(pos - vec2(width-radius, radius));
		if (dist > radius && pos.x > width-radius && pos.y < radius) {
			image.a = 0.0;
		}

	}

	if (rounded_corner_bottom_left) {
		dist = length(pos - vec2(radius, height-radius));
		if (dist > radius && pos.x < radius && pos.y > height-radius) {
			image.a = 0.0;
		}

	}

	if (rounded_corner_bottom_right) {
		dist = length(pos - vec2(width-radius, height-radius));
		if (dist > radius && pos.x > width-radius && pos.y > height-radius) {
			image.a = 0.0;
		}

	}

    image.a *= opacity;

	COLOR = image;
}







