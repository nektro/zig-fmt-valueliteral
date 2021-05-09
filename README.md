# zig-fmt-valueliteral

Print a value to a writer as it would be written in Zig syntax as a (x) literal.

## Api
- `pub fn fmtValueLiteral(w: std.io.Writer, value: anytype, comptime print_type_name: bool) !void`
    - `w` is an `anytype` for any value that implements `std.io.Writer`. It will then print the respective syntax literal to it.
    - `value` is anything you'd like it to print. Should it fail to print a value you feel it should be able to please open an issue.
    - `print_type_name` is a bool for whether or not you'd like it to print `@typeName(T)` or `.` when printing structs, enums, and unions.

## License
MIT
