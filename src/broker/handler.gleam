import gleam/socket
import gleam/erlang/binary
import gleam/io
import gleam/otp/actor

pub fn handle_request(msg, state, conn) {
  // Construct the response:
  // 4 bytes for message length (8) and 4 bytes for correlation ID (7)
  let response = <<0:32, 7:32>> 
  
  // Send the response back to the client
  case socket.send(conn, response) {
    Ok(_) -> 
      let _ = io.println("Sent hardcoded correlation ID response.")
      actor.Continue(state)
    Err(error) -> 
      let _ = io.println("Failed to send response: \(error)")
      actor.Stop(state)
  }
}
