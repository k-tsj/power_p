# power_p.rb
#
# Copyright (C) 2014 Kazuki Tsujimoto

require "power_p/version"
require 'power_assert'
require 'power_p/core_ext'

module PowerAssert
  INTERNAL_LIB_DIRS[PowerP] = File.dirname(caller_locations(1, 1).first.path)
end

module PowerP
  def p(*, &blk)
    if blk
      PowerAssert.start(blk, assertion_method: __callee__) do |pa|
        begin
          val = pa.yield
          puts pa.message
          val
        rescue => e
          puts pa.message
          raise e
        end
      end
    else
      super
    end
  end
end

module Kernel
  prepend PowerP
end

class Object
  include Kernel
end
