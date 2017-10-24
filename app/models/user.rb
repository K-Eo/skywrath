class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :confirmable, :lockable, :validatable

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
    self.update_with_password(params)
  end
end
