defmodule ExTracker.StoriesTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  import ExTracker.Stories

  doctest ExTracker.Stories

  alias ExTracker.Support.Helpers

  @client ExTracker.Client.new(%{access_token: Helpers.pt_user_1.token})
  @project_id Helpers.pt_user_1.project_id

  setup_all do
    HTTPoison.start
  end

  test "list/2" do
    use_cassette "stories#list" do
      stories = list(@client, @project_id)
      assert length(stories) == 63
    end
  end
end