require_relative '../ext/arrayfire-rb/lib/arrayfire'
require_relative '../ext/nmatrix/lib/nmatrix/lapacke'

require 'benchmark'
require 'json'

class ResultCollect


  def self.generate

    iters = 1
    result = {}

    result[:mat_mult_cpu] = []
    result[:mat_mult_gpu] = []

    shapeArray = [
                  [10,10],[50,50],[100,100],[500,500],
                  [1000,1000],[2000,2000],[3000,3000],
                  [4000,4000],[5000,5000]
                ]

    shapeArray.each do |shape|
      elements1 = Array.new(shape[0]*shape[1]) { rand(1...999999) }
      elements2 = Array.new(shape[0]*shape[1]) { rand(1...999999) }
      cpu_matrix1 = NMatrix.new(shape, elements1, dtype: :float64)
      cpu_matrix2 = NMatrix.new(shape, elements2, dtype: :float64)

      gpu_matrix1 = cpu_matrix1.to_af_array
      gpu_matrix2 = cpu_matrix2.to_af_array

      iters.times do
        ArrayFire::BLAS.matmul(gpu_matrix1, gpu_matrix2, :AF_MAT_NONE, :AF_MAT_NONE)
      end

      result[:mat_mult_cpu] << [ shape[0]*shape[1], Benchmark.measure{cpu_matrix1.dot(cpu_matrix2)}.to_s.tr('()', '').split(" ")[3].to_f ]
      result[:mat_mult_gpu] << [ shape[0]*shape[1], Benchmark.measure{ArrayFire::BLAS.matmul(gpu_matrix1, gpu_matrix2, :AF_MAT_NONE, :AF_MAT_NONE)}.to_s.tr('()', '').split(" ")[3].to_f ]

    end

    puts result.to_json
  end
end

ResultCollect.generate
