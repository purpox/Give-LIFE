shader_type spatial;

uniform sampler2D face_sheet : source_color, filter_nearest;
uniform int frame_index = 0; // 0 to 15
uniform vec2 grid_size = vec2(4.0, 4.0); // 4 columns across, 4 rows down

void fragment() {
    vec2 frame_size = 1.0 / grid_size;
    float col = float(frame_index % int(grid_size.x));
    float row = float(frame_index / int(grid_size.x));

    vec2 uv = UV * frame_size;
    uv.x += col * frame_size.x;
    uv.y += row * frame_size.y;

    vec4 tex = texture(face_sheet, uv);
    ALBEDO = tex.rgb;
    ALPHA = tex.a;
}