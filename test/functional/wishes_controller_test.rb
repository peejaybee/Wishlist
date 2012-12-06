require File.dirname(__FILE__) + '/../test_helper'
require 'wishes_controller'

# Re-raise errors caught by the controller.
class WishesController; def rescue_action(e) raise e end; end

class WishesControllerTest < Test::Unit::TestCase
  fixtures :wishes

  def setup
    @controller = WishesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    process :index
    assert_rendered_file 'list'
  end

  def test_list
    process :list
    assert_rendered_file 'list'
    assert_template_has 'wishes'
  end

  def test_show
    process :show, 'id' => 1
    assert_rendered_file 'show'
    assert_template_has 'wish'
    assert_valid_record 'wish'
  end

  def test_new
    process :new
    assert_rendered_file 'new'
    assert_template_has 'wish'
  end

  def test_create
    num_wishes = Wish.find_all.size

    process :create, 'wish' => { }
    assert_redirected_to :action => 'list'

    assert_equal num_wishes + 1, Wish.find_all.size
  end

  def test_edit
    process :edit, 'id' => 1
    assert_rendered_file 'edit'
    assert_template_has 'wish'
    assert_valid_record 'wish'
  end

  def test_update
    process :update, 'wish' => { 'id' => 1 }
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil Wish.find(1)

    process :destroy, 'id' => 1
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      wish = Wish.find(1)
    }
  end
end
