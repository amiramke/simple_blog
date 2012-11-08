module TextValidations
  def self.included(receiver)
    receiver.validates :body,
      :presence => true,
      :format => { :without => /kitten/ }
  end
end