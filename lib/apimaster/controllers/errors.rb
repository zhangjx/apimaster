# encoding: utf-8
#
# Copyright (C) 2011-2012  AdMaster, Inc.

module Apimaster::Controllers

  class Errors < Sinatra::Base

    superclass.error Apimaster::NormalError do
      e = env['sinatra.error']
      error = [:resource, :code, :field].inject({}) do |err, val|
        if e.respond_to?(val) and v = e.send(val)
          err[val] = v
        end
        err
      end

      messages = {:message => e.message}
      messages[:errors] = [error] unless error.empty?
      json messages
    end

    superclass.error do
      if respond_to?(:development?)
        raise env['sinatra.error'] if development?
      elsif settings.respond_to?(:development?)
        raise env['sinatra.error'] if settings.development?
      end
      json :message => "Internal Server Error"
    end

    superclass.not_found do
      json message: "Not Found"
    end

  end
end

