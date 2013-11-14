module Typoforma
  class System
    def initialize

    end

    def is_theorem?(string)

    end

    def add_rule(r)
      raise "Must be a Typoforma::Rule, try System#new_rule" unless r.is_a? Rule
      rules << r
    end

    def new_rule(short_form)
      add_rule Rule.new(self, short_form)
    end

    def apply(rule_number, string)
      raise "no rule ##{rule_number}" unless rules[rule_number]
      rules[rule_number].apply_to(string)
    end

    def rules
      @rules ||= []
    end
  end

  class Rule
    attr_accessor :axiom?
    attr :short_form
    attr :system

    def parse
      # conver short form to some kind of internal structure
      # and defines transform
    end

    def initialize(system, rule)
      @system = system
      @short_form = rule
      parse()
    end

    def apply_to(string)
      # apply rule to string
      string
    end
  end
end