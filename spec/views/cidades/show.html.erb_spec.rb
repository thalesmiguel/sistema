require 'rails_helper'

RSpec.describe "cidades/show", type: :view do
  before(:each) do
    @cidade = assign(:cidade, Cidade.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
