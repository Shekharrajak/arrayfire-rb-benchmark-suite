require_relative '../ext/nmatrix/lib/nmatrix/nmatrix.rb'
require 'java'

require 'benchmark'
require 'json'

class ResultCollect
  def self.generate

    iters = 2
    result = {}

    result[:addition] = []
    result[:subtraction] = []
    result[:mat_mult] = []
    result[:determinant] = []
    result[:lu_factorization] = []

    shapeArray = [
                  [10,10],    [50,50],    [100,100],
                  [500,500],  [1000,1000],[2000,2000],
                  [3000,3000],[4000,4000],[5000,5000]
                ]

    shapeArray.each do |shape|
      size = shape[0] * shape[1]
      elements1 = Java::double[size].new
      (0...size).each do |i|
        elements1[i] = rand(1...999)
      end
      elements2 = Java::double[size].new
      (0...size).each do |i|
        elements2[i] = rand(1...999)
      end
      nmatrix1 = NMatrix.new(shape, elements1.to_a, dtype: :float64)
      nmatrix2 = NMatrix.new(shape, elements2.to_a, dtype: :float64)

      iters.times {nmatrix1 + nmatrix2}
      result[:addition] << [ shape[0]*shape[1], Benchmark.measure{nmatrix1 + nmatrix2}.to_s.tr('()', '').split(" ")[3].to_f ]

      iters.times {nmatrix1 - nmatrix2}
      result[:subtraction] << [ shape[0]*shape[1], Benchmark.measure{nmatrix1 - nmatrix2}.to_s.tr('()', '').split(" ")[3].to_f ]

      iters.times {nmatrix1.dot(nmatrix2)}
      result[:mat_mult] << [ shape[0]*shape[1], Benchmark.measure{nmatrix1.dot(nmatrix2)}.to_s.tr('()', '').split(" ")[3].to_f ]

      iters.times {puts nmatrix1.det}
      result[:determinant] << [ shape[0]*shape[1], Benchmark.measure{nmatrix1.det_exact}.to_s.tr('()', '').split(" ")[3].to_f ]

      iters.times {nmatrix2.factorize_qr}
      result[:lu_factorization] << [ shape[0]*shape[1], Benchmark.measure{nmatrix1.factorize_qr}.to_s.tr('()', '').split(" ")[3].to_f ]
    end

    puts result.to_json
  end
end

ResultCollect.generate
