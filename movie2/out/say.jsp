<%--
  Created by IntelliJ IDEA.
  User: huangyulang
  Date: 2019-06-26
  Time: 18:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>电影大数据展示</title>
    <meta charset="utf-8">
    <script type="text/javascript" src="http://120.77.168.225/exchange/echarts-all.js"></script>
    <script type="text/javascript" src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
</head>

<body>
<div>
    <div id="points" style="width: auto;height:600px"></div> <!-- 散点图 -->
    <div id="main" style="width: 1200px;height:800px"></div>
    <div id="test" style="margin: auto"></div>
    <div id="sorts" style="width: auto;height:600px"></div>
    <div id="director" style="width: 500px;height:600px;margin: auto"></div>
</div>
<script type="text/javascript">
    $(function() {
        $.getJSON("http://localhost:8080/movie2/hi/dir", function (data) {
            var top_director = data.slice(0,10);
            var low_director = data.slice(-10);

            var name = [];
            var su = [];
            var fa = [];
            top_director.forEach(function(a){
                su.push(a['avg']);
                name.push(a['name']);
                console.info(a['name']);
            });
            for(i=0;i<10;i++){
                su.push(0);
                fa.push(0);
            }
            low_director.forEach(function(b){
                fa.push(b['avg']);
                name.push(b['name']);
                console.info(b['name']);
            });


            var myChart = echarts.init(document.getElementById('director'));
            var option = {
                title : {
                    text: '最成功导演与最失败导演',
                    subtext: '纯属虚构'
                },
                tooltip : {
                    trigger: 'axis'
                },
                legend: {
                    data:['最成功导演','最失败导演']
                },
                toolbox: {
                    show : true,
                    feature : {
                        mark : {show: true},
                        dataView : {show: true, readOnly: false},
                        magicType : {show: true, type: ['line', 'bar']},
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                calculable : true,
                xAxis : [
                    {
                        type : 'value',
                        //boundaryGap : [0, 0.01]
                    }
                ],
                yAxis : [
                    {
                        type : 'category',
                        data : name
                    }
                ],
                series : [
                    {
                        name:'失败导演',
                        type:'bar',
                        data:fa,
                    },
                    {
                        name:'成功导演',
                        type:'bar',
                        data:su,
                    }

                ]
            };
            myChart.setOption(option);
        })
    })
</script>

<script type="text/javascript">
    $(function(){
        $.getJSON("http://localhost:8080/movie2/hi/ty",function(data) {
            var temp = [];
            $.each(data,function(index,ty) {
                var year = parseInt(ty.year);
                var num = year - 1911;
                var type = ty.type;
                for (x in type) {
                    var flag = true;
                    temp.forEach(function(s){
                        if(s.name==x) {
                            flag = false;
                            s.data[num] += parseInt(type[x]);
                        }
                    });
                    if(flag){
                        var p = [];
                        for(i=1911;i<=2019;i++){
                            p.push(0);
                        }
                        var so = {
                            name:x,
                            type:'line',
                            stack: '总量',
                            itemStyle: {normal: {areaStyle: {type: 'default'}}},
                            data:p
                        }
                        so.data[num] + parseInt(type[x]);
                        temp.push(so);
                    }
                }

            });

            var all_year = [];
            for(i=1911;i<=2019;i++){
                all_year.push(i);
            }
            var myChart = echarts.init(document.getElementById('sorts'));
            var option = {
                tooltip : {
                    trigger: 'axis'
                },
                legend: {
                    data:['喜剧','情色','惊栗','脱口秀','科幻','悬念','愛情 Romance','运动','恐怖','儿童','音樂 Music','灾难','戏曲','同性','犯罪','西部','Adult','动画','传记','纪录片','荒诞','惊悚','驚悚 Thriller','冒险','奇幻','歌舞','動畫 Animation','历史','悬疑','古装','真人秀','音乐','動作 Action','剧情','黑色电影','短片','舞台艺术','武侠','爱情','家庭','鬼怪','战争','动作','Reality-TV']
                },
                toolbox: {
                    show : true,
                    feature : {
                        mark : {show: true},
                        dataView : {show: true, readOnly: false},
                        magicType : {show: true, type: ['line', 'bar', 'stack', 'tiled']},
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                calculable : true,
                xAxis : [
                    {
                        type : 'category',
                        boundaryGap : false,
                        data : all_year
                    }
                ],
                yAxis : [
                    {
                        type : 'value'
                    }
                ],
                series : temp
            };
            myChart.setOption(option);
        });
    });
</script>
<!-- 饼状图 -->
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    /*var myChart = echarts.init(document.getElementById('main'));

    // 指定图表的配置项和数据
    var option = {
        title : {
            text: '某站点用户访问来源',
            subtext: '纯属虚构',
            x:'center'
        },
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            orient : 'vertical',
            x : 'left',
            data:['直接访问','邮件营销','联盟广告','视频广告','搜索引擎']
        },
        toolbox: {
            show : true,
            feature : {
                mark : {show: true},
                dataView : {show: true, readOnly: false},
                magicType : {
                    show: true,
                    type: ['pie', 'funnel'],
                    option: {
                        funnel: {
                            x: '25%',
                            width: '50%',
                            funnelAlign: 'left',
                            max: 1548
                        }
                    }
                },
                restore : {show: true},
                saveAsImage : {show: true}
            }
        },
        calculable : true,
        series : [
            {
                name:'访问来源',
                type:'pie',
                radius : '55%',
                center: ['50%', '60%'],
                data:[
                    {value:335, name:'直接访问'},
                    {value:310, name:'邮件营销'},
                    {value:234, name:'联盟广告'},
                    {value:135, name:'视频广告'},
                    {value:1548, name:'搜索引擎'}
                ]
            }
        ]
    };

    // 使用刚的配置项和数据显示图表。

    myChart.setOption(option);*/
</script>

<script type="text/javascript">
    $(function () {
        $.getJSON("http://localhost:8080/movie2/hi/num",function (data) {
            var p = [];
            var title = [];
            var i = 0;
            $.each(data,function(key,num) {
                    //console.info(x);

                    title.push(
                        key
                    );
                    p.push({
                        name:key,
                        value:num
                    });
                    i++;
            });
            var myChart = echarts.init(document.getElementById('main'));
            var option = {
                title : {
                    text: '电影类别分布图',
                    subtext: '数据来自豆瓣',
                    x:'center'
                },
                tooltip : {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                legend: {
                    orient : 'vertical',
                    x : 'left',
                    data:title
                },
                toolbox: {
                    show : true,
                    feature : {
                        mark : {show: true},
                        dataView : {show: true, readOnly: false},
                        magicType : {
                            show: true,
                            type: ['pie', 'funnel'],
                            option: {
                                funnel: {
                                    x: '25%',
                                    width: '50%',
                                    funnelAlign: 'left',
                                    max: 1548
                                }
                            }
                        },
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                calculable : true,
                series : [
                    {
                        name:'访问来源',
                        type:'pie',
                        radius : '55%',
                        center: ['50%', '60%'],
                        data:p
                    }
                ]
            };
            myChart.setOption(option);
        });
    })
</script>

<!-- 散点图 -->
<script  type="text/javascript">
    $(function(){
        $.getJSON("http://localhost:8080/movie2/hi/json",function(data){
            var p = [];
            var i = 0;
            $.each(data,function(infoIndex,info){
                if(info["time"].length >= 10 && info["time"].charAt(7)=='-'){
                    var time = info["time"].substr(0,10);
                    var date = time.replace(/-/g, "/");
                    var x = parseFloat(info["score"]).toFixed(2)-0;
                    //console.info(x);
                    p.push([
                        new Date(date),
                        x,
                        info["name"]
                    ]);
                    i++;
                }
            })
            var myChart = echarts.init(document.getElementById('points'));

            // 指定图表的配置项和数据
            var option = {
                title : {
                    text : 'movies时间分布散点图',
                    subtext : 'dataZoom支持'
                },
                tooltip : {
                    trigger: 'axis',
                    axisPointer:{
                        show: true,
                        type : 'cross',
                        lineStyle: {
                            type : 'dashed',
                            width : 1
                        }
                    }
                },
                toolbox: {
                    show : true,
                    feature : {
                        mark : {show: true},
                        dataView : {show: true, readOnly: false},
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                //最初现实范围70%至100%
                dataZoom: {
                    show: true,
                    start : 70,
                    end : 100
                },
                legend : {
                    data : ['movies']
                },
                // dataRange: {
                //     min: 0,
                //     max: 10,
                //     orient: 'horizontal',
                //     y: 30,
                //     x: 'center',
                //     //text:['高','低'],           // 文本，默认为数值文本
                //     color:['lightgreen','orange'],
                //     splitNumber: 10
                // },
                grid: {
                    y2: 80
                },
                xAxis : [
                    {
                        type : 'time',
                        splitNumber:10
                    }
                ],
                yAxis : [
                    {
                        type : 'value'
                    }
                ],
                animation: false,
                series : [
                    {
                        name:'movies',
                        type:'scatter',
                        tooltip : {
                            trigger: 'axis',
                            formatter : function (params) {
                                console.info("start:");
                                var date = new Date(params.value[0]);
                                console.info("p:"+date.getDate());
                                return ''//params.seriesName
                                    + params.value[2]
                                    +  '<br/>'
                                    + ' （'
                                    + date.getFullYear() + '-'
                                    + (date.getMonth() + 1) + '-'
                                    + date.getDate() + '） '
                                    + ', '
                                    + params.value[1];
                            },
                            axisPointer:{
                                type : 'cross',
                                lineStyle: {
                                    type : 'dashed',
                                    width : 1
                                }
                            }
                        },
                        symbolSize: 2,
                        data: (function () {
                            var d = p;
                            var len = 0;
                            var now = new Date();
                            var value;
                            // while (len++ < 1500) {
                            //     d.push([
                            //         new Date(1900, 1, 1, 0, Math.round(Math.random()*100000000)),
                            //         (Math.random()*10).toFixed(2) - 0,
                            //         (Math.random()*100).toFixed(2) - 0
                            //     ]);
                            // }
                            return d;
                        })()
                    }
                ]
            };
            myChart.setOption(option);
        })
    })
</script>

<!--<script  type="text/javascript">-->
<!--$(function(){-->
<!--$.getJSON("data.json",function(data){-->
<!--// for(var i=0; i<100; i++){-->
<!--//     $('#test').append(data[i].name + "<br>");-->
<!--// }-->
<!--var strHtml = "";-->
<!--$.each(data,function(infoIndex,info){-->
<!--if(info["time"].length >= 10) {-->
<!--var time = info["time"].substr(0, 10);-->
<!--strHtml += time.replace(/-/g, "/") + info["name"] +  (parseFloat(info["score"]).toFixed(2)-0)+"<br/>";-->

<!--}-->

<!--})-->
<!--$('#test').html(strHtml);-->
<!--})-->
<!--})-->
<!--</script>-->
</body>
</html>
