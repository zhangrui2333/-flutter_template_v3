import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/langs/translation_service.dart';
import 'package:flutter_ducafecat_news_getx/common/routers/pages.dart';
import 'package:flutter_ducafecat_news_getx/common/store/store.dart';
import 'package:flutter_ducafecat_news_getx/common/style/style.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/utils.dart';
import 'package:flutter_ducafecat_news_getx/global.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

Future<void> main() async {
  await Global.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context , child) {
        return RefreshConfiguration(
          headerBuilder: () => ClassicHeader(),
          footerBuilder: () => ClassicFooter(),
          hideFooterWhenNotFull: true,
          headerTriggerDistance: 80,
          maxOverScrollExtent: 100,
          footerTriggerDistance: 150,
          child: GetMaterialApp(
            // showPerformanceOverlay: true, //显示性能标签
            // debugShowCheckedModeBanner: false, // 去除右上角debug的标签
            // checkerboardRasterCacheImages: true,
            // showSemanticsDebugger: true, // 显示语义视图
            // checkerboardOffscreenLayers: true, // 检查离屏渲染
            title: 'getx练习', // 程序切换时显示的标题
            theme: AppTheme.light, // 主题颜色
            initialRoute: AppPages.INITIAL, // 初始路由，如果设置了该参数并且在 routes 找到了对应的key，将会展示对应的 Widget ，否则展示 home 
            getPages: AppPages.routes, // 路由表
            builder: EasyLoading.init(), // 在构建MaterialApp的Widget tree时，也就是加载child之前给child参数上再加一个父节点。所以一些toast库等需要全局context的三方库，会用builder将自己加到widget tree中
            translations: TranslationService(), //显示继承Translations，配置显示国际化内容
            navigatorObservers: [AppPages.observer], // 创建导航器的观察者列表
            localizationsDelegates: [ // 用来存放自定义的多语言资源
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: ConfigStore.to.languages, // 当应用程序支持不同语言的时候，就需要对应用程序进行国际化
            locale: ConfigStore.to.locale, // 默认展示本地语言
            fallbackLocale: Locale('zh', 'CN'), // 语言选择无效时，备用语言 'en', 'US'
            enableLog: true, // 是否显示Log日志信息
            logWriterCallback: Logger.write, // 日志信息打印输出回调
          )
        );
      },
    );
  }
}
