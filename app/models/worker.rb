class Worker < ActiveRecord::Base
  has_paper_trail
  has_magick_columns name: :string, last_name: :string, identification: :string

  attr_accessor :auto_parent_name

  validates :name, :last_name, :identification, presence: true
  validates :identification, uniqueness: true

  has_many :shifts
  has_many :allotments, foreign_key: :owner_id
  belongs_to :parent, class_name: :Worker

  accepts_nested_attributes_for :allotments, allow_destroy: true,
    reject_if: -> (attr) { attr['place'].blank? && attr['id'].blank? }

  def to_s
    [last_name, name].join(', ')
  end

  alias_method :label, :to_s

  def as_json(options = nil)
    default_options = {
      only: [:id],
      methods: [:label, :informal, :places]
    }

    super(default_options.merge(options || {}))
  end

  def informal
    identification
  end

  def places
    all_allotments.map(&:place).join(' || ')
  end

  def self.filtered_list(query)
    query.present? ? magick_search(query) : all
  end

  def all_allotments
    _allotments = allotments.to_a

    parents.map { |p| _allotments << p.allotments.to_a }

    _allotments.flatten.uniq
  end

  def parents
    _parents = []

    if parent
      _parents << parent
      _parents << parent.parents
    end

    _parents.flatten
  end
end
