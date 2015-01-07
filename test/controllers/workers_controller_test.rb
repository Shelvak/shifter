require 'test_helper'

class WorkersControllerTest < ActionController::TestCase

  setup do
    @worker = Fabricate(:worker)
    @user = Fabricate(:user)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:workers)
    assert_select '#unexpected_error', false
    assert_template "workers/index"
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:worker)
    assert_select '#unexpected_error', false
    assert_template "workers/new"
  end

  test "should create worker" do
    assert_difference('Worker.count') do
      post :create, worker: Fabricate.attributes_for(:worker)
    end

    assert_redirected_to worker_url(assigns(:worker))
  end

  test "should show worker" do
    get :show, id: @worker
    assert_response :success
    assert_not_nil assigns(:worker)
    assert_select '#unexpected_error', false
    assert_template "workers/show"
  end

  test "should get edit" do
    get :edit, id: @worker
    assert_response :success
    assert_not_nil assigns(:worker)
    assert_select '#unexpected_error', false
    assert_template "workers/edit"
  end

  test "should update worker" do
    put :update, id: @worker,
      worker: Fabricate.attributes_for(:worker, name: 'value')
    assert_redirected_to worker_url(assigns(:worker))
  end

  test "should destroy worker" do
    assert_difference('Worker.count', -1) do
      delete :destroy, id: @worker
    end

    assert_redirected_to workers_path
  end
end
