require 'spec_helper'

describe "the articles interface" do
  before(:all) do
    @articles = []
    3.times{ @articles << Fabricate(:article) }
  end

  describe "on the index page" do
    before(:each) do
      visit articles_path
    end

    it "lists the article titles" do
      @articles.each do |article|
        page.should have_content(article.title)
      end
    end

    it "has links for the articles" do
      @articles.each do |article|
        page.should have_link(article.title, :href => article_path(article))
      end
    end
  end
end