# frozen_string_literal: true

class NotFoundError < StandardError
  def initialize(msg)
    super(msg)
  end
end
