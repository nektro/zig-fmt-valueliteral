const std = @import("std");
const extras = @import("extras");

pub fn fmtValueLiteral(w: anytype, value: anytype, print_type_name: bool) !void {
    const TO = @TypeOf(value);
    const TI = @typeInfo(TO);
    if (comptime extras.isZigString(TO)) {
        try w.print("\"{}\"", .{std.zig.fmtEscapes(value)});
        return;
    }
    if (comptime extras.isIndexable(TO)) {
        if (comptime extras.isSlice(TO)) {
            try w.writeAll("&");
        }
        try w.writeAll(".{");
        for (value, 0..) |item, i| {
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
            inline for (v.fields, 0..) |sf, j| {
                try w.print(".{s} = ", .{sf.name});
                try fmtValueLiteral(w, @field(value, sf.name), print_type_name);
                if (j < v.fields.len - 1) {
                    try w.writeAll(", ");
                }
            }
            try w.writeAll("}");
        },
        .Int, .ComptimeInt => {
            try w.print("{d}", .{value});
        },
        .Union => |v| {
            try w.writeAll(if (print_type_name) @typeName(TO) else ".");
            const UnionTagType = v.tag_type.?;
            try w.writeAll("{ .");
            try w.writeAll(@tagName(@as(UnionTagType, value)));
            try w.writeAll(" = ");
            inline for (v.fields) |u_field| {
                if (value == @field(UnionTagType, u_field.name)) {
                    try fmtValueLiteral(w, @field(value, u_field.name), print_type_name);
                }
            }
            try w.writeAll(" }");
        },
        .Void => {
            try w.writeAll("{}");
        },
        .Optional => |_| {
            if (value) |cap| {
                try fmtValueLiteral(w, cap, print_type_name);
            } else {
                try w.writeAll("null");
            }
        },
        .Enum, .EnumLiteral => {
            try w.writeAll(".");
            try w.writeAll(@tagName(value));
        },
        .Type => {
            try w.writeAll(@typeName(value));
        },
        .Bool => {
            try w.writeAll(if (value) "true" else "false");
        },
        .NoReturn => {
            comptime unreachable;
        },
        .Float, .ComptimeFloat => {
            try w.print("{d}", .{value});
        },
        .Pointer => {
            comptime unreachable;
        },
        .Array => {
            comptime unreachable;
        },
        .Undefined => {
            try w.writeAll("undefined");
        },
        .Null => {
            try w.writeAll("null");
        },
        .ErrorUnion => {
            comptime unreachable;
        },
        .ErrorSet => {
            comptime unreachable;
        },
        .Fn => {
            comptime unreachable;
        },
        .Opaque => {
            comptime unreachable;
        },
        .Frame => {
            comptime unreachable;
        },
        .AnyFrame => {
            comptime unreachable;
        },
        .Vector => {
            comptime unreachable;
        },
    }
}
