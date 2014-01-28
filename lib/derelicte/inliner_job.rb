require 'pry-nav'
module Derelicte
  class InlinerJob
    attr_reader :doc

    def initialize(doc, analyzer)
      @doc, @analyzer = doc, analyzer
    end

    def apply_rules_to_doc
      each_elements do |element|
        apply_rules_to(element)
      end
    end

    private
    attr_reader :analyzer

    def apply_rules_to(element)
      rules = assignments.get(element)
      return nil if rules.nil? || rules.length == 0
      rule_str = unique_rules(rules).map(&:to_s).map(&:chomp).join
      element.set_attribute('style', rule_str)
    end

    def assignments
      @assignments ||= analyzer.assing_declarations_to_dom(doc, "screen", false)
    end

    def each_elements
      elements = doc.get_elements_by_tag_name "*"
      0.upto(elements.get_length - 1).each do |idx|
        element = elements.item(idx)
        yield(element)
      end
    end

    def unique_rules(rules)
      hash = rules.inject({}) do |hash, rule|
        hash[rule.property] = rule
        hash
      end
      hash.values
    end
  end
end
