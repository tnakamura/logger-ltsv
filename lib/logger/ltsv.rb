# coding: utf-8
require "logger"
require "logger/ltsv/version"

class Logger
  class LTSVFormatter < ::Logger::Formatter
    def call(severity, datetime, progname, message)
      raw = [
        "severity:#{severity}",
        "datetime:#{datetime}",
      ]

      if progname
        raw << "progname:#{progname}"
      end

      case message
      when Hash
        message.each do |key, value|
          raw << "#{key}:#{value}"
        end
      else
        raw << "message:#{message}"
      end

      ltsv = raw.join("\t") + "\n"
      ltsv
    end
  end
end

class LTSVLogger < ::Logger
  def initialize(*args)
    super
    @formatter = ::Logger::LTSVFormatter.new
  end
end

