/*
 尺寸控制
*/

//Dock上选项定尺寸
#define kDockItemW 100
#define kDockItemH 80

//日志输出宏定义
#ifdef DEBUG
//调试状态
#define MyLog(...) NSLog(__VA_ARGS__)
#else
//发布状态
#define MyLog(...)
#endif