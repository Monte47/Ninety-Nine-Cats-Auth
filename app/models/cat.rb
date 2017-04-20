require 'action_view'

class Cat < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  # before_update do
  #   self.owner_id == current_user.id
  # end

  CAT_COLORS = %w(black white orange brown)

  has_many(
    :rental_requests,
    class_name: "CatRentalRequest",
    dependent: :destroy
  )

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"

  validates(
    :birth_date,
    :color,
    :name,
    :sex,
    :user_id,
    presence: true
  )

  validates :color, inclusion: CAT_COLORS
  validates :sex, inclusion: %w(M F)

  def age
    time_ago_in_words(birth_date)
  end

end
