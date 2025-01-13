struct VertexOut {
     @builtin(position) position_clip: vec4<f32>,
}

@vertex fn vmain ( @location(0) position: vec3<f32>) -> VertexOut {
    var output: VertexOut;
    output.position_clip = vec4(position, 1.0);
    return output;
}

@fragment fn fmain() -> @location(0) vec4<f32> {
    return vec4(vec3(1.0), 1.0);
}