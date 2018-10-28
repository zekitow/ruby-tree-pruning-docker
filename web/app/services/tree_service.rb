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
    response = Request.get(upstream)
    return delete_non_matching_by_indicator_ids!(response.content) if indicator_ids.size > 0
    response.content
  end

  #
  # Deletes all nodes that doesn't match the "indicator_ids"
  #
  def delete_non_matching_by_indicator_ids!(content)
    result = content.each do | theme |
      theme.sub_themes.each do | sub_theme |
        sub_theme.categories.each do | category |
          delete_not_matching_indicators(indicator_ids, category.indicators)
        end
        sub_theme.categories.delete_if {| cat | cat.indicators.empty? }
      end
      theme.sub_themes.delete_if {| sub | sub.categories.empty? }
    end
    result.delete_if { | theme | theme.sub_themes.empty? }
    result
  end

  private
  
  #
  # Deletes all indicators that doesn't match on "indicator_ids"
  #
  def delete_not_matching_indicators(indicator_ids, indicators)

    indicators.each do | indicator |
      indicators.delete_if { |indicator| !indicator_ids.include? indicator.id }
    end
  end

end