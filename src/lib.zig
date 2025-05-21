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
        .@"struct" => |v| {
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
        .int, .comptime_int => {
            try w.print("{d}", .{value});
        },
        .@"union" => |v| {
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
        .void => {
            try w.writeAll("{}");
        },
        .optional => |_| {
            if (value) |cap| {
                try fmtValueLiteral(w, cap, print_type_name);
            } else {
                try w.writeAll("null");
            }
        },
        .@"enum", .enum_literal => {
            try w.writeAll(".");
            try w.writeAll(@tagName(value));
        },
        .type => {
            try w.writeAll(@typeName(value));
        },
        .bool => {
            try w.writeAll(if (value) "true" else "false");
        },
        .noreturn => {
            comptime unreachable;
        },
        .float, .comptime_float => {
            try w.print("{d}", .{value});
        },
        .pointer => {
            comptime unreachable;
        },
        .array => {
            comptime unreachable;
        },
        .undefined => {
            try w.writeAll("undefined");
        },
        .null => {
            try w.writeAll("null");
        },
        .error_union => {
            comptime unreachable;
        },
        .error_set => {
            comptime unreachable;
        },
        .@"fn" => {
            comptime unreachable;
        },
        .@"opaque" => {
            comptime unreachable;
        },
        .frame => {
            comptime unreachable;
        },
        .@"anyframe" => {
            comptime unreachable;
        },
        .vector => {
            comptime unreachable;
        },
    }
}
