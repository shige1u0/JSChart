<%@ page contentType="text/html;charset=utf-8" %>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="initial-scale=1">
	<title>Chart.js Test</title>

	<!-- ========================================== -->
	<!-- ▼グラフ描画領域の装飾(必須ではありません) -->
	<!-- ========================================== -->
	<style type="text/css">
		/* レスポンシブにする。ただし最大横幅は500pxに制限する。 */
		
		canvas {
			width: 100%;
			height: auto;
			max-width: 1000px;
		}
	</style>

	<!-- ======================== -->
	<!-- ▼Chart.min.jsを読み込み -->
	<!-- ======================== -->
	<!--<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/1.0.2/Chart.min.js" type="text/javascript"></script>-->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js" type="text/javascript"></script>
	<script type="text/javascript">
		function Str2Array(str, ary) {
			var rows = [];
			var colums = [];
			var times = [];
			var values = [];
			var i = 0;

			rows = str.split("\n");

			for (i = 0; i < rows.length; i++) {
				colums = rows[i].split("\t");

				if (colums.length != 2) {
					console.log("i = " + i + ", t = " + colums[0] + ", data = " + colums[1]);
					continue;
				}

				times[values.length] = colums[0];
				Array.prototype.push.apply(values, colums[1].split(","));
			}
			times[values.length - 1] = "";

			ary[0] = times;
			ary[1] = values;

			return true;
		}

		function onLoaded(event) {
			var data = [];

			if (Str2Array(event.target.result, data) == false) {
				alert("Str2Array()に失敗しました。");
				console.log("Str2Array() failed.");
				return;
			}

			// Chart.defaults.global.animation = false;
			Chart.defaults.global.animation.duration = 0;

			// // ▼グラフの中身(Ver 1.X)
			// var lineChartData = {
			// 	labels: times,
			// 	datasets: [
			// 		{
			// 			label: "緑データ",
			// 			fillColor: "rgba(92,220,92,0.2)", // 線から下端までを塗りつぶす色
			// 			strokeColor: "rgba(92,220,92,1)", // 折れ線の色
			// 			pointColor: "rgba(92,220,92,1)",  // ドットの塗りつぶし色
			// 			pointStrokeColor: "white",        // ドットの枠線色
			// 			pointHighlightFill: "yellow",     // マウスが載った際のドットの塗りつぶし色
			// 			pointHighlightStroke: "green",    // マウスが載った際のドットの枠線色
			// 			data: values
			// 		}
			// 	]
			// };

			// var opts = {
			// 			datasetFill: false,
			// 			pointDot: false,
			// 			bezierCurve: false
			// };

			// // ▼上記のグラフを描画するための記述
			// var ctx = document.getElementById("graph-area").getContext("2d");
			// window.myLine = new Chart(ctx).Line(lineChartData, opts);

			// ▼グラフの中身(Ver 2.X)
			var lineChartData = {
				labels: data[0],
				datasets: [
					{
						label: "生信号",
						fill: false,
						lineTension: 0,
						borderColor: "blue",					// 折れ線の色
						// borderJoinStyle: "round",
						pointStyle: "circle",
						pointRadius: 3,
						pointBorderWidth: 1,
						pointBorderColor: "rgba(0,0,0,0)",				// ドットの枠線色
						pointBackgroundColor: "rgba(0,0,0,0)",			// ドットの塗りつぶし色
						pointHoverBorderWidth: 3,
						pointHoverBackgroundColor: "yellow",	// マウスが載った際のドットの塗りつぶし色
						pointHoverBorderColor: "green",			// マウスが載った際のドットの枠線色
						data: data[1]
					}
				]
			};

			var ctx = document.getElementById("graph-area").getContext("2d");
			var lineChart = new Chart(ctx, { type:"line", data: lineChartData });

			alert("ファイルの読み込みが完了しました！");
			console.log("text has read.");
		}

		function onError(event) {
			if (event.target.error.code == event.target.error.NOT_READABLE_ERR) {
				alert("ファイルの読み込みに失敗しました！");
			} else {
				alert("エラーが発生しました。" + event.target.error.code);
			}
		}

		function ReadTxt(event) {
			var file = event.target.files[0];

			if (!file) {
				return;
			}

			var reader = new FileReader();

			reader.addEventListener("load", onLoaded);
			reader.addEventListener("error", onError);

			reader.readAsText(file, "Shift_JIS");
		}
	</script>
</head>

<body>
	<h1>Chart.js Test</h1>

	<form><input type="file" id="inFile"></form>
	<div>
		<!-- ====================== -->
		<!-- ▼グラフを描画する領域 -->
		<!-- ====================== -->
		<canvas id="graph-area" height="500" width="1000">（※表示にはcanvas要素を解釈可能なブラウザが必要です）</canvas>

		<!-- ========================== -->
		<!-- ▼折れ線グラフの描画内容を指定 -->
		<!-- ========================== -->
		<script type="text/javascript">
			document.getElementById("inFile").addEventListener("change", ReadTxt, false);

			// // ▼グラフの中身
			// var lineChartData = {
			// 	labels: times,
			// 	datasets: [
			// 		{
			// 			label: "緑データ",
			// 			fillColor: "rgba(92,220,92,0.2)", // 線から下端までを塗りつぶす色
			// 			strokeColor: "rgba(92,220,92,1)", // 折れ線の色
			// 			pointColor: "rgba(92,220,92,1)",  // ドットの塗りつぶし色
			// 			pointStrokeColor: "white",        // ドットの枠線色
			// 			pointHighlightFill: "yellow",     // マウスが載った際のドットの塗りつぶし色
			// 			pointHighlightStroke: "green",    // マウスが載った際のドットの枠線色
			// 			data: values
			// 		}
			// 	]

			// }

			// // ▼上記のグラフを描画するための記述
			// window.onload = function () {
			// 	var ctx = document.getElementById("graph-area").getContext("2d");
			// 	window.myLine = new Chart(ctx).Line(lineChartData);
			// }
		</script>
		<noscript>
			<p>※JavaScriptが使用可能な場合にだけ、グラフが表示されます。</p>
		</noscript>
	</div>
</body>

</html>