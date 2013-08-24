require "socket"
require "pry"

server = "chat.freenode.net"
port = "6667"
nick = "MomooBot"
channel = "#bitmaker"
greeting_prefix = "privmsg #bitmaker :"
greetings = [" "]

irc_server = TCPSocket.open(server, port)

irc_server.puts "USER bhellobot 0 * BHelloBot"
irc_server.puts "NICK #{nick}"
irc_server.puts "JOIN #{channel}"

until irc_server.eof? do
	msg = irc_server.gets.downcase
	puts msg
	
	wasGreeted = false
  	greetings.each do |g|
		wasGreeted = true if msg.include? g
  	end

	if msg.include? greeting_prefix and wasGreeted
		response = "what..."
		msg = msg.split("privmsg #bitmaker :")
		msg = msg[1]

		irc_server.puts "PRIVMSG #{channel} :#{msg}"
	end
end