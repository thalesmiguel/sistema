require 'rails_helper'

RSpec.describe "cidades/edit", type: :view do
  before(:each) do
    @cidade = assign(:cidade, Cidade.create!())
  end

  it "renders the edit cidade form" do
    render

    assert_select "form[action=?][method=?]", cidade_path(@cidade), "post" do
    end
  end
end
