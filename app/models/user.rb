class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :itemtests, dependent: :destroy
  #accepts_nested_attributes_for :itemtests
  before_commit :emailtypes
  validate :CheckValidMX
  def emailtypes
    require 'EmailType'
    user = User.last
    result = EmailType.emailchk(email)
    if result == 'Free email'
    user.update(emailtype: "Free Email Account")
    elsif result == 'Business email'
    user.update(emailtype: "Business Email Account")
    else
    user.update(emailtype: "Unknown Email Account")
    end
  end
  #CheckValidMX is a class in the checkvalidmx gem, to verify if MX records exist for supplied email.
  #code and gem is in ./CheckValidMX in this project folder.
  #gem 'checkvalidmx', :path => './CheckValidMX/'

  def CheckValidMX
    return unless email.present?
     mxdomain = CheckValidMX.mxers(email)
     if mxdomain == "InvalidEmailDomain"         
       errors.add(:email, 'Invalid email domain specified')
      end
      end

  end
