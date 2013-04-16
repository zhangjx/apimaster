# encoding: utf-8
#
# Copyright (C) 2011-2012  AdMaster, Inc.

module Apimaster::Mocks
  class User

    def self.auth access_token
      Apimaster::Models::User.new id: 1, email: "hello@admaster.com.cn",
        username: "hello", uuid: "1d936f8e-f7f3-11e1-975a-782bcb4b65ed"
    end

  end
end
