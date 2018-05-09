require "timer_with_snooze/version"

module TimerWithSnooze

  class Alert
    attr_accessor :yr, :mm, :dd

    def initialize(hour=6, min=15)
      @stops = []
      tday = Alert.time_class.now
      yr = tday.year
      mn = tday.month
      dd = tday.day
      atime = [yr,mn,dd,hour,min,0]
      @stops << Time.new(*atime)
    end

    def _setting
      result = false
      until result
        hour = InputData.input_int_validation("タイマーの時間を入力")
        result = hour.between?(0,23)
        if !result
          puts "時間の値が不適です。"
        end
      end

      result = false
      until result
        minute = InputData.input_int_validation("タイマーの分を入力")
        result = minute.between?(0,59)
        if !result
          puts "分の値が不適です。"
        end
      end

      tday = Alert.time_class.now
      yr = tday.year
      mn = tday.month
      dd = tday.day
      time_arr = [yr,mn,dd,hour,minute,0]

      atime = Time.new(*time_arr)
      ans = InputData.input_str_validation("#{atime} この時刻を追加しますか？(y/n)", 'y')
      if ans
        @stops << atime
      end
    end

    def setting
      result = true
      while result
        _setting
        result = InputData.input_str_validation("さらに時刻を追加しますか？(y/n)", 'y')
      end

      list_all_stops
    end

    def self.time_class
      @time_class || Time
    end

    def self.runtime_class
      @runtime_class || Time
    end

    def add_alert(hour, min)
      tday = Alert.time_class.now
      yr = tday.year
      mn = tday.month
      dd = tday.day
      atime = [yr,mn,dd,hour,min,0]

      @stops << Time.new(*atime)
    end

    def last_stop
      @stops.last
    end

    def list_all_stops
      puts '設定時刻は以下の通りです。'
      @stops.each do |stop|
        puts "#{stop}"
      end
    end

    def print_stops
      @stops.each_with_index do |at, inx|
        puts "#{at} [#{inx}]"
      end
    end

    def ring

      enum = @stops.to_enum
      loop do
        begin
          stoptime = enum.next
          puts "in begin #{stoptime}"
          snoozup = nil
          loop do
            Signal.trap(:INT){
              if __method__ == :ring
                puts "SIGINT"
                exit(0)
              else
                puts "Snooze stoped\n"
               return true
              end
            }

            print ".";  #puts Alert.runtime_class.now

            if !snoozup and Alert.runtime_class.now >=  stoptime
              puts "snooze started at #{stoptime}"
              snoozup = snooze
            end
            sleep 5
          end

        rescue StopIteration => e
          puts "end of @stop"
          break
        end
      end
    end
    #
    def snooze
      Signal.trap(:INT){
        puts "Snooze stoped\n"
        #puts "#{__method__}\n"
        return true
      }

      5.times do
        print "wake up! "
        sleep 2
      end
      print "\n"
      return true

    end
  end

  class InputData
    def self.input_int_validation(message)
      rooping = true
      while rooping
        print "#{message} : "
        result = gets.chomp!
        if /\d/ === result
          result = result.to_i
          rooping = false
        else
          puts 'Input data is not integer.'
          rooping = true
        end
      end
      result
    end

    def self.input_str_validation(message, char)
      rooping = true
      while rooping
        print "#{message} : "
        result = gets.chomp!
        if /\D/ === result
            result
            rooping = false
        else
          puts 'Input character was not expected.'
          rooping = true
        end
      end
      result == char
    end
  end

end
