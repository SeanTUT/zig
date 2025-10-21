pub export fn entry1() void {
    const U = union(enum) {
        a: u32,
        b: noreturn,
        fn foo(_: @This()) void {}
        fn bar() noreturn {
            unreachable;
        }
    };

    var a: U = .{ .b = undefined };
    _ = &a;
}
pub export fn entry2() void {
    const U = union(enum) {
        a: noreturn,
    };
    var u: U = undefined;
    _ = &u;
}
pub export fn entry3() void {
    @setRuntimeSafety(false);
    const U = union {
        a: noreturn,
        b: void,
    };
    var u: U = undefined;
    u.a = undefined;
}
pub export fn entry4() void {
    const U = union(enum) {
        a: noreturn,
        b: void,
    };
    var e = @typeInfo(U).@"union".tag_type.?.a;
    var u: U = undefined;
    u = (&e).*;
}

// error
//
// :11:24: error: cannot initialize 'noreturn' field of union
// :4:9: note: 'noreturn' field 'b' declared here
// :2:15: note: union declared here
// :18:16: error: expected type 'tmp.entry2.U', found '@TypeOf(undefined)'
// :18:16: note: cannot coerce to 'tmp.entry2.U'
// :15:15: note: union declared here
// :28:6: error: cannot access 'noreturn' field of union
// :24:9: note: 'noreturn' field 'a' declared here
// :23:15: note: union declared here
// :37:13: error: runtime coercion from enum '@typeInfo(tmp.entry4.U).@"union".tag_type.?' to union 'tmp.entry4.U' which has a 'noreturn' field
// :32:9: note: 'noreturn' field here
// :31:15: note: union declared here
