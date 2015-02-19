module ShiftsHelper
  def translate_shift_kind(kind)
    t('view.shifts.kind_' + kind)
  end
end
