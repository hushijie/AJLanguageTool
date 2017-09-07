# AJLanguageTool
国际化工具类，模仿微信的国际化方案，实现.m文件国际化（文字国际化）、InfoPlist文件的国际化（app名字国际化）

1.Internationalization.strings :
  .m文件中固定文案的国际化，例如：vc标题、按钮title、弹窗提示文案等。
  需要国际化的文字key的命名规则：类名_控件名，例如：AJLanguageChooseViewController_CancelBtnTitle，
  表示类AJLanguageChooseViewController中的取消按钮标题文案

2.InfoPlist.strings ：
  设置InfoPlist文件中的需要国际化的文案，例如app名字、系统弹窗文案（例如：是否开启通知系统弹窗）等
  
