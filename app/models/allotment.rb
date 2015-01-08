class Allotment < ActiveRecord::Base
  has_paper_trail

  belongs_to :owner, class: Worker

  validates :place, presence: true
end
