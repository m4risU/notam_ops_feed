class NotamForm < Reform::Form
  property :data
  validates :data, presence: true
end
