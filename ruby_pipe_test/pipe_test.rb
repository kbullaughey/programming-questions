#!/usr/bin/env ruby
require 'pry'

# This module is to be included in a class that implements a receive function:
#
#     def receive(str)
#       ...
#     end
# 
# `receive` will be passed the strings that are read in. When there is no more
# data, return nil.
# 
# The send function, on the other hand takes a block that will be called to 
# produce the data. The return value of this block should be data that is to 
# be sent to the pipe:
#
#     send {...} 
#
module FlowPipe
  def initialize(cmd, maxlen = 1024)
    @command = cmd
    @maxlen = maxlen
    raise NoMethodError, "must have receive method" unless self.respond_to? :receive
  end
  # This 
  def send(&block)
    IO.popen(@command, "r+") do |io|
      readers,writers = [io],[io]
      while true
        rready, wready = IO.select readers, writers, nil, 0
        if not wready.nil? and wready.length > 0
          input = block.call
          if input.nil?
            io.close_write
            writers = nil
          else
            fd = wready.first
            fd.puts input
            fd.flush
          end
        end
        if not rready.nil? and rready.length > 0
          begin
            data = rready.first.read_nonblock @maxlen
          rescue IO::WaitReadable
          rescue EOFError
            break
          else
            receive data
          end
        end
      end
    end
  end
end

class Cat
  include FlowPipe
  def receive(str)
    $stdout.write str
  end
end

input = %w(ninja babies attack)
cat = Cat.new "cat -"
cat.send {input.pop}

# END
