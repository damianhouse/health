require 'test_helper'

class CoachesControllerTest < ActionController::TestCase
  setup do
    @coach = coaches(:one)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coach" do
    assert_difference('Coach.count') do
      post :create, coach: { email: @coach.email, first: @coach.first, password: @coach.password, role: @coach.role }
    end

    assert_redirected_to coach_path(assigns(:coach))
  end

  test "should update coach" do
    patch :update, id: @coach, coach: { email: @coach.email, first: @coach.first, password: @coach.password, role: @coach.role }
    assert_redirected_to coach_path(assigns(:coach))
  end

  test "should destroy coach" do
    assert_difference('Coach.count', -1) do
      delete :destroy, id: @coach
    end

    assert_redirected_to coaches_path
  end
end
