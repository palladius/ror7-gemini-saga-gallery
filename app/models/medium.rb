class Medium < ApplicationRecord
  #validations
  validates_uniqueness_of :path, scope: :gallery_id # Ensure unique paths within a gallery
  validates_presence_of :title, :path, :media_type, :gallery_id # Ensure essential fields are present
  validates_inclusion_of :media_type, in: %w(picture video) # Restrict media_type to allowed values
  # Optional validations based on your requirements:
  # validates_length_of :title, maximum: 255
  # validates_numericality_of :gemini_relevance, :gemini_quality, greater_than_or_equal_to: 0, less_than_or_equal_to: 1 # If you want to constrain the Gemini scores


  # Associations
  belongs_to :gallery
  # If you have a User model and want to track ownership
  # belongs_to :user
  #has_one_attached :medium_file # activestorage
  has_one_attached :medium_file do |attachable|
    attachable.variant :thumbnail, resize_to_limit: [200, 200]
    attachable.variant :middle, resize_to_limit: [800, 800]
  end


  # def caption
  #   @caption || 'Caption coming'
  # end

  # model
  def to_s = "#{Medium.emoji} Medium '#{title}'"
  def thumbnail = self.medium_file.variant :thumbnail
  def middle_thumbnail = self.medium_file.variant :thumbnail


  # class methods
  def self.emoji = '🖼️📹'
  def self.best_image = Medium.order(:gemini_quality).last # reverse.first


end
