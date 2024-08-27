class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.emoji = '🖼️'
end
