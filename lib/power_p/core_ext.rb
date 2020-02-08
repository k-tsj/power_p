require 'power_assert'

verbose = $VERBOSE
begin
  $VERBOSE = nil

  module PowerAssert
    class << self
      prepend Module.new {
        def start(*, **)
          super do |ctx|
            disable_nesting_contexts(ctx) do
              yield ctx
            end
          end
        end

        private

        BLOCK_CONTEXTS_STACK = Hash.new {|h, thread| h[thread] = [] }

        def disable_nesting_contexts(ctx)
          BLOCK_CONTEXTS_STACK.delete_if {|th,| ! th.alive? }
          stack = BLOCK_CONTEXTS_STACK[Thread.current]
          if stack.last
            stack.last.disable
          end
          stack.push(ctx)
          yield
        ensure
          stack.pop
          if stack.last
            stack.last.enable
          end
        end
      }
    end

    class Parser
      def method_id_set
        @method_id_set ||=
          if @assertion_proc
            insns = RubyVM::InstructionSequence.of(@assertion_proc).to_a[13]
            insns.each_with_object({}) do |i, h|
              if i.kind_of?(Array) and i[1].kind_of?(Hash) and i[1][:mid]
                h[i[1][:mid]] = true
              end
            end
          else
            Hash.new(true)
          end
      end

      EQ_TRUE = Class.new do
        def ==(*)
          true
        end
      end.new
      private_constant :EQ_TRUE

      def lineno
        EQ_TRUE
      end
    end

    class Context
      def message
        @message ||= (@return_values.chunk(&:lineno).map.with_index do |(lineno, vals), i|
            if i == 0
              parser = @parser
            else
              line = open(@parser.path).each_line.drop(lineno - 1).first
              parser = Parser.new(line, @parser.path, lineno, @parser.binding)
            end
            build_assertion_message(parser, vals)
          end).join("\n").freeze
      end
    end

    class BlockContext
      def enable
        @trace_return.enable
      end

      def disable
        @trace_return.disable
      end
    end
  end
ensure
  $VERBOSE = verbose
end
