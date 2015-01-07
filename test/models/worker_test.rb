require 'test_helper'

class WorkerTest < ActiveSupport::TestCase
  def setup
    @worker = Fabricate(:worker)
  end

  test 'create' do
    assert_difference ['Worker.count', 'PaperTrail::Version.count'] do
      Worker.create! Fabricate.attributes_for(:worker)
    end
  end

  test 'update' do
    assert_difference 'PaperTrail::Version.count' do
      assert_no_difference 'Worker.count' do
        @worker.update!(name: 'Updated')
      end
    end

    assert_equal 'Updated', @worker.reload.name
  end

  test 'destroy' do
    assert_difference 'PaperTrail::Version.count' do
      assert_difference('Worker.count', -1) { @worker.destroy }
    end
  end

  test 'validates blank attributes' do
    @worker.name = ''
    @worker.last_name = ''
    @worker.identification = ''

    assert @worker.invalid?
    assert_equal 3, @worker.errors.size
    [:name, :last_name, :identification].each do |attr|
      assert_equal_messages @worker, attr, :blank
    end
  end
end
