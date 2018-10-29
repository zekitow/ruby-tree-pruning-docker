class TreeRequest
  attr_accessor :upstream, :indicator_ids

  def initialize(params)
    @upstream      = params[:name]
    @indicator_ids = params[:indicator_ids] || []
    @indicator_ids.map! {| i | i.to_i }
  end

  def validate_upstream!
    raise NotFoundError.new("Invalid upstream.") if upstream.nil?
  end

  def to_hash
    { name: upstream, indicator_ids: indicator_ids }
  end
end