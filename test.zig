const std = @import("std");
const fmt = @import("fmt-valueliteral").fmtValueLiteral;
const expect = @import("expect").expect;
const nio = @import("nio");

// string
test {
    const alloc = std.testing.allocator;
    var list = nio.AllocatingWriter.init(alloc);
    defer list.deinit();
    try fmt(&list, "hello there!", false);
    try expect(list.items).toEqualString(
        \\"hello there!"
    );
}

// indexable
test {
    const alloc = std.testing.allocator;
    var list = nio.AllocatingWriter.init(alloc);
    defer list.deinit();
    try fmt(&list, [_]u32{ 66, 81, 99, 24, 36, 65, 24, 19, 25, 44 }, false);
    try expect(list.items).toEqualString(
        \\.{66,81,99,24,36,65,24,19,25,44}
    );
}
// slice
test {
    const alloc = std.testing.allocator;
    var list = nio.AllocatingWriter.init(alloc);
    defer list.deinit();
    try fmt(&list, &[_]u32{ 66, 81, 99, 24, 36, 65, 24, 19, 25, 44 }, false);
    try expect(list.items).toEqualString(
        \\&.{66,81,99,24,36,65,24,19,25,44}
    );
}

// struct
test {
    const alloc = std.testing.allocator;
    var list = nio.AllocatingWriter.init(alloc);
    defer list.deinit();
    try fmt(&list, (struct { a: u32, b: []const u8 }){ .a = 15, .b = "noot noot" }, false);
    try expect(list.items).toEqualString(
        \\.{.a = 15, .b = "noot noot"}
    );
}

// int
test {
    const alloc = std.testing.allocator;
    var list = nio.AllocatingWriter.init(alloc);
    defer list.deinit();
    try fmt(&list, @as(i64, 37), false);
    try expect(list.items).toEqualString(
        \\37
    );
}
test {
    const alloc = std.testing.allocator;
    var list = nio.AllocatingWriter.init(alloc);
    defer list.deinit();
    try fmt(&list, @as(i64, -8), false);
    try expect(list.items).toEqualString(
        \\-8
    );
}

// union
test {
    const alloc = std.testing.allocator;
    var list = nio.AllocatingWriter.init(alloc);
    defer list.deinit();
    try fmt(&list, (union(enum) { a: u32, b: f32 }){ .a = 6 }, false);
    try expect(list.items).toEqualString(
        \\.{ .a = 6 }
    );
}
test {
    const alloc = std.testing.allocator;
    var list = nio.AllocatingWriter.init(alloc);
    defer list.deinit();
    try fmt(&list, (union(enum) { a: u32, b: f32 }){ .b = 7.89 }, false);
    try expect(list.items).toEqualString(
        \\.{ .b = 7.89 }
    );
}

// void
test {
    const alloc = std.testing.allocator;
    var list = nio.AllocatingWriter.init(alloc);
    defer list.deinit();
    try fmt(&list, {}, false);
    try expect(list.items).toEqualString(
        \\{}
    );
}

// optional
test {
    const alloc = std.testing.allocator;
    var list = nio.AllocatingWriter.init(alloc);
    defer list.deinit();
    try fmt(&list, @as(?u0, 0), false);
    try expect(list.items).toEqualString(
        \\0
    );
}
test {
    const alloc = std.testing.allocator;
    var list = nio.AllocatingWriter.init(alloc);
    defer list.deinit();
    try fmt(&list, @as(?u0, null), false);
    try expect(list.items).toEqualString(
        \\null
    );
}

// enum
test {
    const alloc = std.testing.allocator;
    var list = nio.AllocatingWriter.init(alloc);
    defer list.deinit();
    try fmt(&list, @as(?u0, null), false);
    try expect(list.items).toEqualString(
        \\null
    );
}

// type
test {
    const alloc = std.testing.allocator;
    var list = nio.AllocatingWriter.init(alloc);
    defer list.deinit();
    try fmt(&list, ?u8, false);
    try expect(list.items).toEqualString(
        \\?u8
    );
}

// bool
test {
    const alloc = std.testing.allocator;
    var list = nio.AllocatingWriter.init(alloc);
    defer list.deinit();
    try fmt(&list, true, false);
    try expect(list.items).toEqualString(
        \\true
    );
}
test {
    const alloc = std.testing.allocator;
    var list = nio.AllocatingWriter.init(alloc);
    defer list.deinit();
    try fmt(&list, false, false);
    try expect(list.items).toEqualString(
        \\false
    );
}

// float
test {
    const alloc = std.testing.allocator;
    var list = nio.AllocatingWriter.init(alloc);
    defer list.deinit();
    try fmt(&list, @as(f32, 3.14), false);
    try expect(list.items).toEqualString(
        \\3.14
    );
}

// comptime_float
test {
    const alloc = std.testing.allocator;
    var list = nio.AllocatingWriter.init(alloc);
    defer list.deinit();
    try fmt(&list, 3.14, false);
    try expect(list.items).toEqualString(
        \\3.14
    );
}

// comptime_int
test {
    const alloc = std.testing.allocator;
    var list = nio.AllocatingWriter.init(alloc);
    defer list.deinit();
    try fmt(&list, 28, false);
    try expect(list.items).toEqualString(
        \\28
    );
}

// undefined
test {
    const alloc = std.testing.allocator;
    var list = nio.AllocatingWriter.init(alloc);
    defer list.deinit();
    try fmt(&list, undefined, false);
    try expect(list.items).toEqualString(
        \\undefined
    );
}

// null
test {
    const alloc = std.testing.allocator;
    var list = nio.AllocatingWriter.init(alloc);
    defer list.deinit();
    try fmt(&list, null, false);
    try expect(list.items).toEqualString(
        \\null
    );
}

// enum literal
test {
    const alloc = std.testing.allocator;
    var list = nio.AllocatingWriter.init(alloc);
    defer list.deinit();
    try fmt(&list, .zig, false);
    try expect(list.items).toEqualString(
        \\.zig
    );
}
