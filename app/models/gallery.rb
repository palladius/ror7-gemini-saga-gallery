class Gallery < ApplicationRecord
  validates_presence_of :title
  validates_length_of :title, maximum: 255
  validates_uniqueness_of :title # Ensure titles are unique across all galleries

  # Optional validations based on your requirements:
  # validates_uniqueness_of :title, scope: :user_id # Enforce unique titles per user (if applicable)
  # validates_inclusion_of :public, in: [true, false] # Strictly enforce boolean values for public

  #belongs_to :user # Gallery belongs to a User
  has_many :media # Gallery has many Media items
  has_one :cover_image, class_name: 'Medium', foreign_key: 'cover_image_id'
  #has_one :cover_image, class_name: 'Medium', foreign_key: 'cover_image_id'  # Correct association
  #has_one :medium,  foreign_key: 'cover_image_id'


  def to_s
    "#{Gallery.emoji} Gallery '#{title}'"
  end


  def cover_image_manhouse # since its not working
    Medium.find(cover_image_id) rescue nil
  end




  def self.emoji = '🖼️'
end
