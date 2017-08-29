var app = angular.module('resultApp',[]);
var nmatrix_ruby, nmatrix_lapacke, nmatrix_jruby, arrayfire, arrayfire_lapacke, arrayfire_interface;
app.controller('MainCtrl', function($scope, $http) {

  NmatrixUrl = "nmatrix-ruby.json"
  NMatrixJRubyUrl = "nmatrix-jruby.json"
  NMatrixLapackeRubyUrl = "nmatrix-lapacke.json"
  ArrayFireUrl = "arrayfire.json"
  ArrayFireLapackeUrl = "arrayfire-lapacke.json"
  ArrayFireInterfaceUrl = "interface.json"

  $scope.checked= false;



  $http.get(NmatrixUrl).success(function(data) {
    nmatrix_ruby = data;
    console.log(data['subtraction']);
    $http.get(NMatrixLapackeRubyUrl).success(function(data) {
      nmatrix_lapacke = data;
      $http.get(NMatrixJRubyUrl).success(function(data) {
        nmatrix_jruby = data;
        $http.get(ArrayFireUrl).success(function(data) {
          arrayfire = data;
          $http.get(ArrayFireLapackeUrl).success(function(data) {
            arrayfire_lapacke = data;
          $http.get(ArrayFireInterfaceUrl).success(function(data) {
            arrayfire_interface = data;

            console.log($scope.arith);

            $scope.arith = ["addition", "subtraction"];

            for (var i=0, l=  $scope.arith.length; i<l; i++){
              // console.log(key)
              key = $scope.arith[i];
              console.log(nmatrix_ruby);
              $(function () {
                $('#chart'+key).highcharts({
                    type: 'line',
                    title: {
                      text: 'Matrix '+key,
                      x: -20 //center
                    },
                    subtitle: {x: -20},
                    xAxis: {
                      title: {
                        text: 'Number of elements in one Matrix'
                      },
                    },
                    yAxis: {
                      title: {
                          text: 'Time (s)'
                      },
                      type: 'logarithmic',
                      plotLines: [{
                          value: 0,
                          width: 1,
                          color: '#808080'
                      }]
                    },
                    tooltip: {
                      valueSuffix: 's'
                    },
                    legend: {
                      layout: 'vertical',
                      align: 'right',
                      verticalAlign: 'middle',
                      borderWidth: 0
                    },
                    series: [{
                      name: "NMatrix-Ruby",
                      data: nmatrix_ruby[key]
                    },{
                      name: "NMatrix-JRuby",
                      data: nmatrix_jruby[key]
                    },{
                      name: "ArrayFire",
                      data: arrayfire[key]
                    },
                  ]
                });
              });
            }


            $(function () {
              $('#chartmat_mult').highcharts({
                  type: 'line',
                  title: {
                    text: 'Matrix Multiplication',
                    x: -20 //center
                  },
                  subtitle: {x: -20},
                  xAxis: {
                    title: {
                      text: 'Number of elements in one Matrix'
                    },
                  },
                  yAxis: {
                    title: {
                        text: 'Time (s)'
                    },
                    type: 'logarithmic',
                    plotLines: [{
                        value: 0,
                        width: 1,
                        color: '#808080'
                    }]
                  },
                  tooltip: {
                    valueSuffix: 's'
                  },
                  legend: {
                    layout: 'vertical',
                    align: 'right',
                    verticalAlign: 'middle',
                    borderWidth: 0
                  },
                  series: [{
                    name: "NMatrix-LAPACK<br>-Ruby",
                    data: nmatrix_lapacke["mat_mult"]
                  },{
                    name: "NMatrix-Ruby",
                    data: nmatrix_ruby["mat_mult"]
                  },{
                    name: "NMatrix-JRuby",
                    data: nmatrix_jruby["mat_mult"]
                  },{
                    name: "ArrayFire",
                    data: arrayfire["mat_mult"]
                  },
                ]
              });
            });

            $(function () {
              $('#chart_interface').highcharts({
                  type: 'line',
                  title: {
                    text: 'NMatrix - ArrayFire Interface ',
                    x: -20 //center
                  },
                  subtitle: {x: -20},
                  xAxis: {
                    title: {
                      text: 'Number of elements in one Matrix'
                    },
                  },
                  yAxis: {
                    title: {
                        text: 'Time (s)'
                    },
                    type: 'logarithmic',
                    plotLines: [{
                        value: 0,
                        width: 1,
                        color: '#808080'
                    }]
                  },
                  tooltip: {
                    valueSuffix: 's'
                  },
                  legend: {
                    layout: 'vertical',
                    align: 'right',
                    verticalAlign: 'middle',
                    borderWidth: 0
                  },
                  series: [{
                    name: "NMatrix-BLAS-Ruby",
                    data: arrayfire_interface["mat_mult_cpu"],
                    color: 'red'
                  },{
                    name: "ArrayFire",
                    data: arrayfire_interface["mat_mult_gpu"],
                    color: 'orange'
                  },
                ]
              });
            });


            $scope.lapack = ["determinant", "lu_factorization"];

            for (var i=0, l=  $scope.lapack.length; i<l; i++){
              // console.log(key)
              key = $scope.lapack[i];
              console.log(nmatrix_ruby);
              $(function () {
                $('#chart'+key).highcharts({
                    type: 'line',
                    title: {
                      text: 'Matrix '+key,
                      x: -20 //center
                    },
                    subtitle: {x: -20},
                    xAxis: {
                      title: {
                        text: 'Number of elements in one Matrix'
                      },
                    },
                    yAxis: {
                      title: {
                          text: 'Time (s)'
                      },
                      type: 'logarithmic',
                      plotLines: [{
                          value: 0,
                          width: 1,
                          color: '#808080'
                      }]
                    },
                    tooltip: {
                      valueSuffix: 's'
                    },
                    legend: {
                      layout: 'vertical',
                      align: 'right',
                      verticalAlign: 'middle',
                      borderWidth: 0
                    },
                    series: [{
                      name: "NMatrix-LAPACK<br>-Ruby",
                      data: nmatrix_lapacke[key]
                    },{
                      name: "NMatrix-JRuby",
                      data: nmatrix_jruby[key]
                    },{
                      name: "ArrayFire",
                      data: arrayfire_lapacke[key]
                    },
                  ]
                });
              });
            }

          });
          });
        });
      });
    });
  });
})
