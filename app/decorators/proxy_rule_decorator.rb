# frozen_string_literal: true

class ProxyRuleDecorator < ApplicationDecorator
  self.include_root_in_json = false

  def pattern
    pattern_value = object.pattern
    return pattern_value unless backend_api_path
    File.join('/', backend_api_path, pattern_value)
  end

  def metric_system_name
    object.metric.extended_system_name
  end

  private

  def delegatable?(method)
    return false if self.class.instance_methods(false).include?(method.to_sym)
    object.respond_to?(method)
  end

  def backend_api_path
    context[:backend_api_path]
  end
end
