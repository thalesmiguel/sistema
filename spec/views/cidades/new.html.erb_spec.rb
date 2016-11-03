require 'rails_helper'

RSpec.describe "cidades/new", type: :view do
  before(:each) do
    assign(:cidade, Cidade.new())
  end

  it "renders new cidade form" do
    render

    assert_select "form[action=?][method=?]", cidades_path, "post" do
    end
  end
end
