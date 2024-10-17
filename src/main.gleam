import gleam/io
import gleam/erlang/process
import gleam/otp/actor
import glisten
import broker/server

pub fn main() {
  // You can use print statements as follows for debugging, they'll be visible when running tests.
  io.println("Starting Kafka broker...")

  // Start the Kafka broker server on port 9092
  broker.server.start_server(9092)

  // Prevent the main process from exiting
  process.sleep_forever()
}
