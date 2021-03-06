require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    session[:user_id] = @user.id
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { coach_1: @user.coach_1, coach_2: @user.coach_2, coach_3: @user.coach_3, coach_4: @user.coach_4, coach_id: @user.coach_id, email: @user.email, first: @user.first, password: @user.password, role: @user.role }
    assert_response :success
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
