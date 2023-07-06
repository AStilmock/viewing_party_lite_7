require "rails_helper"

RSpec.describe "Discover" do
  before(:each) do
    @user1 = FactoryBot.create(:user)
    visit user_discover_index_path(@user1.id)
  end

  describe "Page Content" do
    it "has button to discover movies" do
      within "#top_5" do
        expect(page).to have_button("Top 5 Movies")
        click_button "Top 5 Movies"
        expect(current_path).to eq(movies_results_path)
      end
    end

    it "has text field for searching movie title search" do
      within "#title_search" do
        expect(page).to have_field("Title")
        fill_in "Title", with: "James Bond"
        expect(page).to have_button("Search")
        click_button "Search"
        expect(current_path).to eq(movies_results_path)
      end
    end

  end
end
