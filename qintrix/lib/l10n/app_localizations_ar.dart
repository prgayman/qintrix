// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Qintrix';

  @override
  String get navDashboard => 'لوحة التحكم';

  @override
  String get navServer => 'الخادم';

  @override
  String get navPrinters => 'الطابعات';

  @override
  String get navJobs => 'المهام';

  @override
  String get navApps => 'التطبيقات';

  @override
  String get navLogs => 'السجلات';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get navAbout => 'حول التطبيق';

  @override
  String get dashboardDescription =>
      'اعرض نظرة تشغيلية سريعة وانتقل مباشرة إلى أقسام الإدارة الأساسية.';

  @override
  String get dashboardServerLoading => 'جارٍ تحميل حالة الخادم...';

  @override
  String get serverTitle => 'الخادم';

  @override
  String get serverDescription =>
      'إدارة تشغيل خادم API المدمج وعناصر التحكم وأحدث نشاطات الخادم.';

  @override
  String get dashboardServerRunning => 'قيد التشغيل';

  @override
  String get dashboardServerStopped => 'متوقف';

  @override
  String get dashboardMetricHost => 'المضيف';

  @override
  String get dashboardMetricPort => 'المنفذ';

  @override
  String get dashboardMetricLastChanged => 'آخر تغيير';

  @override
  String get dashboardMetricStartedAt => 'وقت البدء';

  @override
  String get serverMetricRuntime => 'مدة التشغيل';

  @override
  String get dashboardUnavailable => 'غير متاح';

  @override
  String get dashboardServerStart => 'تشغيل';

  @override
  String get dashboardServerStop => 'إيقاف';

  @override
  String get dashboardServerRestart => 'تحديث';

  @override
  String get dashboardRuntimeTitle => 'إعدادات التشغيل';

  @override
  String get dashboardRuntimeSubtitle =>
      'إعدادات الخادم الحالية المستخدمة عند التشغيل التلقائي أو التحكم اليدوي.';

  @override
  String get dashboardConfigLanAccess => 'الوصول عبر الشبكة المحلية';

  @override
  String get dashboardConfigAutoStart => 'تشغيل الخادم تلقائياً';

  @override
  String get dashboardConfigBackgroundMode => 'وضع الخلفية';

  @override
  String get dashboardConfigStartWithOs => 'التشغيل مع النظام';

  @override
  String get dashboardEnabled => 'مفعل';

  @override
  String get dashboardDisabled => 'معطل';

  @override
  String get dashboardRecentActivityTitle => 'النشاط الأخير';

  @override
  String get dashboardRecentActivitySubtitle =>
      'أحدث أحداث دورة حياة الخادم والمصادقة واختبارات الطابعات.';

  @override
  String get dashboardRecentActivityEmpty => 'لم يتم تسجيل أي نشاط للخادم بعد.';

  @override
  String get shellCollapseSidebar => 'طي الشريط الجانبي';

  @override
  String get shellExpandSidebar => 'توسيع الشريط الجانبي';

  @override
  String shellCopyrightText(int year) {
    return 'Qintrix © $year · تم تطويره بواسطة';
  }

  @override
  String get languageEnglish => 'الإنجليزية';

  @override
  String get languageArabic => 'العربية';

  @override
  String get themeModeSystem => 'النظام';

  @override
  String get themeModeLight => 'فاتح';

  @override
  String get themeModeDark => 'داكن';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsDescription =>
      'تحكم في مظهر Qintrix واللغة المستخدمة عند إعادة فتح التطبيق.';

  @override
  String get settingsAppearanceTitle => 'المظهر';

  @override
  String get settingsAppearanceDescription =>
      'اختر طريقة تعامل الواجهة مع الثيم الفاتح والداكن.';

  @override
  String get settingsLanguageTitle => 'اللغة';

  @override
  String get settingsLanguageDescription =>
      'بدل لغة التطبيق فوراً مع حفظ التفضيل تلقائياً.';

  @override
  String get settingsApplicationTitle => 'التطبيق';

  @override
  String get settingsApplicationDescription =>
      'إدارة سلوك التطبيق وتفضيلات بدء التشغيل.';

  @override
  String get settingsApplicationDiagnosticsTitle => 'تشخيص التطبيق';

  @override
  String get settingsApplicationDiagnosticsDescription =>
      'تحقق من حالة التشغيل مع النظام ووضع الخلفية وتكامل أيقونة الشريط حالياً.';

  @override
  String get settingsApplicationStartWithOsStatus => 'التشغيل مع النظام';

  @override
  String get settingsApplicationBackgroundModeStatus => 'وضع الخلفية';

  @override
  String get settingsApplicationTrayStatus => 'أيقونة الشريط / شريط القوائم';

  @override
  String get settingsServerTitle => 'الخادم';

  @override
  String get settingsServerDescription =>
      'إدارة إعدادات الخادم المحلي وتشغيل الوكيل.';

  @override
  String get settingsJobsTitle => 'المهام';

  @override
  String get settingsJobsDescription =>
      'إدارة سلوك بدء قائمة الانتظار وسياسة إعادة المحاولة وإعدادات الاحتفاظ بسجل المهام.';

  @override
  String get settingsAppPort => 'منفذ التطبيق';

  @override
  String get settingsBindHost => 'عنوان IP للربط';

  @override
  String get settingsEnableBackgroundMode => 'تفعيل وضع الخلفية';

  @override
  String get settingsStartWithOs => 'التشغيل مع النظام';

  @override
  String get settingsAllowLanAccess => 'السماح بالوصول عبر الشبكة المحلية';

  @override
  String get settingsAutoStartServer => 'تشغيل الخادم تلقائياً';

  @override
  String get settingsSaveApplication => 'حفظ إعدادات التطبيق';

  @override
  String get settingsSaveServer => 'حفظ إعدادات الخادم';

  @override
  String get settingsSaveJobs => 'حفظ إعدادات المهام';

  @override
  String get settingsJobsStartPaused =>
      'بدء قائمة الانتظار في وضع الإيقاف المؤقت';

  @override
  String get settingsJobsMaxRetries => 'الحد الأقصى لإعادات المحاولة';

  @override
  String get settingsJobsRetryDelaySeconds => 'تأخير إعادة المحاولة (ثوانٍ)';

  @override
  String get settingsJobsHistoryRetentionDays => 'مدة الاحتفاظ بالسجل (أيام)';

  @override
  String get settingsInvalidPort => 'يجب أن يكون المنفذ رقماً بين 1 و65535.';

  @override
  String get settingsInvalidHost =>
      'أدخل عنوان IPv4 محلي فقط مثل 127.0.0.1 أو 192.168.1.20.';

  @override
  String get settingsLanIpDetecting =>
      'جارٍ اكتشاف عنوان IP المتاح على الشبكة المحلية...';

  @override
  String get settingsLanIpAutofilled =>
      'تم اكتشاف عنوان IP محلي وتعبئته تلقائياً.';

  @override
  String get settingsLanIpUnavailable =>
      'لا يوجد عنوان IP محلي متاح حالياً. سيتم الاحتفاظ بالعنوان الحالي.';

  @override
  String get settingsSaveSuccess => 'تم حفظ إعدادات الخادم بنجاح.';

  @override
  String get settingsSaveAndRestartSuccess =>
      'تم حفظ إعدادات الخادم وإعادة تشغيل الخادم.';

  @override
  String get settingsRestartFailed =>
      'تم حفظ الإعدادات، لكن تعذر إعادة تشغيل الخادم.';

  @override
  String get settingsSaveValidationFailed =>
      'يرجى تصحيح الحقول المحددة قبل الحفظ.';

  @override
  String get settingsBindValidationFailed =>
      'لا يمكن استخدام المضيف أو المنفذ المحدد لتشغيل الخادم.';

  @override
  String get aboutTitle => 'حول التطبيق';

  @override
  String get aboutHeading => 'جسر طباعة مكتبي لفرق التشغيل الحديثة';

  @override
  String get aboutDescription =>
      'يربط Qintrix المواقع والأنظمة والأدوات الداخلية بالطابعات المحلية عبر مساحة عمل مكتبية واحدة ومنظمة. تم تصميمه ليجعل الطباعة أكثر موثوقية ووضوحًا وأسهل في الإدارة للمشغلين.';

  @override
  String get aboutHeroEyebrow => 'نظرة عامة على التطبيق';

  @override
  String get aboutHeroPillLocalBridge => 'جسر طباعة محلي';

  @override
  String get aboutHeroPillSecureApps => 'وصول آمن للتطبيقات';

  @override
  String get aboutHeroPillOperationalControl => 'تحكم تشغيلي';

  @override
  String get aboutHeroMetricJobs => 'إجمالي المهام';

  @override
  String get aboutHeroMetricPrinters => 'الطابعات المفعلة';

  @override
  String get aboutHeroMetricApps => 'التطبيقات المفعلة';

  @override
  String get aboutHeroMetricSuccessRate => 'معدل النجاح';

  @override
  String get aboutAnalyticsTitle => 'لقطة تشغيلية مباشرة';

  @override
  String get aboutAnalyticsSubtitle =>
      'قراءة سريعة لحجم العمل والتوفر والتنبيهات النشطة.';

  @override
  String get aboutMetricTotalJobs => 'إجمالي المهام';

  @override
  String get aboutMetricCompletionRate => 'معدل الإنجاز';

  @override
  String get aboutMetricEnabledPrinters => 'الطابعات المفعلة';

  @override
  String get aboutMetricEnabledApps => 'التطبيقات المفعلة';

  @override
  String get aboutMetricQueuedJobs => 'المهام المنتظرة';

  @override
  String get aboutMetricRecentAlerts => 'التنبيهات الحديثة';

  @override
  String get aboutTrendTitle => 'المهام خلال آخر 7 أيام';

  @override
  String get aboutTrendSubtitle => 'نشاط الطباعة اليومي داخل مساحة العمل.';

  @override
  String get dashboardTrendTotalLabel => 'إجمالي الحجم';

  @override
  String get dashboardTrendPeakDayLabel => 'أعلى يوم';

  @override
  String get dashboardAllTimeLabel => 'كل الوقت';

  @override
  String get aboutStatusMixTitle => 'توزيع حالات المهام';

  @override
  String get aboutStatusMixSubtitle =>
      'كيف يتوزع الحمل الحالي بين الحالات المختلفة.';

  @override
  String get aboutConnectionsTitle => 'بصمة الاتصالات';

  @override
  String get aboutConnectionsSubtitle =>
      'أنواع اتصالات الطابعات المكوّنة حالياً في النظام.';

  @override
  String get aboutContentTypesTitle => 'توزيع أنواع المحتوى';

  @override
  String get aboutContentTypesSubtitle =>
      'ما الذي يستقبله النظام غالباً من التطبيقات المتصلة.';

  @override
  String get aboutPurposeTitle => 'ماذا يفعل Qintrix';

  @override
  String get aboutPurposeSubtitle =>
      'مكان واحد لاستقبال أعمال الطباعة ومعالجتها ومراقبتها.';

  @override
  String get aboutPurposeBody =>
      'يعمل Qintrix كحلقة وصل بين طلبات الطباعة القادمة عبر API والطابعات المتوفرة على الجهاز المحلي أو الشبكة. بدلاً من ربط كل طابعة مباشرة مع النظام الخارجي، يمكن للفرق إدارة الطابعات والتطبيقات وسلوك قائمة الانتظار وتشغيل الخادم والتشخيصات من واجهة واحدة.';

  @override
  String get aboutAudienceTitle => 'لمن صُمم';

  @override
  String get aboutAudienceBody =>
      'يناسب البيئات التي تحتاج إلى طباعة مستقرة للإيصالات أو الملصقات أو التذاكر أو محطات العمل، مع إبقاء قواعد الوصول وإعادات المحاولة واستكشاف الأخطاء واضحة للمشغلين وفرق الدعم.';

  @override
  String get aboutWorkflowTitle => 'كيف يعمل التدفق';

  @override
  String get aboutWorkflowSubtitle =>
      'مسار واضح من الطلب الوارد إلى المخرجات المطبوعة المكتملة.';

  @override
  String get aboutWorkflowStepConnectTitle => 'ربط الطابعات والتطبيقات';

  @override
  String get aboutWorkflowStepConnectDescription =>
      'قم بتسجيل الطابعات، واختر نوع الاتصال المناسب، وتحكم في التطبيقات العميلة المسموح لها بإرسال المهام.';

  @override
  String get aboutWorkflowStepProcessTitle =>
      'استقبال المهام ووضعها في الانتظار وتنفيذها';

  @override
  String get aboutWorkflowStepProcessDescription =>
      'يتم التحقق من المهام الواردة وتجهيزها ووضعها في قائمة الانتظار وتنفيذها عبر اتصال الطابعة المكوّن مع الخيارات الصحيحة وآليات إعادة المحاولة.';

  @override
  String get aboutWorkflowStepObserveTitle => 'راقب الحالة وعالج المشاكل بسرعة';

  @override
  String get aboutWorkflowStepObserveDescription =>
      'تابع صحة الخادم وتقدم المهام وحالة قائمة الانتظار والسجلات لحظيًا حتى يتمكن المشغلون من التدخل قبل أن تتحول المشاكل الصغيرة إلى توقف فعلي.';

  @override
  String get aboutModulesTitle => 'الأقسام الرئيسية في مساحة العمل';

  @override
  String get aboutModulesSubtitle =>
      'كل قسم يركز على جزء واحد من عملية الطباعة حتى تبقى الواجهة سهلة القراءة.';

  @override
  String get aboutHighlightsTitle => 'لماذا تستخدمه الفرق';

  @override
  String get aboutHighlightsSubtitle =>
      'مصمم لتقليل احتكاك الطباعة بدون إخفاء التفاصيل التقنية المهمة.';

  @override
  String get aboutHighlightSecureTitle => 'وصول مضبوط';

  @override
  String get aboutHighlightSecureDescription =>
      'تتم مصادقة التطبيقات العميلة عبر مفاتيح API، ويمكن تفعيلها أو تعطيلها بشكل منفصل، وتقييدها على طابعات محددة.';

  @override
  String get aboutHighlightReliableTitle => 'إدارة مهام موثوقة';

  @override
  String get aboutHighlightReliableDescription =>
      'تتحرك المهام عبر حالات واضحة مع عناصر تحكم في قائمة الانتظار وإعادات المحاولة والملفات الناتجة والسجل، مما يجعل تشخيص فشل الطباعة أسهل.';

  @override
  String get aboutHighlightFlexibleTitle => 'دعم مرن للاتصالات';

  @override
  String get aboutHighlightFlexibleDescription =>
      'يدعم Qintrix الطباعة عبر النظام والطباعة عبر TCP الشبكي وتدفقات ESC/POS الخام مع الحفاظ على واجهة تشغيل موحدة.';

  @override
  String get aboutVersionLabel => 'الإصدار';

  @override
  String get aboutVersionDescription => 'إصدار التطبيق الحالي';

  @override
  String get aboutVersionNote =>
      'يضم هذا الإصدار تجربة الخادم والطابعات والمهام والتطبيقات والسجلات والإعدادات داخل واجهة مكتبية واحدة لإدارة عمليات الطباعة الإنتاجية.';

  @override
  String get aboutAttributionTitle => 'التصميم والتطوير بواسطة Tenvoro';

  @override
  String get aboutAttributionSubtitle =>
      'تم تنفيذ تجربة التطبيق والواجهة والتطوير البرمجي بواسطة Tenvoro.';

  @override
  String get aboutAttributionAction => 'عرض الناشر';

  @override
  String get logsTitle => 'السجلات';

  @override
  String get logsDescription =>
      'أحداث التطبيق المخزنة ونشاط الخادم وتحديثات دورة حياة مهام الطباعة.';

  @override
  String get printersTitle => 'الطابعات';

  @override
  String get printersDescription =>
      'إدارة تعريفات الطابعات وأنواع الاتصال وإعدادات الأجهزة.';

  @override
  String get jobsTitle => 'المهام';

  @override
  String get jobsDescription =>
      'متابعة مهام الطباعة وإعادات المحاولة ونشاط قائمة الانتظار وحالة التنفيذ.';

  @override
  String get appsTitle => 'التطبيقات';

  @override
  String get appsDescription =>
      'إدارة تطبيقات العملاء ومفاتيح API وقواعد الوصول إلى الطابعات.';

  @override
  String get jobsSearchPlaceholder => 'ابحث في المهام';

  @override
  String get jobsResetFilters => 'إعادة تعيين الفلاتر';

  @override
  String get jobsFilterStatus => 'الحالة';

  @override
  String get jobsAllStatuses => 'كل الحالات';

  @override
  String get jobsFilterContentType => 'نوع المحتوى';

  @override
  String get jobsAllContentTypes => 'كل أنواع المحتوى';

  @override
  String get jobsStatusAccepted => 'مقبولة';

  @override
  String get jobsStatusRendering => 'قيد التجهيز';

  @override
  String get jobsStatusQueued => 'في قائمة الانتظار';

  @override
  String get jobsStatusProcessing => 'قيد المعالجة';

  @override
  String get jobsStatusCompleted => 'مكتملة';

  @override
  String get jobsStatusFailed => 'فشلت';

  @override
  String get jobsStatusCanceled => 'ألغيت';

  @override
  String get jobsStatusRetryScheduled => 'إعادة المحاولة مجدولة';

  @override
  String get jobsEmptyTitle => 'لا توجد مهام بعد';

  @override
  String get jobsEmptyDescription =>
      'ستظهر مهام الطباعة المقبولة هنا بعد إنشائها عبر واجهة API.';

  @override
  String get jobsRetrySuccess => 'تمت إعادة إدراج المهمة للمحاولة من جديد.';

  @override
  String get jobsCancelSuccess => 'تم إلغاء المهمة بنجاح.';

  @override
  String get jobsColumnId => 'معرف المهمة';

  @override
  String get jobsColumnPrinter => 'الطابعة';

  @override
  String get jobsColumnContentType => 'نوع المحتوى';

  @override
  String get jobsColumnStatus => 'الحالة';

  @override
  String get jobsColumnReference => 'المرجع';

  @override
  String get jobsColumnCreatedAt => 'وقت الإنشاء';

  @override
  String get jobsBackToJobs => 'العودة إلى المهام';

  @override
  String get jobsArtifactLabel => 'الملف الناتج';

  @override
  String get jobsFailureLabel => 'سبب الفشل';

  @override
  String get jobsQueuePausedTitle => 'قائمة الانتظار متوقفة';

  @override
  String get jobsQueuePausedDescription =>
      'يمكن قبول المهام الجديدة، لكن لن تبدأ أي مهمة في قائمة الانتظار حتى يتم استئنافها.';

  @override
  String get jobsQueuePausedBadge => 'متوقفة';

  @override
  String get jobsQueueResumeAction => 'استئناف';

  @override
  String get jobsQueueRunningTitle => 'قائمة الانتظار تعمل';

  @override
  String jobsQueueRunningDescription(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'هناك $count عمال يعالجون المهام حالياً.',
      one: 'هناك عامل واحد يعالج المهام حالياً.',
      zero:
          'لا توجد عمال نشطون الآن. ستبدأ المهام المصطفة تلقائياً عند توفر العامل المناسب.',
    );
    return '$_temp0';
  }

  @override
  String get jobsQueueRunningBadge => 'تعمل';

  @override
  String get printersCreateAction => 'إنشاء طابعة';

  @override
  String get printersEditAction => 'تعديل';

  @override
  String get printersShowAction => 'عرض';

  @override
  String get printersDeleteAction => 'حذف';

  @override
  String get printersDeletedSuccess => 'تم حذف الطابعة بنجاح.';

  @override
  String get printersBulkDeletedSuccess => 'تم حذف الطابعات المحددة بنجاح.';

  @override
  String get printersSaveChanges => 'حفظ التغييرات';

  @override
  String get printersBulkDeleteAction => 'حذف المحدد';

  @override
  String get printersBackToIndex => 'العودة إلى الطابعات';

  @override
  String get printersDeleteTitle => 'حذف الطابعة';

  @override
  String printersDeleteDescription(String name) {
    return 'حذف $name نهائياً؟';
  }

  @override
  String get printersBulkDeleteTitle => 'حذف الطابعات المحددة';

  @override
  String printersBulkDeleteDescription(int count) {
    return 'حذف $count من الطابعات المحددة نهائياً؟';
  }

  @override
  String printersSelectedCount(int count) {
    return 'تم تحديد $count';
  }

  @override
  String get printersEmptyTitle => 'لا توجد طابعات بعد';

  @override
  String get printersEmptyDescription =>
      'أنشئ تعريف طابعة لبدء توجيه مهام الطباعة المستقبلية.';

  @override
  String get printersColumnName => 'الاسم';

  @override
  String get printersColumnIdentifier => 'المعرف';

  @override
  String get printersColumnConnectionType => 'نوع الاتصال';

  @override
  String get printersColumnConnectionSummary => 'ملخص الاتصال';

  @override
  String get printersColumnEnabled => 'مفعل';

  @override
  String get printersColumnLastStatus => 'آخر حالة';

  @override
  String get printersColumnLastStatusMessage => 'رسالة الحالة';

  @override
  String get printersColumnUpdatedAt => 'آخر تحديث';

  @override
  String get printersColumnActions => 'الإجراءات';

  @override
  String get printersSearchPlaceholder => 'ابحث في الطابعات';

  @override
  String get printersFilterConnectionType => 'نوع الاتصال';

  @override
  String get printersFilterAllTypes => 'كل الأنواع';

  @override
  String get printersFilterStatus => 'الحالة';

  @override
  String get printersFilterAllStatuses => 'كل الحالات';

  @override
  String get printersStatusEnabled => 'مفعل';

  @override
  String get printersStatusDisabled => 'معطل';

  @override
  String get printersLastStatusTestSuccess => 'نجح الاختبار';

  @override
  String get printersLastStatusTestFailure => 'فشل الاختبار';

  @override
  String get printersLastStatusTestNotSupported => 'الاختبار غير مدعوم';

  @override
  String get printersLastStatusPrintSuccess => 'نجحت الطباعة';

  @override
  String get printersLastStatusPrintFailure => 'فشلت الطباعة';

  @override
  String get printersLastStatusRenderFailure => 'فشل التجهيز';

  @override
  String get printersTypeTcp => 'طابعة طرفية عبر الشبكة (TCP/IP)';

  @override
  String get printersTypeSystem => 'طابعة USB / النظام (Spooler)';

  @override
  String get printersTypeUsbRaw => 'طابعة USB Raw ESC/POS';

  @override
  String get printersTypeTcpShort => 'TCP/IP';

  @override
  String get printersTypeSystemShort => 'النظام';

  @override
  String get printersTypeUsbRawShort => 'USB Raw';

  @override
  String get printersFormOverviewTitle => 'معلومات الطابعة';

  @override
  String get printersBasicSectionTitle => 'الإعدادات الأساسية';

  @override
  String get printersAdvancedSectionTitle => 'الإعدادات المتقدمة';

  @override
  String get printersConnectionDetailsTitle => 'تفاصيل الاتصال';

  @override
  String get printersUniqueKeyHelper =>
      'يتم إنشاء هذا المعرف تلقائياً وسيستخدم لاحقاً عبر الـ API.';

  @override
  String get printersDescriptionHint => 'وصف داخلي اختياري';

  @override
  String get printersBooleanYes => 'نعم';

  @override
  String get printersBooleanNo => 'لا';

  @override
  String get printersFieldName => 'اسم الطابعة';

  @override
  String get printersFieldIdentifier => 'المعرف';

  @override
  String get printersCopyIdentifierAction => 'نسخ المعرف';

  @override
  String get printersIdentifierCopied => 'تم نسخ المعرف.';

  @override
  String get printersCreatedSuccess => 'تم إنشاء الطابعة بنجاح.';

  @override
  String get printersUpdatedSuccess => 'تم تحديث الطابعة بنجاح.';

  @override
  String get printersTestConnectionAction => 'اختبار الاتصال';

  @override
  String printersTestConnectionSuccess(String message) {
    return 'نجح اختبار الاتصال. $message';
  }

  @override
  String printersTestConnectionFailure(String message) {
    return 'فشل اختبار الاتصال. $message';
  }

  @override
  String printersTestConnectionNotSupported(String message) {
    return 'اختبار الاتصال غير مدعوم حالياً. $message';
  }

  @override
  String get printersTestTcpMissingConfig =>
      'يجب إدخال المضيف والمنفذ قبل اختبار اتصال TCP.';

  @override
  String printersTestTcpSuccess(String host, String port) {
    return 'نجح اتصال TCP إلى $host:$port.';
  }

  @override
  String printersTestTcpTimeout(String host, String port) {
    return 'انتهت مهلة اتصال TCP إلى $host:$port.';
  }

  @override
  String printersTestTcpFailure(String host, String port, String error) {
    return 'فشل اتصال TCP إلى $host:$port. $error';
  }

  @override
  String get printersTestSystemMissingConfig =>
      'يجب إدخال اسم الطابعة أو اسم قائمة الانتظار قبل اختبار اتصال الطابعة عبر النظام.';

  @override
  String printersTestSystemSuccess(String name) {
    return 'طابعة النظام \"$name\" متاحة.';
  }

  @override
  String printersTestSystemFailure(String name) {
    return 'لم يتم العثور على طابعة النظام \"$name\".';
  }

  @override
  String get printersTestUsbMissingConfig =>
      'يجب إدخال معرف Vendor ومعرف Product قبل اختبار اتصال USB الخام.';

  @override
  String printersTestUsbSuccess(String vendorId, String productId) {
    return 'جهاز USB الخام $vendorId:$productId متاح.';
  }

  @override
  String printersTestUsbFailure(String vendorId, String productId) {
    return 'لم يتم العثور على جهاز USB الخام $vendorId:$productId.';
  }

  @override
  String printersTestCommandUnavailable(String command) {
    return 'الأمر المحلي \"$command\" غير متاح على هذا النظام.';
  }

  @override
  String get printersTestUnsupportedPlatform =>
      'اختبار هذا الاتصال غير مدعوم على النظام الحالي.';

  @override
  String get printersFieldDescription => 'الوصف';

  @override
  String get printersFieldConnectionType => 'نوع الاتصال';

  @override
  String get printersFieldEnabled => 'مفعل';

  @override
  String get printersFieldHost => 'المضيف';

  @override
  String get printersFieldPort => 'المنفذ';

  @override
  String get printersFieldConnectTimeout => 'مهلة الاتصال (مللي ثانية)';

  @override
  String get printersFieldWriteTimeout => 'مهلة الكتابة (مللي ثانية)';

  @override
  String get printersFieldReadTimeout => 'مهلة القراءة (مللي ثانية)';

  @override
  String get printersFieldAutoReconnect => 'إعادة الاتصال تلقائياً';

  @override
  String get printersFieldReconnectDelay => 'تأخير إعادة الاتصال (مللي ثانية)';

  @override
  String get printersFieldEncoding => 'الترميز';

  @override
  String get printersFieldCodePage => 'صفحة الرموز';

  @override
  String get printersFieldLineEnding => 'نهاية السطر';

  @override
  String get printersFieldKeepAlive => 'إبقاء الاتصال حياً';

  @override
  String get printersFieldNoDelay => 'بدون تأخير';

  @override
  String get printersFieldLinger => 'الانتظار (ثانية)';

  @override
  String get printersFieldPrinterName => 'اسم الطابعة';

  @override
  String get printersFieldPaperSize => 'حجم الورق';

  @override
  String get printersFieldDefaultCopies => 'عدد النسخ الافتراضي';

  @override
  String get printersFieldColorEnabled => 'تفعيل الألوان';

  @override
  String get printersFieldDuplexMode => 'وضع الطباعة على الوجهين';

  @override
  String get printersFieldOrientation => 'الاتجاه';

  @override
  String get printersFieldJobTimeout => 'مهلة المهمة (مللي ثانية)';

  @override
  String get printersFieldNotes => 'ملاحظات';

  @override
  String get printersFieldDriverName => 'اسم برنامج التشغيل';

  @override
  String get printersFieldQueueName => 'اسم قائمة الانتظار';

  @override
  String get printersFieldSpoolFormat => 'تنسيق الـ Spool';

  @override
  String get printersFieldUseRawSpool => 'استخدام Spool خام';

  @override
  String get printersFieldVendorId => 'معرف Vendor';

  @override
  String get printersFieldProductId => 'معرف Product';

  @override
  String get printersFieldSerialNumber => 'الرقم التسلسلي';

  @override
  String get printersFieldInterfaceNumber => 'رقم الواجهة';

  @override
  String get printersFieldOutEndpoint => 'منفذ الخروج';

  @override
  String get printersFieldInEndpoint => 'منفذ الدخول';

  @override
  String get printersFieldTimeout => 'المهلة (مللي ثانية)';

  @override
  String get printersFieldCharacterTable => 'جدول المحارف';

  @override
  String get printersFieldStatusMonitoring => 'تفعيل مراقبة الحالة';

  @override
  String get printersFieldAutoCutEnabled => 'تفعيل القص التلقائي';

  @override
  String get printersFieldCutMode => 'وضع القص';

  @override
  String get printersFieldCashDrawerEnabled => 'تفعيل درج النقد';

  @override
  String get printersFieldDrawerPin => 'رجل درج النقد';

  @override
  String get printersFieldManufacturer => 'الشركة المصنعة';

  @override
  String get printersFieldProductName => 'اسم المنتج';

  @override
  String get printersFieldAlternateSetting => 'الإعداد البديل';

  @override
  String get printersFieldPacketDelay => 'تأخير الحزمة (مللي ثانية)';

  @override
  String get printersFieldRawGraphicsMode => 'وضع الرسومات الخام';

  @override
  String get printersRawGraphicsModeModern => 'رسومات حديثة';

  @override
  String get printersRawGraphicsModeLegacy => 'تنقيط قديم';

  @override
  String get printersValidationRequired => 'هذا الحقل مطلوب.';

  @override
  String get printersValidationTooLong => 'هذه القيمة طويلة جداً.';

  @override
  String get printersValidationInvalidHost =>
      'أدخل IPv4 أو IPv6 أو اسم مضيف صالح.';

  @override
  String get printersValidationIntegerOnly => 'أدخل أرقاماً فقط.';

  @override
  String get printersValidationTooSmall => 'القيمة أقل من الحد الأدنى المسموح.';

  @override
  String get printersValidationTooLarge =>
      'القيمة أكبر من الحد الأقصى المسموح.';

  @override
  String get printersValidationUsbId =>
      'أدخل معرف USB سداسي عشري مكوناً من 4 خانات.';

  @override
  String get printersValidationUsbEndpoint => 'أدخل قيمة صالحة لمنفذ USB.';

  @override
  String get printersValidationDistinctEndpoints =>
      'يجب ألا يطابق منفذ الإدخال منفذ الإخراج.';

  @override
  String get printersValidationDrawerPin => 'يجب أن تكون رجل الدرج 2 أو 5.';

  @override
  String get printersValidationUniqueKey =>
      'المعرف الذي تم إنشاؤه موجود مسبقاً. حاول مرة أخرى.';

  @override
  String get printersValidationSpoolFormat =>
      'عند استخدام Spool خام يجب أن يكون التنسيق RAW أو فارغاً.';

  @override
  String get appsCreateAction => 'إنشاء تطبيق';

  @override
  String get appsEditAction => 'تعديل';

  @override
  String get appsShowAction => 'عرض';

  @override
  String get appsDeleteAction => 'حذف';

  @override
  String get appsSaveChanges => 'حفظ التغييرات';

  @override
  String get appsBackToIndex => 'العودة إلى التطبيقات';

  @override
  String get appsOverviewTitle => 'نظرة عامة على التطبيق';

  @override
  String get appsAccessTitle => 'وصول الطابعات';

  @override
  String get appsEmptyTitle => 'لا توجد تطبيقات بعد';

  @override
  String get appsEmptyDescription =>
      'أنشئ تطبيقاً لبدء إصدار مفاتيح API وتقييد الوصول إلى الطابعات.';

  @override
  String get appsDeleteTitle => 'حذف التطبيق';

  @override
  String appsDeleteDescription(String name) {
    return 'حذف $name نهائياً؟';
  }

  @override
  String get appsBulkDeleteTitle => 'حذف التطبيقات المحددة';

  @override
  String get appsBulkDeleteAction => 'حذف المحدد';

  @override
  String appsBulkDeleteDescription(int count) {
    return 'حذف $count من التطبيقات المحددة؟';
  }

  @override
  String appsSelectedCount(int count) {
    return '$count محدد';
  }

  @override
  String get appsCreatedSuccess => 'تم إنشاء التطبيق بنجاح.';

  @override
  String get appsUpdatedSuccess => 'تم تحديث التطبيق بنجاح.';

  @override
  String get appsDeletedSuccess => 'تم حذف التطبيق بنجاح.';

  @override
  String get appsBulkDeletedSuccess => 'تم حذف التطبيقات المحددة بنجاح.';

  @override
  String get appsSearchPlaceholder => 'ابحث في التطبيقات';

  @override
  String get appsFilterStatus => 'الحالة';

  @override
  String get appsFilterPrinterScope => 'نطاق الطابعات';

  @override
  String get appsFilterAllStatuses => 'كل الحالات';

  @override
  String get appsFilterAllScopes => 'كل النطاقات';

  @override
  String get appsStatusEnabled => 'مفعّل';

  @override
  String get appsStatusDisabled => 'معطّل';

  @override
  String get appsFieldName => 'الاسم';

  @override
  String get appsFieldEnabled => 'مفعّل';

  @override
  String get appsFieldDescription => 'الوصف';

  @override
  String get appsFieldApiKey => 'مفتاح API';

  @override
  String get appsFieldUpdatedAt => 'آخر تحديث';

  @override
  String get appsDescriptionHint => 'وصف داخلي اختياري';

  @override
  String get appsApiKeyHelper => 'يتم إنشاء مفتاح API تلقائياً لهذا التطبيق.';

  @override
  String get appsCopyApiKeyAction => 'نسخ مفتاح API';

  @override
  String get appsApiKeyCopied => 'تم نسخ مفتاح API.';

  @override
  String get appsAllPrintersNote =>
      'عدم اختيار طابعات يعني السماح بكل الطابعات.';

  @override
  String get appsNoPrintersAvailable => 'لا توجد طابعات متاحة بعد.';

  @override
  String get appsAllPrintersAccess => 'كل الطابعات';

  @override
  String get appsRestrictedPrintersLabel => 'طابعات مقيّدة';

  @override
  String get appsAllowedPrintersLabel => 'الطابعات المسموح بها';

  @override
  String appsRestrictedPrintersCount(int count) {
    return '$count طابعات';
  }

  @override
  String get appsColumnName => 'الاسم';

  @override
  String get appsColumnApiKey => 'مفتاح API';

  @override
  String get appsColumnPrinters => 'الطابعات';

  @override
  String get appsColumnEnabled => 'مفعّل';

  @override
  String get appsColumnUpdatedAt => 'آخر تحديث';

  @override
  String get appsColumnActions => 'الإجراءات';

  @override
  String get appsValidationRequired => 'هذا الحقل مطلوب.';

  @override
  String get appsValidationMaxLength => 'هذه القيمة طويلة جداً.';

  @override
  String get appsValidationDuplicateApiKey =>
      'مفتاح API الذي تم إنشاؤه موجود مسبقاً. حاول مرة أخرى.';

  @override
  String get appsRegenerateApiKeyAction => 'إعادة إنشاء مفتاح API';

  @override
  String get appsRegenerateApiKeyTitle => 'إعادة إنشاء مفتاح API';

  @override
  String appsRegenerateApiKeyDescription(String name) {
    return 'إنشاء مفتاح API جديد لـ $name؟ ستحتاج عمليات الدمج الحالية إلى المفتاح الجديد.';
  }

  @override
  String get appsRegeneratedApiKeySuccess => 'تمت إعادة إنشاء مفتاح API بنجاح.';

  @override
  String get logsLoading => 'جارٍ تحميل السجلات';

  @override
  String get logsEmptyTitle => 'لا توجد سجلات بعد';

  @override
  String get logsEmptyDescription =>
      'سيقوم المسجل بحفظ أحداث التطبيق والخادم والطباعة هنا.';

  @override
  String get logsSearchPlaceholder => 'ابحث في السجلات';

  @override
  String get logsFilterLevel => 'المستوى';

  @override
  String get logsFilterEventType => 'نوع الحدث';

  @override
  String get logsFilterAllLevels => 'كل المستويات';

  @override
  String get logsFilterAllEventTypes => 'كل الأحداث';

  @override
  String get logsResetFilters => 'إعادة تعيين الفلاتر';

  @override
  String get logsColumnTime => 'الوقت';

  @override
  String get logsColumnTitle => 'العنوان';

  @override
  String get logsColumnMessage => 'الرسالة';

  @override
  String get logsColumnEvent => 'الحدث';

  @override
  String get logsColumnLevel => 'المستوى';

  @override
  String get logsShowAction => 'عرض التفاصيل';

  @override
  String get logsBackToLogs => 'العودة إلى السجلات';

  @override
  String get logsMetadataTitle => 'البيانات الوصفية';

  @override
  String tableRowsPerPage(int count) {
    return '$count / صفحة';
  }

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get loading => 'جارٍ التحميل';

  @override
  String get splashLoading => 'يتم تجهيز Qintrix';

  @override
  String get splashErrorTitle => 'فشل بدء التشغيل';

  @override
  String get splashErrorDescription =>
      'تعذر على التطبيق إكمال مهام بدء التشغيل.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get errorDescription => 'حالة الخطأ المشتركة جاهزة للوحدات القادمة.';
}
