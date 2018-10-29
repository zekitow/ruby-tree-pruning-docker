# frozen_string_literal: true

class BadRequestError < StandardError

  def initialize(msg)
    super(msg)
  end
end
