class Worker < ActiveRecord::Base
  has_paper_trail
  has_magick_columns name: :string, last_name: :string, identification: :string

  validates :name, :last_name, :identification, presence: true

  def to_s
    [:last_name, :name].join(', ')
  end

  alias_method :label, :to_s

  def as_json(options = nil)
    default_options = {
      only: [:id],
      methods: [:label, :informal]
    }

    super(default_options.merge(options || {}))
  end

  def self.filtered_list(query)
    query.present? ? magick_search(query) : all
  end
end
