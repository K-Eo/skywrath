class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :confirmable, :lockable

  validates_presence_of :email, on: :create
  validates_uniqueness_of :email, on: :create
  validates_format_of :email, with: /\A[^@\s]+@[^@\s]+\z/, on: :create

  validates_presence_of :password, on: [:create, :update_password]
  validates_confirmation_of :password, on: [:create, :update_password]
  validates_length_of :password, within: 6..128, on: [:create, :update_password]

  validates_presence_of :first_name, on: :update_profile
  validates_length_of :first_name, maximum: 50, on: :update_profile

  validates_presence_of :last_name, on: :update_profile
  validates_length_of :last_name, maximum: 50, on: :update_profile

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def has_name?
    self.first_name.present? && self.last_name.present?
  end

  def full_name
    [self.first_name, self.last_name].compact.join(" ")
  end

  def update_profile(params)
    self.assign_attributes(params)
    self.save(context: :update_profile)
  end

  def update_password(params)
    current_password = params.delete(:current_password)

    result = if valid_password?(current_password)
      self.assign_attributes(params)
      self.save(context: :update_password)
    else
      self.errors.add(:current_password, :invalid)
      false
    end

    result
  end
end
