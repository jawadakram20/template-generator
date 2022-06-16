require 'test_helper'

class TemplateControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get template_create_url
    assert_response :success
  end

end
