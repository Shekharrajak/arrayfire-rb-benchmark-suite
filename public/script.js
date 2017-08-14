var app = angular.module('resultApp',[]);

app.controller('MainCtrl', function($scope, $http) {

  resultRubyUrl = "ruby.json"
  resultJavaRubyUrl = "jruby.json"
  resultLapackeRubyUrl = "ruby-lapacke.json"


  $scope.checked= false;
  $http.get(resultRubyUrl).success(function(data) {
     $http.get(resultJavaRubyUrl).success(function(data2) {
      $http.get(resultLapackeRubyUrl).success(function(data3) {
        $scope.charts = data.features;
        data.features.jruby = data2.features.jruby
        data.features.rubyLapacke = data3.features.ruby
        console.log($scope.charts);

        for (key in $scope.charts.jruby){
          // console.log($scope.charts.features[key])
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
                  name: "ruby",
                  data: $scope.charts.ruby[key]
                },{
                  name: "jruby",
                  data: $scope.charts.jruby[key]
                },{
                  name: "ruby-lapacke",
                  data: $scope.charts.rubyLapacke[key]
                },
              ]
            });
          });
        }
      });
    });
  });
})


resultRubyUrl = "ruby.json"
resultJavaRubyUrl = "jruby.json"
