---
title: jstree使用说明
abbrlink: ff1c1cc4
date: 2016-09-19 18:07:22
tags:
    - jquery
    - jstree
---
前端开发,树插件在特定情形下还是有必要的,我在玩过ztree,jstree之后,对比觉得还是jstree更为灵活,单纯说api文档的话,
必须承认ztree好些,但是我还是建议使用jstree,因为更灵活。
这里贴出jstree官网:<https://www.jstree.com/api/>
**节点添加,重命名,删除代码**
```javascript
<script>
function demo_create() {
var ref = $('#jstree_demo').jstree(true),
sel = ref.get_selected();
if(!sel.length) { return false; }
sel = sel[0];
sel = ref.create_node(sel, {"type":"file"});
if(sel) {
ref.edit(sel);
}
};
function demo_rename() {
var ref = $('#jstree_demo').jstree(true),
sel = ref.get_selected();
if(!sel.length) { return false; }
sel = sel[0];
ref.edit(sel);
};
function demo_delete() {
var ref = $('#jstree_demo').jstree(true),
sel = ref.get_selected();
if(!sel.length) { return false; }
ref.delete_node(sel);
};
$(function () {
var to = false;
$('#demo_q').keyup(function () {
if(to) { clearTimeout(to); }
to = setTimeout(function () {
var v = $('#demo_q').val();
$('#jstree_demo').jstree(true).search(v);
}, 250);});
testData = ["Child 1", { "id" : "demo_child_1", "text" : "Child 2", "children" : [ { "id" : "demo_child_2", "text" : "One more", "type" : "file" }] }];
$('#jstree_demo').jstree({
	"core" : {"animation" : 0,
			"check_callback" : true,
	"themes" : { "stripes" : true },
	'data' : testData 
},
"types" : {
"#" : { "max_children" : 1, "max_depth" : 4, "valid_children" : ["root"] },
"root" : { "icon" : "/static/3.0.2/assets/images/tree_icon.png", "valid_children" : ["default"] },
"default" : { "valid_children" : ["default","file"] },
"file" : { "icon" : "glyphicon glyphicon-file", "valid_children" : [] }
},
"plugins" : [ "contextmenu", "dnd", "search", "state", "types", "wholerow" ]
});
});
						</script>
```

