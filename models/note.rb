class Note
  include MongoMapper::Document

  plugin MongoMapper::Plugins::Paranoid

  key :title, String
  key :body, String
  key :source_ids, Array # Array of Source IDs as strings
  key :permalink, String

  timestamps!
  userstamps!

  belongs_to :project

  many :sources

  many :comments, :as => :commentable
  many :tags, :as => :taggable

  before_create :permalink!

  after_create :create_activity
  after_update :update_activity
  after_destroy :destroy_activity

  scope :within, -> (id){ where(:project_id => id, :deleted_at => nil).order('updated_at dsc') }

  def create_activity
    Activity.create(
      :actor => self.creator,
      :recipient => self,
      :recipient_parent => self.project,
      :action => 'create'
    )
  end

  def update_activity
    Activity.create(
      :actor => self.updater,
      :recipient => self,
      :recipient_parent => self.project,
      :action => 'update'
    )
  end

  def destroy_activity
    Activity.create(
      :actor => self.creator,
      :recipient => self,
      :recipient_parent => self.project,
      :action => 'destroy'
    )
  end

  def url
    "#{self.project.url}/notes/#{self.permalink}"
  end

  def sources
    arr = []
    source_ids.each do |id|
      arr << Source.find(id)
    end

    arr
  end

  def tags=(str)
    self.tags.each { |t| t.destroy }
    self.tags.clear

    arr = str.split(",")
    arr.each do |t|
      self.tags << Tag.new(:text => t)
    end

    self.tags
  end

  def tags_str
    arr = []
    tags.each { |t| arr << t.text }

    arr.compact.join(',').squish
  end

  def creatable_by?(u)
    self.project.updatable_by?(u)
  end

  def updatable_by?(u)
    creatable_by?(u)
  end

  def destroyable_by?(u)
    creatable_by?(u)
  end

  private

  def permalink!
    self.permalink = Base32::Crockford.encode(Von.increment('notes'))
  end
end
