class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :confirmable, :lockable, :validatable

  validates_presence_of :name, on: :update_profile
  validates_length_of :name, maximum: 120, on: :update_profile

  validates_length_of :phone, maximum: 24, on: :update_profile
  validates_format_of :phone, with: /\A[0-9]*\z/, on: :update_profile

  has_many :alerts, foreign_key: "author_id"

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def has_name?
    self.name.present?
  end

  def update_profile(params)
    if params[:name].present?
      params[:name] = params[:name].squish.titleize
    end

    self.assign_attributes(params)
    self.save(context: :update_profile)
  end

  def update_password(params)
    self.update_with_password(params)
  end
end
