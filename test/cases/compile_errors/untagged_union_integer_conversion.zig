const UntaggedUnion = union {
    field_a: void,
    field_b: void,
};
comptime {
    @intFromEnum(@as(UntaggedUnion, undefined));
}

// error
//
// :6:18: error: untagged union 'tmp.UntaggedUnion' cannot be converted to integer
// :1:23: note: union declared here
