require "test_helper"

class BragDocumentsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get brag_documents_show_url
    assert_response :success
  end
end
