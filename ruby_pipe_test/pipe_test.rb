#!/usr/bin/env ruby

cmd = "find .."

threads = []
IO.popen(cmd) do |io|

  # Thread for reading
  threads << Thread.new do
  end

  # Thread for writing
  threads << Thread.new do
  end
  
  # Close both threads, when they're done
  threads.each { |t|  t.join }
end
