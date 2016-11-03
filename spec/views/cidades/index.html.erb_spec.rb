require 'rails_helper'

RSpec.describe "cidades/index", type: :view do
  before(:each) do
    assign(:cidades, [
      Cidade.create!(),
      Cidade.create!()
    ])
  end

  it "renders a list of cidades" do
    render
  end
end
