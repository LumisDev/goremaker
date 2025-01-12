const std = @import("std");
const glfw = @import("zglfw");
const zgpu = @import("zgpu");
const wgpu = zgpu.wgpu;

pub fn main() !void {
    try glfw.init();
    const window = try glfw.createWindow(640, 480, "Hello!", null);
    defer glfw.destroyWindow(window);
    while (!glfw.windowShouldClose(window)) {
        glfw.pollEvents();
    }
}