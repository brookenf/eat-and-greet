class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :events, foreign_key: 'creator_id', class_name: 'Event', dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :events_as_member, through: :memberships, source: 'event'
  has_one_attached :profile_pic

  validates :name, presence: true
  validates :location, presence: true
  validate :topics_limit
  validates :twitter_link, url: true
  validates :instagram_link, url: true
  validates :facebook_link, url: true

  before_create :set_slug

  def to_param
    slug
  end

  private

  def set_slug
    self.slug = "#{self.name.parameterize}-#{self.id}"
  end

  def valid_url?(url)
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end

  def topics_limit
    return if topics.nil?

    unless topics.count(",") < 5
      errors.add(:topics, ': You must have 5 or less topics')
    end
  end
end
