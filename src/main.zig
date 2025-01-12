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
    const window = try glfw.createWindow(640, 480, "Hello!", null);
    defer glfw.destroyWindow(window);
    const ctx = zgpu.GraphicsContext.create(allocator)
    while (!glfw.windowShouldClose(window)) {
        glfw.pollEvents();
    }
}
