require 'test_helper'

class NotesControllerTest < ActionController::TestCase
  setup do
    @note = notes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create note" do
    assert_difference('Note.count') do
      post :create, note: { coach_id: @note.coach_id, note_10: @note.note_10, note_1: @note.note_1, note_2: @note.note_2, note_3: @note.note_3, note_4: @note.note_4, note_5: @note.note_5, note_6: @note.note_6, note_7: @note.note_7, note_8: @note.note_8, note_9: @note.note_9, user_id: @note.user_id }
    end

    assert_redirected_to note_path(assigns(:note))
  end

  test "should show note" do
    get :show, id: @note
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @note
    assert_response :success
  end

  test "should update note" do
    patch :update, id: @note, note: { coach_id: @note.coach_id, note_10: @note.note_10, note_1: @note.note_1, note_2: @note.note_2, note_3: @note.note_3, note_4: @note.note_4, note_5: @note.note_5, note_6: @note.note_6, note_7: @note.note_7, note_8: @note.note_8, note_9: @note.note_9, user_id: @note.user_id }
    assert_redirected_to note_path(assigns(:note))
  end

  test "should destroy note" do
    assert_difference('Note.count', -1) do
      delete :destroy, id: @note
    end

    assert_redirected_to notes_path
  end
end
