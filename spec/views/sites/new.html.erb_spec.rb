require 'spec_helper'

describe "sites/new" do
  before(:each) do
    assign(:site, stub_model(Site,
      :name => "MyString",
      :subdomain => "MyString",
      :user => nil,
      :company => nil
    ).as_new_record)
  end

  it "renders new site form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sites_path, :method => "post" do
      assert_select "input#site_name", :name => "site[name]"
      assert_select "input#site_subdomain", :name => "site[subdomain]"
      assert_select "input#site_user", :name => "site[user]"
      assert_select "input#site_company", :name => "site[company]"
    end
  end
end
