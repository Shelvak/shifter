require 'test_helper'

class AllotmentTest < ActiveSupport::TestCase
  def setup
    @allotment = Fabricate(:allotment)
  end

  test 'create' do
    assert_difference ['Allotment.count', 'PaperTrail::Version.count'] do
      Allotment.create! Fabricate.attributes_for(:allotment, owner_id: @allotment.owner_id)
    end
  end

  test 'update' do
    assert_difference 'PaperTrail::Version.count' do
      assert_no_difference 'Allotment.count' do
        @allotment.update!(place: 'Updated')
      end
    end

    assert_equal 'Updated', @allotment.reload.place
  end

  test 'destroy' do
    assert_difference 'PaperTrail::Version.count' do
      assert_difference('Allotment.count', -1) { @allotment.destroy }
    end
  end

  test 'validates blank attributes' do
    @allotment.place = ''

    assert @allotment.invalid?
    assert_equal 1, @allotment.errors.size
    assert_equal_messages @allotment, :place, :blank
  end
end
