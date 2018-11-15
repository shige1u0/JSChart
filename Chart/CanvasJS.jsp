<%@ page contentType="text/html;charset=utf-8" %>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta charset="utf-8" />
	<title>CanvasJS Test</title>
	<script type="text/javascript">
		function Str2ObjArray(str, data) {
			var rows = [];
			var colums = [];
			var values = [];
			var dataSeries = { type: "line" };
			var dataPoints = [];
			var i = 0;
			var j = 0;
			var n = 0;
			var t = 0;

			rows = str.split("\n");

			for (i = 0; i < rows.length; i++) {
				colums = rows[i].split("\t");

				if (colums.length != 2) {
					console.log("i = " + i + ", t = " + colums[0] + ", data = " + colums[1]);
					continue;
				}

				t = (new Date(colums[0])).valueOf();

				values = colums[1].split(",");
				n = values.length;					//increase number of dataPoints by increasing this

				for (j = 0; j < n; j++ , t += 10) {
					dataPoints.push({
						x: new Date(t),
						y: parseFloat(values[j])
					});
				}
			}

			dataSeries.dataPoints = dataPoints;
			data.push(dataSeries);

			return true;
		}

		function onLoaded(event) {
			var data = [];

			if (Str2ObjArray(event.target.result, data) == false) {
				alert("Str2ObjArray()に失敗しました。");
				console.log("Str2ObjArray() failed.");
				return;
			}

			var chart = new CanvasJS.Chart("chartContainer",
				{
					zoomEnabled: true,
					title: {
						text: "生信号"
					},
					axisY: {
						includeZero: false
					},
					data: data,  // random generator below

				});

			chart.render();

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
	<script src="./lib/canvasjs.min.js"></script>
</head>

<body>
	<h1>CanvasJS Test</h1>
	<form><input type="file" id="inFile"></form>
	<script type="text/javascript">
		document.getElementById("inFile").addEventListener("change", ReadTxt, false);
	</script>

	<div id="chartContainer" style="height: 400px; width: 100%;">
	</div>
</body>

</html>