# completion                                                                                            
require 'irb/completion'                                                                                
ARGV.concat [ "--readline", "--prompt-mode", "simple" ]                                                 
                                                                                                        
# history                                                                                               
require 'irb/ext/save-history'           
# IRB.conf[:USE_READLINE] = false                                                               
IRB.conf[:SAVE_HISTORY] = 100                                                                           
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

require "readline"

module IRB
  module HistorySavingAbility
    @RCS_ID='-$Id: save-history.rb 11708 2007-02-12 23:01:19Z shyouhei $-'
  end

  class Context
    def init_save_history
      unless (class<<@io;self;end).include?(HistorySavingAbility)
  @io.extend(HistorySavingAbility)
      end
    end

    def save_history
      IRB.conf[:SAVE_HISTORY]
    end

    def save_history=(val)
      IRB.conf[:SAVE_HISTORY] = val
      if val
  main_context = IRB.conf[:MAIN_CONTEXT]
  main_context = self unless main_context
  main_context.init_save_history
      end
    end

    def history_file
      IRB.conf[:HISTORY_FILE]
    end

    def history_file=(hist)
      IRB.conf[:HISTORY_FILE] = hist
    end
  end

  module HistorySavingAbility
    include Readline

    # file should be a valid file_path to the history file
    # number_of_lines should be an Integer with the number of history lines to save
    def self.exit(file, number_of_lines, history, erasedups)
      if number_of_lines && number_of_lines > 0 then
        path = File.expand_path(file)
        File.open(path, 'w') do |f|
          history = history.reverse.uniq.reverse if erasedups
          # Instead of hist[-num..-1] || hist, we can just use Array#last
          f.puts(history.last(number_of_lines))
        end
      end
    end

    def HistorySavingAbility.extended(obj)
      # A finalizer is NOT guaranteed to run, bad choice for history saving
      # mechanism
      Kernel.at_exit do
        begin
          HistorySavingAbility.exit(
            IRB.conf[:HISTORY_FILE] || IRB.rc_file("_history"),
            IRB.conf[:SAVE_HISTORY].to_i,
            HISTORY.to_a,
            IRB.conf[:HISTORY_NO_DUPS]
          )
        rescue
          puts $!, *$!.backtrace
          raise
        end
      end
      obj.load_history
      obj
    end

    def load_history
      hist = IRB.conf[:HISTORY_FILE]
      hist = IRB.rc_file("_history") unless hist
      File.foreach(hist) do |line| HISTORY << line.chomp end
    rescue Errno::ENOENT # history file doesn't yet exist
    end
  end
end
