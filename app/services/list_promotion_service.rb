# frozen_string_literal: true

# Forms list from given attributes
class ListPromotionService
  def initialize(tasklist:)
    @tasklist = tasklist
  end

  def call
    promote_list!
  end

  private

  attr_accessor :tasklist

  def promote_list!
    List.create!(title: 'Some', description: 'Some', template: true)
  end
end
