module ShiftsHelper
  def radio_buttons_for_kind_shift(form)
    collection = [
      [translate_shift_kind('in'), false],
      [translate_shift_kind('out'), true]
    ]

    form.input :kind, as: :radio_buttons, collection: collection
  end

  def translate_shift_kind(kind)
    t('view.shifts.kind_' + kind)
  end
end
