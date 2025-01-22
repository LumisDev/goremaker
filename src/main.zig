const std = @import("std");
const glfw = @import("zglfw");
const zgpu = @import("zgpu");
const wgpu = zgpu.wgpu;
const shader_source = @embedFile("shader.wgsl");
pub fn main() !void {
    var general_purpose_allocator = std.heap.GeneralPurposeAllocator(.{}){};
    defer std.debug.assert(general_purpose_allocator.deinit() == .ok);
    const allocator = general_purpose_allocator.allocator();
    try glfw.init();
    defer glfw.terminate();
    const window = try glfw.Window.create(640, 480, "Hello!", null);
    defer window.destroy();
    const gctx = try zgpu.GraphicsContext.create(
        allocator,
        .{
            .window = window,
            .fn_getTime = @ptrCast(&glfw.getTime),
            .fn_getFramebufferSize = @ptrCast(&glfw.Window.getFramebufferSize),

            // optional fields
            .fn_getWin32Window = @ptrCast(&glfw.getWin32Window),
            .fn_getX11Display = @ptrCast(&glfw.getX11Display),
            .fn_getX11Window = @ptrCast(&glfw.getX11Window),
            .fn_getWaylandDisplay = @ptrCast(&glfw.getWaylandDisplay),
            .fn_getWaylandSurface = @ptrCast(&glfw.getWaylandWindow),
            .fn_getCocoaWindow = @ptrCast(&glfw.getCocoaWindow),
        },
        .{}, // default context creation options
    );
    defer gctx.destroy(allocator);
    const shader_module = zgpu.createWgslShaderModule(gctx.device, shader_source, "shader module");
    defer shader_module.release();
    const Vertex = struct {
        position: [2]f32,
    };
    const vertex_attributes = [_]zgpu.wgpu.VertexAttribute{
        .{
            .format = .float32x3,
            .offset = 0,
            .shader_location = 0,
        },
    };
    const vertex_buffer_layouts = [_]zgpu.wgpu.VertexBufferLayout{.{
        .array_stride = @sizeOf(Vertex),
        .attribute_count = vertex_attributes.len,
        .attributes = &vertex_attributes,
    }};
    _ = vertex_buffer_layouts;
    while (!glfw.windowShouldClose(window)) {
        glfw.pollEvents();
    }
}
