$(function() {
	$(".datatable").DataTable({
		 ordering : true,
		 columnDefs: [ {
			targets: -1,
			orderable: false
		 }
		 ],
		language: {
			lengthMenu: '<select><option value="10">10</option>' + '<option value="25">25</option>' + '<option value="50">50</option>' + '<option value="100">100</option>' + '</select>条记录',
			//左上角的分页大小显示。
			search: '搜索：',
			//右上角的搜索文本，可以写html标签
			paginate: { //分页的样式内容。
					previous: "上一页",
					next: "下一页",
			},
			zeroRecords: "没有内容",
			//table tbody内容为空时，tbody的内容。
			//下面三者构成了总体的左下角的内容。
			info: "显示_START_ 至 _END_ 条，共 _TOTAL_ 条",
			//左下角的信息显示，大写的词为关键字。
			infoEmpty: "0条记录",
			emptyTable: "表为空",
			processing: "玩命加载中...",
			//筛选为空时左下角的显示。
			infoFiltered: "" //筛选之后的左下角筛选提示，
		},
		paging: true,
		pagingType: "simple_numbers",
		stateSave: true
	});
});