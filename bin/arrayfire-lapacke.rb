require_relative '../ext/arrayfire-rb/lib/arrayfire'

require 'benchmark'
require 'json'

class ResultCollect


  def self.generate

    iters = 0
    result = {}

    result[:determinant] = []
    result[:lu_factorization] = []

    shapeArray = [
                  [10,10],    [50,50],    [100,100],
                  [500,500],  [1000,1000],[2000,2000],
                  [3000,3000],[4000,4000],[5000,5000]
                ]

    shapeArray.each do |shape|
      elements1 = Array.new(shape[0]*shape[1]) { rand(1...999) }
      elements2 = Array.new(shape[0]*shape[1]) { rand(1...999) }
      af1 = ArrayFire::Af_Array.new(2, shape, elements1)
      af2 = ArrayFire::Af_Array.new(2, shape, elements2)

      iters.times {ArrayFire::LAPACK.det(af1)}
      result[:determinant] << [ shape[0]*shape[1], Benchmark.measure{ArrayFire::LAPACK.det(af1)}.to_s.tr('()', '').split(" ")[3].to_f ]

      iters.times {ArrayFire::LAPACK.lu(af2)}
      result[:lu_factorization] << [ shape[0]*shape[1], Benchmark.measure{ArrayFire::LAPACK.lu(af2)}.to_s.tr('()', '').split(" ")[3].to_f ]

    end

    puts result.to_json
  end
end

ResultCollect.generate
