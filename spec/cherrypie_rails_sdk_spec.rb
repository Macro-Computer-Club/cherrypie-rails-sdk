# frozen_string_literal: true
require 'cherrypie_rails_sdk'

RSpec.describe CherrypieRailsSdk do
  it "has a version number" do
    expect(CherrypieRailsSdk::VERSION).not_to be nil
  end

  it "does something useful" do
    dont = CherrypieRailsSdk::Food.new()
    expect(dont.portray("food")).to eq("Delicious!")
  end
end
