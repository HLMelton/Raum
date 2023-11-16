const std = @import("std");
const print = std.debug.print; 
const http = std.http;
const log = std.log.scoped(.server);

const serverAddress = "127.0.0.1";
const serverPort = 8000;

fn runServer(server: *http.Server, allocator: std.mem.Allocator) !void {
    // Need to build
    try handleRequest(&response, allocator);
};


fn handleRequest(response: *http.Server.Response, allocator: std.mem.Allocator) !void {
    // Need to build

    // Returns a 404
    response.status = .not_found;
    try response.do();
}


pub fn main() !void {

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var server = http.Server.init(allocator, .{ .reuse_address = true});
    defer server.deinit();

    log.info("Server is running at {s}:{d}", .{serverAddress, serverPort});


    runServer(&server, allocator) catch |err|{
        log.err("Server caught an error: {}\n", .{err});
        if (@errorReturnTrace()) |trace|{
            std.debug.dumpStackTrace(trace.*);
        }
        std.os.exit(1);
    };
}
