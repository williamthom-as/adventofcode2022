# frozen_string_literal: true

class PipelineHandler
  attr_reader :pipelines

  def initialize
    @pipelines = {}
  end

  # @param [Array] pipeline
  def register_pipeline(idx, pipeline)
    @pipelines[idx] = pipeline
    self
  end

  def do_operation(move, from, to)
    from_stack = @pipelines[from].pop(move)
    # @pipelines[to].concat(from_stack.reverse) # sol 1
    @pipelines[to].concat(from_stack) # sol 2
  end
end

ph = PipelineHandler.new
                    .register_pipeline(1, %w[B S V Z G P W])
                    .register_pipeline(2, %w[J V B C Z F])
                    .register_pipeline(3, %w[V L M H N Z D C])
                    .register_pipeline(4, %w[L D M Z P F J B])
                    .register_pipeline(5, %w[V F C G J B Q H])
                    .register_pipeline(6, %w[G F Q T S L B])
                    .register_pipeline(7, %w[L G C Z V])
                    .register_pipeline(8, %w[N L G])
                    .register_pipeline(9, %w[J F H C])

operations = File.read('day5/source.txt').split("\n")
operations.each do |op|
  directions = op.split(' ').each_slice(2).to_a
  ph.do_operation(directions[0][1].to_i, directions[1][1].to_i, directions[2][1].to_i)
end

puts ph.pipelines.map { |_k, v| v[-1] }.join('')
