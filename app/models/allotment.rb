class Allotment < ActiveRecord::Base
  has_paper_trail

  belongs_to :owner, class: Worker

  validates :place, presence: true

  def to_s
    place
  end

  def self.places
    all.map(&:place).join ' || '
  end
end
