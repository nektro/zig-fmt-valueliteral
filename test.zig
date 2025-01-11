const std = @import("std");
const fmt = @import("fmt-valueliteral").fmtValueLiteral;
const expect = @import("expect").expect;

// string
test {
    const alloc = std.testing.allocator;
    var list = std.ArrayList(u8).init(alloc);
    defer list.deinit();
    try fmt(list.writer(), "hello there!", false);
    try expect(list.items).toEqualString(
        \\"hello there!"
    );
}

// indexable
test {
    const alloc = std.testing.allocator;
    var list = std.ArrayList(u8).init(alloc);
    defer list.deinit();
    try fmt(list.writer(), [_]u32{ 66, 81, 99, 24, 36, 65, 24, 19, 25, 44 }, false);
    try expect(list.items).toEqualString(
        \\.{66,81,99,24,36,65,24,19,25,44}
    );
}
// slice
test {
    const alloc = std.testing.allocator;
    var list = std.ArrayList(u8).init(alloc);
    defer list.deinit();
    try fmt(list.writer(), &[_]u32{ 66, 81, 99, 24, 36, 65, 24, 19, 25, 44 }, false);
    try expect(list.items).toEqualString(
        \\&.{66,81,99,24,36,65,24,19,25,44}
    );
}

// struct
test {
    const alloc = std.testing.allocator;
    var list = std.ArrayList(u8).init(alloc);
    defer list.deinit();
    try fmt(list.writer(), (struct { a: u32, b: []const u8 }){ .a = 15, .b = "noot noot" }, false);
    try expect(list.items).toEqualString(
        \\.{.a = 15, .b = "noot noot"}
    );
}

// int
test {
    const alloc = std.testing.allocator;
    var list = std.ArrayList(u8).init(alloc);
    defer list.deinit();
    try fmt(list.writer(), @as(i64, 37), false);
    try expect(list.items).toEqualString(
        \\37
    );
}
test {
    const alloc = std.testing.allocator;
    var list = std.ArrayList(u8).init(alloc);
    defer list.deinit();
    try fmt(list.writer(), @as(i64, -8), false);
    try expect(list.items).toEqualString(
        \\-8
    );
}

// union
test {
    const alloc = std.testing.allocator;
    var list = std.ArrayList(u8).init(alloc);
    defer list.deinit();
    try fmt(list.writer(), (union(enum) { a: u32, b: f32 }){ .a = 6 }, false);
    try expect(list.items).toEqualString(
        \\.{ .a = 6 }
    );
}
test {
    const alloc = std.testing.allocator;
    var list = std.ArrayList(u8).init(alloc);
    defer list.deinit();
    try fmt(list.writer(), (union(enum) { a: u32, b: f32 }){ .b = 7.89 }, false);
    try expect(list.items).toEqualString(
        \\.{ .b = 7.89 }
    );
}

// void
test {
    const alloc = std.testing.allocator;
    var list = std.ArrayList(u8).init(alloc);
    defer list.deinit();
    try fmt(list.writer(), {}, false);
    try expect(list.items).toEqualString(
        \\{}
    );
}

// optional
test {
    const alloc = std.testing.allocator;
    var list = std.ArrayList(u8).init(alloc);
    defer list.deinit();
    try fmt(list.writer(), @as(?u0, 0), false);
    try expect(list.items).toEqualString(
        \\0
    );
}
test {
    const alloc = std.testing.allocator;
    var list = std.ArrayList(u8).init(alloc);
    defer list.deinit();
    try fmt(list.writer(), @as(?u0, null), false);
    try expect(list.items).toEqualString(
        \\null
    );
}

// enum
test {
    const alloc = std.testing.allocator;
    var list = std.ArrayList(u8).init(alloc);
    defer list.deinit();
    try fmt(list.writer(), @as(?u0, null), false);
    try expect(list.items).toEqualString(
        \\null
    );
}

// type
test {
    const alloc = std.testing.allocator;
    var list = std.ArrayList(u8).init(alloc);
    defer list.deinit();
    try fmt(list.writer(), ?u8, false);
    try expect(list.items).toEqualString(
        \\?u8
    );
}

// bool
test {
    const alloc = std.testing.allocator;
    var list = std.ArrayList(u8).init(alloc);
    defer list.deinit();
    try fmt(list.writer(), true, false);
    try expect(list.items).toEqualString(
        \\true
    );
}
test {
    const alloc = std.testing.allocator;
    var list = std.ArrayList(u8).init(alloc);
    defer list.deinit();
    try fmt(list.writer(), false, false);
    try expect(list.items).toEqualString(
        \\false
    );
}

// float
test {
    const alloc = std.testing.allocator;
    var list = std.ArrayList(u8).init(alloc);
    defer list.deinit();
    try fmt(list.writer(), @as(f32, 3.14), false);
    try expect(list.items).toEqualString(
        \\3.14
    );
}

// comptime_float
test {
    const alloc = std.testing.allocator;
    var list = std.ArrayList(u8).init(alloc);
    defer list.deinit();
    try fmt(list.writer(), 3.14, false);
    try expect(list.items).toEqualString(
        \\3.14
    );
}

// comptime_int
test {
    const alloc = std.testing.allocator;
    var list = std.ArrayList(u8).init(alloc);
    defer list.deinit();
    try fmt(list.writer(), 28, false);
    try expect(list.items).toEqualString(
        \\28
    );
}

// undefined
test {
    const alloc = std.testing.allocator;
    var list = std.ArrayList(u8).init(alloc);
    defer list.deinit();
    try fmt(list.writer(), undefined, false);
    try expect(list.items).toEqualString(
        \\undefined
    );
}

// null
test {
    const alloc = std.testing.allocator;
    var list = std.ArrayList(u8).init(alloc);
    defer list.deinit();
    try fmt(list.writer(), null, false);
    try expect(list.items).toEqualString(
        \\null
    );
}

// enum literal
test {
    const alloc = std.testing.allocator;
    var list = std.ArrayList(u8).init(alloc);
    defer list.deinit();
    try fmt(list.writer(), .zig, false);
    try expect(list.items).toEqualString(
        \\.zig
    );
}
