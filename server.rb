require "json"
require "socket"

tcp = TCPServer.new(80)
$stdout.puts("Listening on port 80")

loop do
  Thread.start(tcp.accept) do |client|
    id = "0x" << (client.hash >> 1).to_s(16)

    $stdout.puts("#{id}: Request from #{client.peeraddr}")
    lines = []

    while line = client.gets
      lines << line
      $stdout.puts("#{id}: #{line}")

      break if line =~ /\A\s*\z/
    end

    response = lines.join

    client.puts("HTTP/1.1 200 OK")
    client.puts("Date: ")
    client.puts("Server: idiot")
    client.puts("Content-Type: text/plain")
    client.puts("Content-Length: #{response.length}")
    client.puts("")
    client.puts(response)
    client.close
  end
end
