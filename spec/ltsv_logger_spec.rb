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
      expect(ltsv.include?("severity:INFO")).to be_true
      expect(ltsv.include?("message:Test")).to be_true
    end

    it "ハッシュを LTSV で出力できる" do
      @logger.info(name:"Foo", age:16)

      @output.seek(0)
      ltsv = @output.read.strip.split("\t")
      expect(ltsv.include?("severity:INFO")).to be_true
      expect(ltsv.include?("name:Foo")).to be_true
      expect(ltsv.include?("age:16")).to be_true
    end
  end
end

