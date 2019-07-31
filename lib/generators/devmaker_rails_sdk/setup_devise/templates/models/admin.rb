class Admin < ApplicationRecord
  has_one :user, as: :owner
  accepts_nested_attributes_for :user

  delegate :email, to: :user, allow_nil: true

  scope :search_for, -> (string) do
    s = "%#{string}%"
    joins(:user).where("admins.name ilike ? OR users.email ilike ?", s, s) if string.present?
  end

end
