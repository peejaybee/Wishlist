require File.dirname(__FILE__) + '/../test_helper'
require 'wish_controller'

# Re-raise errors caught by the controller.
class WishController; def rescue_action(e) raise e end; end

class WishControllerTest < Test::Unit::TestCase
  def setup
    @controller = WishController.new
    @request, @response = ActionController::TestRequest.new, ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
