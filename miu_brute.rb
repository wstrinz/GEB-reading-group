class MIU
  def initialize
    @str = "MI"
  end

  def r1
    if @str[-1] == "I"
      @str << "U"
    end
    @str
  end

  def r2
    @str << @str[1..-1]
    @str
  end

  def r3(times = 1)
    @str.gsub!("III","U")
    @str
  end

  def r4(times = 1)
    @str.gsub!("UU","")
    @str
  end

  def mutate(n: -1, max: nil, pattern: nil, delay: 0.1)
    t=0
    while t != n do
      self.send(:"r#{rand(4)+1}")
      puts @str if delay > 0

      sleep delay

      @str = "MI" if max && @str.size > max
      return @str if pattern and @str[pattern]

      t+=1
    end

    @str
  end

  def self.search_for(pattern, timeout=nil)
    n = self.new
    n.instance_eval do
      start = Time.now
      end_time = Time.now + timeout if timeout
      loop do
        r = mutate(n: 1, max: 10000, pattern: pattern, delay: 0)
        return r if r[pattern]
        return nil if timeout && Time.now > end_time
      end
    end
  end

  def self.steps_to(pattern, timeout=nil)
    n = self.new
    max_length = 10000
    n.instance_eval do
      start = Time.now
      end_time = Time.now + timeout if timeout
      steps = []
      t = 0

      steps << [t, @str.dup, "axiom"]

      ret = nil
      until ret do
        rule = rand(4)+1
        r = self.send(:"r#{rule}")

        if r.size > max_length
          t = 0
          @str = "MI"
          steps = [[t, @str.dup, "axiom"]]
        else
          t+=1
          steps << [t, @str.dup, "rule #{rule}"]
        end

        ret = steps if @str[pattern]
        ret = [["no","steps","found"]] if timeout && Time.now > end_time
      end
      ret
    end
  end

  def self.pretty_steps(pattern, timeout=nil)
    puts steps_to(pattern, timeout).map{|s| s.join "\t"}.join "\n"
  end
end