import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';




class MyAppChart extends StatelessWidget {
  const MyAppChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
   class ChartData {
      ChartData(this.x, this.y, this.y1);
      final int x;
      final double y;
      final double y1;
    }

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  void initState() {
    super.initState();

  late TrackballBehavior _trackballBehavior;
  // late TooltipBehavior _tooltipBehavior;


//--------- TrackballBehavior :  Chính là cái chú giải hiện nên khi người dùng di tay lướt trên biểu đồ   
// Tính năng trackballGehavior hiển thị chú giải công cụ cho các điểm dữ liệu gần với điểm bạn chạm vào trên vùng biểu đồ
//Tính năng này thay thế cho tính năng dataLabel khi không gian không đủ lớn
//Chú giải sẽ được kích hoạt khi bạn nhấn và giữ ở bất kỳ đâu trên biểu đồ -- di chuyển dựa trên chuyển động chạn của bạn cho đến khi bạn ngừng chạm

    _trackballBehavior = TrackballBehavior(
      enable: true,
      lineWidth: 1,
      tooltipAlignment: ChartAlignment.center,
      lineColor: Colors.blue,
      activationMode: ActivationMode.singleTap,
      markerSettings: TrackballMarkerSettings(markerVisibility: TrackballVisibilityMode.visible),
      tooltipDisplayMode: TrackballDisplayMode.nearestPoint,
      tooltipSettings: InteractiveTooltip(enable: true, format: 'point.x h : point.y người'),
    );

//tooltip hỗ trợ chú giải cho tất cả các chuỗi trong series. Nó được sử dụng để hiển thị thông tin về phân đoạn , khi bạn nhấn vào nhân đoạn
//Trạng thái chú giải công cụ sẽ được giữ nguyên khi thay đổi hướng của thiết bị và khi thay đổi kích thước trình duyệt

    // _tooltipBehavior = TooltipBehavior(
    //   // //Cách 1
    //   // enable: true, borderColor: Colors.red, borderWidth: 5, color: Colors.lightBlue, format: 'point.y', tooltipPosition: TooltipPosition.pointer

    //   //Cách 2:
    //   enable: true,
    //   // Templating the tooltip
    //   builder: (dynamic data, dynamic point, dynamic series, int pointIndex, int seriesIndex) {
    //     return Container(child: Text('PointIndex : ${pointIndex.toString()}'));
    //   },

    //   // Tooltip will be displayed on long press
    //   activationMode: ActivationMode.longPress, //Sẽ hiển thị khi ấn và giữ lâu
    //   duration: 5000,
    //   shouldAlwaysShow: true, //Mặc định là false , tooltip đang sẽ được ẩn khi chạm vào
    // );
  }

 @override
    Widget build(BuildContext context) {
            final List<ChartData> chartData = <ChartData>[
            ChartData(2010, 10.53, 3.3),
            ChartData(2011, 9.5, 5.4),
            ChartData(2012, 10, 2.65),
            ChartData(2013, 9.4, 2.62),
            ChartData(2014, 5.8, 1.99),
            ChartData(2015, 4.9, 1.44),
            ChartData(2016, 4.5, 2),
            ChartData(2017, 3.6, 1.56),
            ChartData(2018, 3.43, 2.1),
            ];
        return Scaffold(
            body: Center(
                    child: SfCartesianChart(
                        series: <ChartSeries>[
                            SplineAreaSeries<ChartData, int>(
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y
                            ),
                            SplineAreaSeries<ChartData, int>(
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y1
                            ),
                         //Biểu đồ thứ 3 : demo property
                            SplineAreaSeries<ChartData, int>(
                          //ChartData là data của biểu đồ
                          // dataSource: context.read<InvestDetailBloc>().state['data_chart_overview'],
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x - 1,
                          yValueMapper: (ChartData data, _) => data.y,

                          splineType: SplineType.monotonic,
                          // cardinalSplineTension: 0.9,
                          borderWidth: 3,
                          borderColor: Colors.blue,
                          color: Colors.red,
                          // opacity: 0.2,
                          gradient: const LinearGradient(
                            // Where the linear gradient begins and ends
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              // Colors are easy thanks to Flutter's Colors class.
                              Color.fromARGB(255, 160, 221, 150),
                              Color.fromRGBO(255, 255, 255, 0),
                            ],
                          ),

                          dataLabelMapper: (ChartData data, _) => data.y.toString(),
                          // dataLabelSettings: const DataLabelSettings(isVisible: true)   //Chấp nhận hiển thị giá trị data ngay trên dòng biểu đồ
                          // markerSettings: const MarkerSettings(isVisible: true, color: Colors.amber)   // vẽ thuộc tính điểm đánh dấu

                          enableTooltip: true, // Từng biểu đồ con phải cho thuộc tính enableTooltip để có thể hover hiện chú thích
                        ),
                        ]
                    )
                )
            );
        }
 




}
