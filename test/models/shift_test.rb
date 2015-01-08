require 'test_helper'

class ShiftTest < ActiveSupport::TestCase
  def setup
    @shift = Fabricate(:shift)
  end

  test 'create' do
    assert_difference ['Shift.count', 'PaperTrail::Version.count'] do
      Shift.create! Fabricate.attributes_for(:shift, worker_id: @shift.worker_id)
    end
  end

  test 'update' do
    assert_difference 'PaperTrail::Version.count' do
      assert_no_difference 'Shift.count' do
        @shift.update!(worker_id: 99, auto_worker_name: 'rock')
      end
    end

    assert_equal 99, @shift.reload.worker_id
  end

  test 'destroy' do
    assert_difference 'PaperTrail::Version.count' do
      assert_difference('Shift.count', -1) { @shift.destroy }
    end
  end

  test 'validates blank attributes' do
    @shift.worker_id = ''
    @shift.auto_worker_name = ''

    assert @shift.invalid?
    assert_equal 2, @shift.errors.size
    [:worker_id, :auto_worker_name].each do |attr|
      assert_equal_messages @shift, attr, :blank
    end
  end
end
