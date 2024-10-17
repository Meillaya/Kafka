import gleam/socket
import gleam/io
import gleam/erlang/process
import gleam/otp/actor
import gleam/erlang/binary
import broker/handler

pub fn start_server(port) {
  case socket.listen("0.0.0.0", port) {
    Ok(listener) -> 
      io.println("Kafka broker listening on port \(port)")
      accept_connections(listener)
    Err(error) -> 
      io.println("Failed to start server: \(error)")
  }
}

fn accept_connections(listener) {
  case socket.accept(listener) {
    Ok(conn) -> 
      spawn_actor(conn)
      accept_connections(listener)
    Err(error) -> 
      io.println("Failed to accept connection: \(error)")
      accept_connections(listener)
  }
}

fn spawn_actor(conn) {
  actor.spawn(fn(state) {
    loop(state, conn)
  }, initial_state)
}

fn loop(state, conn) {
  // Here you would normally receive and parse the request.
  // For this stage, we're directly sending the hardcoded response.
  handler.handle_request(nil, state, conn)
}
