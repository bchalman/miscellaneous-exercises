require "ruby caesar_cipher"

describe String do

  subject(:string) do
    "hello world"
  end


  describe "#caesar_cipher" do
    context "with no arguments" do
      it "shifts each letter by 1" do
        expect(string.caesar_cipher).to eql("ifmmp xpsme")
      end
    end

    context "given 3" do
      it "shifts each letter by 3" do
        expect(string.caesar_cipher(3)).to eql("khoor zruog")
      end
    end

    it "wraps from z to a" do
      expect(string.caesar_cipher(5)).to eql("mjqqt btwqi")
    end

    it "keeps the same case" do
      # string = "Hello World"
      expect("Hello World".caesar_cipher(4)).to eql("Lipps Asvph")
    end

    it "keeps pucuation" do
      # string = "Hello World"
      expect("Hello @World!".caesar_cipher(4)).to eql("Lipps @Asvph!")
    end


  end
end
