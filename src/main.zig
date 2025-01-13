const std = @import("std");
const glfw = @import("zglfw");
const zgpu = @import("zgpu");
const wgpu = zgpu.wgpu;
const shader = @embedFile("shader.wgsl");
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
    while (!glfw.windowShouldClose(window)) {
        glfw.pollEvents();
    }
}
