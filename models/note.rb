class Note
  include MongoMapper::Document

  key :title, String
  key :body, String
  key :sources, Array
  key :permalink, String

  timestamps!
  userstamps!

  belongs_to :project

  validates_uniqueness_of :permalink

  after_create :create_permalink!

  private

  def create_permalink!
    self.permalink = Base32::Crockford.encode(self.class.count + 1)
  end
end
