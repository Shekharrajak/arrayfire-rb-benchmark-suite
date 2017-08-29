require_relative '../ext/nmatrix/lib/nmatrix/lapacke'

require 'benchmark'
require 'json'

class ResultCollect


  def self.generate

    iters = 0
    result = {}

    result[:mat_mult] = []
    result[:determinant] = []
    result[:lu_factorization] = []

    shapeArray = [
                  [10,10],[50,50],[100,100],[500,500],
                  [1000,1000],[2000,2000],[3000,3000],
                  [4000,4000],[5000,5000]
                ]

    shapeArray.each do |shape|
      elements1 = Array.new(shape[0]*shape[1]) { rand(1...999999) }
      elements2 = Array.new(shape[0]*shape[1]) { rand(1...999999) }
      nmatrix1 = NMatrix.new(shape, elements1, dtype: :float64)
      nmatrix2 = NMatrix.new(shape, elements2, dtype: :float64)

      iters.times {nmatrix1.dot(nmatrix2)}
      result[:mat_mult] << [ shape[0]*shape[1], Benchmark.measure{nmatrix1.dot(nmatrix2)}.to_s.tr('()', '').split(" ")[3].to_f ]

      iters.times {nmatrix1.det}
      result[:determinant] << [ shape[0]*shape[1], Benchmark.measure{nmatrix1.det}.to_s.tr('()', '').split(" ")[3].to_f ]

      iters.times {nmatrix2.factorize_qr}
      result[:lu_factorization] << [ shape[0]*shape[1], Benchmark.measure{nmatrix2.factorize_lu}.to_s.tr('()', '').split(" ")[3].to_f ]
    end

    puts result.to_json
  end
end

ResultCollect.generate
