const std = @import("std");
const fmtValueLiteral = @import("fmt-valueliteral").fmtValueLiteral;

pub fn main() !void {
    const out = std.io.getStdOut().writer();
    try fmtValueLiteral(out, "All your codebase are belong to us.", true);
    try out.writeAll("\n");
}
