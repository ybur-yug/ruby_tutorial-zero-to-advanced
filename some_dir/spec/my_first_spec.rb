require './lib/bob'

describe Bob do
  let(:bob) { Bob.new }
  it "can tell you hes wearing pants" do
    expect(bob.pants?).to eq true
  end
end
