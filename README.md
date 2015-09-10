# ARGrideMenuDemo
swift写的九宫格菜单demo，支持自定义行列数、行列间隔大小、图片的样式等，使用简单

使用范例
var menu:ARGridMenu=ARGridMenu(orginY: 100, titleArr: ["PAG1","PAG2","PAG3","PAG4","PAG2","PAG3","PAG4","PAG2","PAG3","PAG4","PAG2","PAG3","PAG4","PAG3","PAG4","PAG2","PAG3","PAG4","PAG2","PAG3","PAG4","PAG2","PAG3","PAG4"], imageArr: ["PAG1","PAG2","PAG3","PAG4","PAG2","PAG3","PAG4","PAG2","PAG3","PAG4","PAG2","PAG3","PAG4","PAG3","PAG4","PAG2","PAG3","PAG4","PAG2","PAG3","PAG4","PAG2","PAG3","PAG4"])
menu.delegate=self
self.view.addSubview(menu)

选中代理ARGridMenuDelegate

func selectedWithIndex(index: Int) {
    
}
