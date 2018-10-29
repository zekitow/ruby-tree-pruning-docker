# frozen_string_literal: true

class TreeService
  attr_accessor :upstream, :indicator_ids, :response

  def initialize(params)
    @upstream      = params[:name]
    @indicator_ids = params[:indicator_ids] || []
  end

  #
  # Performs the filter by "indicator_ids" on API
  #
  def perform
    @response = Request.get(upstream)
    filter_response_by_indicator_ids!(response.content) if indicator_ids.size.positive?
    validate_response!
    response
  end

  #
  # Deletes all nodes that doesn't match the "indicator_ids"
  #
  def filter_response_by_indicator_ids!(content)
    result = content.each do |theme|
      delete_non_matching_on_sub_themes!(theme[:sub_themes])
    end
    delete_empty!(result, :sub_themes)
    result
  end

  private

  #
  # Delete if doesn't match on subtheme.
  #
  def delete_non_matching_on_sub_themes!(sub_themes)
    sub_themes.each do |sub_theme|
      delete_non_matching_on_categories!(sub_theme[:categories])
    end
    delete_empty!(sub_themes, :categories)
  end

  #
  # Delete if doesn't match on category.
  #
  def delete_non_matching_on_categories!(categories)
    categories.each do |category|
      delete_non_matching_indicators!(category[:indicators])
    end
    delete_empty!(categories, :indicators)
  end

  #
  # Deletes all indicators that doesn't match on "indicator_ids"
  #
  def delete_non_matching_indicators!(indicators)
    indicators.delete_if { |indicator| !indicator_ids.include? indicator[:id] }
  end

  #
  # Deletes the empty attribute from node
  #
  def delete_empty!(node, attribute)
    node.delete_if { |n| n[attribute].empty? }
  end

  #
  # Validates the response and raise NotFoundError
  # if response.status was equals 404
  #
  def validate_response!
    raise NotFoundError, response.content[:error] if response.status == 404
  end
end
