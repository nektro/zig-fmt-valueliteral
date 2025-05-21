# zig-fmt-valueliteral

![loc](https://sloc.xyz/github/nektro/zig-fmt-valueliteral)
[![license](https://img.shields.io/github/license/nektro/zig-fmt-valueliteral.svg)](https://github.com/nektro/zig-fmt-valueliteral/blob/master/LICENSE)
[![nektro @ github sponsors](https://img.shields.io/badge/sponsors-nektro-purple?logo=github)](https://github.com/sponsors/nektro)
[![Zig](https://img.shields.io/badge/Zig-0.14-f7a41d)](https://ziglang.org/)
[![Zigmod](https://img.shields.io/badge/Zigmod-latest-f7a41d)](https://github.com/nektro/zigmod)

Print a value to a writer as it would be written in Zig syntax as a (x) literal.

## Api
- `pub fn fmtValueLiteral(w: std.io.Writer, value: anytype, comptime print_type_name: bool) !void`
    - `w` is an `anytype` for any value that implements `std.io.Writer`. It will then print the respective syntax literal to it.
    - `value` is anything you'd like it to print. Should it fail to print a value you feel it should be able to please open an issue.
    - `print_type_name` is a bool for whether or not you'd like it to print `@typeName(T)` or `.` when printing structs, enums, and unions.
