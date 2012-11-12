class Comment < ActiveRecord::Base
  include TextValidations

  belongs_to :article

  attr_accessible :body

  validates_associated :article

  validates :body, :uniqueness => true
end