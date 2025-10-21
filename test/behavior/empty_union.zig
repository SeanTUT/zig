const builtin = @import("builtin");
const std = @import("std");
const expect = std.testing.expect;

test "empty enum auto tag type" {
    const E = enum {};
    const T = @typeInfo(E).@"enum".tag_type;
    try expect(T == noreturn);
}

test "empty enum explicit tag type" {
    const E = enum(noreturn) {};
    const T = @typeInfo(E).@"enum".tag_type;
    try expect(T == noreturn);
}

test "empty tagged union" {
    const U = union(enum) {};
    try expect(@typeInfo(U).@"union".tag_type.? == noreturn);
    try expect(@sizeOf(U) == 0);
    try expect(@alignOf(U) == 1);
}
