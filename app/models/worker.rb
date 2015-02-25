class Worker < ActiveRecord::Base
  has_paper_trail
  has_magick_columns name: :string, last_name: :string, identification: :string

  attr_accessor :auto_parent_name

  validates :name, :last_name, :identification, presence: true
  validates :identification, uniqueness: true
  validate :validate_parent_places

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
    allotments.places
  end

  def self.filtered_list(query)
    query.present? ? magick_search(query) : all
  end

  def parent_places
    parent.places if parent
  end

  def parent_places_to_s
    if (pp = parent_places)
      "Lugares permitidos: \n #{pp}"
    end
  end

  private

    def validate_parent_places
      if parent
        _parent_places = parent.allotments.map(&:place)

        allotments.each do |p|
          unless _parent_places.include?(p.place.strip)
            self.errors.add(:base, "#{p} no está incluido en los lugares del propietario")
          end
        end

        self.errors.add(:base, "Debe cargar uno de los lugares del propietario") if allotments.empty?
      end
    end
end
