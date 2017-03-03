class User < ApplicationRecord
  audited
  trimmed_fields :nome, :username, :email
  rolify

  has_many :testemunha_1, class_name: "Leilao", foreign_key: :testemunha_1_id
  has_many :testemunha_2, class_name: "Leilao", foreign_key: :testemunha_2_id
  has_many :leilao_observacoes

  has_many :alertas
  has_many :audits


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, :presence => true, :uniqueness => { :case_sensitive => false }
  validates :nome, :presence => true, :uniqueness => { :case_sensitive => false }
  validate :validate_username
  validate :validate_email

  attr_accessor :login


  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  def validate_username
    if User.where(email: username).where.not(id: id).exists?
      errors.add(:username, :invalid)
    end
  end

  def validate_email
    if !email.empty?
      if User.where(email: email).where.not(id: id).exists?
        errors.add(:email, :invalid)
      end
    end
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def testemunhas
    testemunha_1.or(testemunha_2)
  end

end
