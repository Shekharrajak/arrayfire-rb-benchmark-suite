require_relative '../ext/arrayfire-rb/lib/arrayfire'

require 'benchmark'
require 'json'

class ResultCollect


  def self.generate

    iters = 1
    result = {}

    result[:addition] = []
    result[:subtraction] = []
    result[:mat_mult] = []

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

      iters.times {
        x = af1 + af2
        x.eval
      }
      result[:addition] << [ shape[0]*shape[1], Benchmark.measure{
        x = af1 + af2
        x.eval
      }.to_s.tr('()', '').split(" ")[3].to_f ]

      iters.times {
        y = af1 - af2
        y.eval
      }
      result[:subtraction] << [ shape[0]*shape[1], Benchmark.measure{
        y = af1 - af2
        y.eval
      }.to_s.tr('()', '').split(" ")[3].to_f ]

      iters.times {
        z = ArrayFire::BLAS.matmul(af1,af2, :AF_MAT_NONE, :AF_MAT_NONE)
        z.eval
      }
      result[:mat_mult] << [ shape[0]*shape[1], Benchmark.measure{
        z = ArrayFire::BLAS.matmul(af1,af2, :AF_MAT_NONE, :AF_MAT_NONE)
        z.eval
      }.to_s.tr('()', '').split(" ")[3].to_f ]

      puts result.to_json

    end

    puts result.to_json
  end
end

ResultCollect.generate
