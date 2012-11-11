class Article < ActiveRecord::Base
  include TextValidations

  has_many :comments, dependent: :destroy

  attr_accessible :body, :title

  validates :title, :presence => true
#  validates :custom_validation_test
end
