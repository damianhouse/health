require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @current_user = users(:one)
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
    patch :update, id: @user, user: { coach_1: @user.coach_1, coach_2: @user.coach_2, coach_3: @user.coach_3, coach_4: @user.coach_4, coach_id: @user.coach_id, email: @user.email, first: @user.first, password_digest: @user.password_digest, role: @user.role }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
