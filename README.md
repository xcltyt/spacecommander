# FORK FORM [Space Commander]

重新整理 希望可以和项目整合到一起

实现：

1.更完善的代码校验

2.更方便的项目使用

3.更合理的代码提示和 代码不规范处提示。

window 模式下的操作快捷方式

Ctrl - w 切换光标位置

1. Ctrl-w K（把当前窗口移到最上边）
2. Ctrl-w H（把当前窗口移到最左边）
3. Ctrl-w  J（把当前窗口移到最下边）
4. Ctrl-w L（把当前窗口移到最右边）

]c  跳向下一个编辑点

[c 跳向上一个编辑点

do 将另一个文件的编辑点覆盖到当前文件（注意光标位置）

dp 将当前文件的编辑点覆盖到另一份文件

Ctrl - u 撤销修改(保证光标在需要撤销的文件下 处于INSERT模式) 如果非INSERT模式直接 u 就是撤销

:qa 不修改退出 （编辑过后不可用  需要使用 :qa!  表示撤销修改后退出）

:wqa 保存修改退出