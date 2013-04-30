# coding: utf-8
require_relative "spec_helper"
require "date"

describe Logger::LTSVFormatter do
  describe "#call" do
    before do
      @formatter = ::Logger::LTSVFormatter.new
      @today = Date.today
    end

    context "デフォルト" do
      it "LTSV 形式に整形できる" do
        actual = @formatter.call("Warn", @today, "Foo", "Bar")
        expect(actual).to eq("severity:Warn\tdatetime:#{@today}\tprogname:Foo\tmessage:Bar\n")
      end
    end

    context "ハッシュを指定したとき" do
      it "LTSV 形式に整形できる" do
        actual = @formatter.call("Warn", @today, "Foo", {
          name:"Bar", age:16
        })
        expect(actual).to eq("severity:Warn\tdatetime:#{@today}\tprogname:Foo\tname:Bar\tage:16\n")
      end
    end

    context "pragname が nil のとき" do
      it "pragname が省略されるべき" do
        actual = @formatter.call("Warn", @today, nil, "Bar")
        expect(actual).to eq("severity:Warn\tdatetime:#{@today}\tmessage:Bar\n")
      end
    end
  end
end

