class NotFoundError < StandardError
  def initialize(msg)
    super(msg)
  end
end
