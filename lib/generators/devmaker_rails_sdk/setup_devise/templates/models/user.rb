class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  belongs_to :owner, polymorphic: true, inverse_of: :user

  scope :admins, -> { where(owner_type: "Admin") }

  def admin?
    owner&.is_a?(Admin)
  end

end
