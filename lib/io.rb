module Io
  
  def outgoing
    Iolike.outgoing
  end
  
  def self.outgoing
    @outgoing ||= $stdout
  end
  
  def incoming
    Iolike.incoming
  end
  
  def self.incoming
    @incoming ||= $stdin
  end
  
  def get_input(message_prompt, validation)
    prompt(message_prompt)
    input = incoming.gets.chomp
    return input if input =~ validation
    invalid_data(input)
    get_input(message_prompt, validation)
  end
  
  private
  
  def invalid_data(data)
    outgoing.puts "You've entered #{data}, which is invalid"
  end
  
  def prompt(message)
    outgoing.print "#{message}: "
  end
  
end
  