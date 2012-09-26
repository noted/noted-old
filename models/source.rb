class Source
  include MongoMapper::Document
  
  timestamps!
  userstamps!

  belongs_to :project

  many :comments, :as => :commentable

  many :contributors
  one :annotation

  def creatable_by?(u)
    result = false

    self.project.collaborators.each do |c|
      if c == u
        result = true
      end
    end

    result
  end

  def updateable_by?(u)
    result = false

    self.project.collaborators.each do |c|
      if c == u
        result = true
      end
    end

    result
  end

  def destroyable_by?(u)
    self.project.creator == u
  end
end

class Contributor
  include MongoMapper::EmbeddedDocument

  key :first, String
  key :middle, String
  key :last, String
  key :suffix, String

  embedded_in :source
end

class Author < Contributor
end

class Editor < Contributor
end

class Annotation
  include MongoMapper::EmbeddedDocument

  key :text, String
end

# Completely incomplete.
