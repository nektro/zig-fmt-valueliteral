const std = @import("std");

pub fn fmtValueLiteral(w: anytype, value: anytype, print_type_name: bool) !void {
    const TO = @TypeOf(value);
    const TI = @typeInfo(TO);
    if (comptime std.meta.trait.isZigString(TO)) {
        try w.print("\"{}\"", .{std.zig.fmtEscapes(value)});
        return;
    }
    if (comptime std.meta.trait.isIndexable(TO)) {
        try w.writeAll(".{");
        for (value) |item, i| {
            try fmtValueLiteral(w, item, print_type_name);
            if (i < value.len - 1) {
                try w.writeAll(",");
            }
        }
        try w.writeAll("}");
        return;
    }
    switch (TI) {
        .Struct => |v| {
            try w.writeAll(if (print_type_name) @typeName(TO) else ".");
            try w.writeAll("{");
            inline for (v.fields) |sf, j| {
                try w.print(".{s} = ", .{sf.name});
                try fmtValueLiteral(w, @field(value, sf.name), print_type_name);
                try w.writeAll(",");
                if (j < v.fields.len) {
                    try w.writeAll(" ");
                }
            }
            try w.writeAll("}");
        },
        .Int => {
            try w.print("{d}", .{value});
        },
        .Union => |v| {
            try w.writeAll(if (print_type_name) @typeName(TO) else ".");
            const UnionTagType = v.tag_type.?;
            try w.writeAll("{.");
            try w.writeAll(@tagName(@as(UnionTagType, value)));
            try w.writeAll(" = ");
            inline for (v.fields) |u_field| {
                if (value == @field(UnionTagType, u_field.name)) {
                    try fmtValueLiteral(w, @field(value, u_field.name), print_type_name);
                }
            }
            try w.writeAll("}");
        },
        .Void => {
            try w.writeAll("void{}");
        },
        else => {
            @compileError(@tagName(TI) ++ " " ++ @typeName(TO));
        },
    }
}
