require "Enumerable Methods"

describe Enumerable do
  let(:array){ [1,2,3,4]}

  describe "#my_each" do
    context "call block once for each element" do
      it "yields each element"do
        expect{|block| array.my_each(&block)}.to yield_successive_args(1,2,3,4)
      end
      it "returns its self" do
        expect(array.my_each{|e| e+3}).to eql(array)
      end
    end
  end

  describe "#my_select" do
    context "returns an array with selected elements" do
      it "block is alway true" do
        expect(array.my_select{|e| true}).to eql(array)
      end
      it "block is alway false" do
        expect(array.my_select{|e| false}.empty?).to be true
      end
      it "block is > 2" do
        expect(array.my_select{|e| e > 2}).to eql([3,4])
      end
    end
  end

  describe "#my_all?" do
    context "returns true block is true for all element" do
      it "block is alway true" do
        expect(array.my_all?{|e| true}).to be true
      end
      it "block is alway false" do
        expect(array.my_all?{|e| false}).to be false
      end
      it "block is > 2" do
        expect(array.my_all?{|e| e > 2}).to be false
      end
    end

    context "with no block returns true if all elements are truthy" do
      # do i want ell element to be truthy or  == true?
      it "all elements are truthy" do
        expect([0,true,"cat"].my_all?).to be true
      end
      it "one element is not truthy" do
        expect([nil,1,2,3].my_all?).to be false
      end
      it "no elements are truthy" do
        expect([false,nil,false].my_all?).to be false
      end
    end

  end

  describe "#my_count" do
    context "counts the number of block that return true" do
      it "block is alway true" do
        expect(array.my_count{|e| true}).to eql(4)
      end
      it "block is alway false" do
        expect(array.my_count{|e| false}).to eql(0)
      end
      it "block is > 2" do
        expect(array.my_count{|e| e > 2}).to eql(2)
      end
    end
    it "with no block counts the number of elements" do
        expect(array.my_count).to eql(4)
    end

  end

end
