require File.dirname(__FILE__) + '/../test_helper'
require 'purchase_controller'

# Re-raise errors caught by the controller.
class PurchaseController; def rescue_action(e) raise e end; end

class PurchaseControllerTest < Test::Unit::TestCase
  def setup
    @controller = PurchaseController.new
    @request, @response = ActionController::TestRequest.new, ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
