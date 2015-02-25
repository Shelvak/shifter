class Shift < ActiveRecord::Base
  has_paper_trail

  attr_accessor :auto_worker_name

  validate :validate_worker_presence

  belongs_to :worker

  def to_s
    [
      I18n.t('view.shifts.kind_' + kind_to_s),
      I18n.l(created_at, format: :minimal)
    ].join(' => ')
  end

  def kind_to_s
    kind ? 'out' : 'in'
  end

  private

    def validate_worker_presence
      self.errors.add(:auto_worker_name, :blank) if worker_id.blank?
    end
end
