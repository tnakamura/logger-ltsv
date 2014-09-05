# coding: utf-8
require_relative "spec_helper"
require "date"
require "stringio"

describe LTSVLogger do
  before do
    @output = StringIO.new
    @logger = LTSVLogger.new(@output)
  end

  describe "#formatter" do
    it "Logger::LTSVFormatter を返す" do
      expect(@logger.formatter).to be_an_instance_of(Logger::LTSVFormatter)
    end
  end

  describe "#info" do
    it "LTSV 形式でログを出力できる" do
      @logger.info("Test")

      @output.seek(0)
      ltsv = @output.read.strip.split("\t")
      expect(ltsv).to include("severity:INFO")
      expect(ltsv).to include("message:Test")
    end

    it "ハッシュを LTSV で出力できる" do
      @logger.info(name:"Foo", age:16)

      @output.seek(0)
      ltsv = @output.read.strip.split("\t")
      expect(ltsv).to include("severity:INFO")
      expect(ltsv).to include("name:Foo")
      expect(ltsv).to include("age:16")
    end
  end
end

