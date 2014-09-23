# power_p.rb
#
# Copyright (C) 2014 Kazuki Tsujimoto, All rights reserved.

require "power_p/version"
require 'power_assert'

module PowerP
  def p(*, &blk)
    if blk
      PowerAssert.start(blk, assertion_method: __callee__) do |pa|
        val = pa.yield
        puts pa.message_proc.call
        val
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
