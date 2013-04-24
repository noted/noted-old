require 'bcrypt'
require 'digest/md5'

class User
  include MongoMapper::Document
  include BCrypt

  plugin MongoMapper::Plugins::Paranoid

  key :name, String
  key :username, String
  key :email, String
  key :hash, String

  key :location, String
  key :website, String
  key :twitter, String

  timestamps!

  state_machine :role, :initial => :user do
    state :user
    state :staff

    event :hire do
      transition all => :staff
    end

    event :fire do
      transition all => :user
    end
  end

  state_machine :tier, :initial => :free do
    state :free
    state :upgraded

    event :upgrade do
      transition all => :upgraded
    end

    event :downgrade do
      transition all => :free
    end
  end

  belongs_to :instituton

  many :projects
  many :institutions

  validates_presence_of :name, :username, :email
  validates_uniqueness_of :username, :email
  validates_length_of :username, :within => 3..35
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_format_of :username, :with => /\A[a-zA-Z][a-zA-Z0-9_\- \.]+\Z/i
  validate :username_valid?

  before_destroy :clean!

  def self.authenticate(e, p)
    u = first(:email => e) if e.present?
    u && u.password == p ? u : nil
  end

  def gravatar
    str = Digest::MD5.hexdigest(self.email.strip.downcase)

    "http://www.gravatar.com/avatar/#{str}?s=200"
  end

  def password
    @password ||= Password.new(hash)
  end

  def password=(str)
    self.hash = Password.create(str)
  end

  def updatable_by?(u)
    u == self || u.staff?
  end

  def destroyable_by?(u)
    updatable_by?(u)
  end

  private

  def clean!
    self.projects.clear
    self.projects.empty?
  end

  def username_valid?
    restricted = Set.new([
      "comments",
      "noted",
      "notes",
      "projects",
      "sessions",
      "sources",
      "users"
    ])

    if restricted.include?(self.username)
      errors.add(:username, "is invalid")
    end
  end
end
