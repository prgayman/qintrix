// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SettingsTableTable extends SettingsTable
    with TableInfo<$SettingsTableTable, SettingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _appPortMeta = const VerificationMeta(
    'appPort',
  );
  @override
  late final GeneratedColumn<int> appPort = GeneratedColumn<int>(
    'app_port',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(4880),
  );
  static const VerificationMeta _bindHostMeta = const VerificationMeta(
    'bindHost',
  );
  @override
  late final GeneratedColumn<String> bindHost = GeneratedColumn<String>(
    'bind_host',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('127.0.0.1'),
  );
  static const VerificationMeta _enableBackgroundModeMeta =
      const VerificationMeta('enableBackgroundMode');
  @override
  late final GeneratedColumn<bool> enableBackgroundMode = GeneratedColumn<bool>(
    'enable_background_mode',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enable_background_mode" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _startWithOsMeta = const VerificationMeta(
    'startWithOs',
  );
  @override
  late final GeneratedColumn<bool> startWithOs = GeneratedColumn<bool>(
    'start_with_os',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("start_with_os" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _allowLanAccessMeta = const VerificationMeta(
    'allowLanAccess',
  );
  @override
  late final GeneratedColumn<bool> allowLanAccess = GeneratedColumn<bool>(
    'allow_lan_access',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("allow_lan_access" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _autoStartServerMeta = const VerificationMeta(
    'autoStartServer',
  );
  @override
  late final GeneratedColumn<bool> autoStartServer = GeneratedColumn<bool>(
    'auto_start_server',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("auto_start_server" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _jobsStartPausedMeta = const VerificationMeta(
    'jobsStartPaused',
  );
  @override
  late final GeneratedColumn<bool> jobsStartPaused = GeneratedColumn<bool>(
    'jobs_start_paused',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("jobs_start_paused" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _jobsMaxRetryAttemptsMeta =
      const VerificationMeta('jobsMaxRetryAttempts');
  @override
  late final GeneratedColumn<int> jobsMaxRetryAttempts = GeneratedColumn<int>(
    'jobs_max_retry_attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _jobsRetryDelaySecondsMeta =
      const VerificationMeta('jobsRetryDelaySeconds');
  @override
  late final GeneratedColumn<int> jobsRetryDelaySeconds = GeneratedColumn<int>(
    'jobs_retry_delay_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(30),
  );
  static const VerificationMeta _jobsHistoryRetentionDaysMeta =
      const VerificationMeta('jobsHistoryRetentionDays');
  @override
  late final GeneratedColumn<int> jobsHistoryRetentionDays =
      GeneratedColumn<int>(
        'jobs_history_retention_days',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(7),
      );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    appPort,
    bindHost,
    enableBackgroundMode,
    startWithOs,
    allowLanAccess,
    autoStartServer,
    jobsStartPaused,
    jobsMaxRetryAttempts,
    jobsRetryDelaySeconds,
    jobsHistoryRetentionDays,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('app_port')) {
      context.handle(
        _appPortMeta,
        appPort.isAcceptableOrUnknown(data['app_port']!, _appPortMeta),
      );
    }
    if (data.containsKey('bind_host')) {
      context.handle(
        _bindHostMeta,
        bindHost.isAcceptableOrUnknown(data['bind_host']!, _bindHostMeta),
      );
    }
    if (data.containsKey('enable_background_mode')) {
      context.handle(
        _enableBackgroundModeMeta,
        enableBackgroundMode.isAcceptableOrUnknown(
          data['enable_background_mode']!,
          _enableBackgroundModeMeta,
        ),
      );
    }
    if (data.containsKey('start_with_os')) {
      context.handle(
        _startWithOsMeta,
        startWithOs.isAcceptableOrUnknown(
          data['start_with_os']!,
          _startWithOsMeta,
        ),
      );
    }
    if (data.containsKey('allow_lan_access')) {
      context.handle(
        _allowLanAccessMeta,
        allowLanAccess.isAcceptableOrUnknown(
          data['allow_lan_access']!,
          _allowLanAccessMeta,
        ),
      );
    }
    if (data.containsKey('auto_start_server')) {
      context.handle(
        _autoStartServerMeta,
        autoStartServer.isAcceptableOrUnknown(
          data['auto_start_server']!,
          _autoStartServerMeta,
        ),
      );
    }
    if (data.containsKey('jobs_start_paused')) {
      context.handle(
        _jobsStartPausedMeta,
        jobsStartPaused.isAcceptableOrUnknown(
          data['jobs_start_paused']!,
          _jobsStartPausedMeta,
        ),
      );
    }
    if (data.containsKey('jobs_max_retry_attempts')) {
      context.handle(
        _jobsMaxRetryAttemptsMeta,
        jobsMaxRetryAttempts.isAcceptableOrUnknown(
          data['jobs_max_retry_attempts']!,
          _jobsMaxRetryAttemptsMeta,
        ),
      );
    }
    if (data.containsKey('jobs_retry_delay_seconds')) {
      context.handle(
        _jobsRetryDelaySecondsMeta,
        jobsRetryDelaySeconds.isAcceptableOrUnknown(
          data['jobs_retry_delay_seconds']!,
          _jobsRetryDelaySecondsMeta,
        ),
      );
    }
    if (data.containsKey('jobs_history_retention_days')) {
      context.handle(
        _jobsHistoryRetentionDaysMeta,
        jobsHistoryRetentionDays.isAcceptableOrUnknown(
          data['jobs_history_retention_days']!,
          _jobsHistoryRetentionDaysMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SettingsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      appPort: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}app_port'],
      )!,
      bindHost: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bind_host'],
      )!,
      enableBackgroundMode: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enable_background_mode'],
      )!,
      startWithOs: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}start_with_os'],
      )!,
      allowLanAccess: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}allow_lan_access'],
      )!,
      autoStartServer: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}auto_start_server'],
      )!,
      jobsStartPaused: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}jobs_start_paused'],
      )!,
      jobsMaxRetryAttempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}jobs_max_retry_attempts'],
      )!,
      jobsRetryDelaySeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}jobs_retry_delay_seconds'],
      )!,
      jobsHistoryRetentionDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}jobs_history_retention_days'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SettingsTableTable createAlias(String alias) {
    return $SettingsTableTable(attachedDatabase, alias);
  }
}

class SettingsTableData extends DataClass
    implements Insertable<SettingsTableData> {
  final int id;
  final int appPort;
  final String bindHost;
  final bool enableBackgroundMode;
  final bool startWithOs;
  final bool allowLanAccess;
  final bool autoStartServer;
  final bool jobsStartPaused;
  final int jobsMaxRetryAttempts;
  final int jobsRetryDelaySeconds;
  final int jobsHistoryRetentionDays;
  final DateTime updatedAt;
  const SettingsTableData({
    required this.id,
    required this.appPort,
    required this.bindHost,
    required this.enableBackgroundMode,
    required this.startWithOs,
    required this.allowLanAccess,
    required this.autoStartServer,
    required this.jobsStartPaused,
    required this.jobsMaxRetryAttempts,
    required this.jobsRetryDelaySeconds,
    required this.jobsHistoryRetentionDays,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['app_port'] = Variable<int>(appPort);
    map['bind_host'] = Variable<String>(bindHost);
    map['enable_background_mode'] = Variable<bool>(enableBackgroundMode);
    map['start_with_os'] = Variable<bool>(startWithOs);
    map['allow_lan_access'] = Variable<bool>(allowLanAccess);
    map['auto_start_server'] = Variable<bool>(autoStartServer);
    map['jobs_start_paused'] = Variable<bool>(jobsStartPaused);
    map['jobs_max_retry_attempts'] = Variable<int>(jobsMaxRetryAttempts);
    map['jobs_retry_delay_seconds'] = Variable<int>(jobsRetryDelaySeconds);
    map['jobs_history_retention_days'] = Variable<int>(
      jobsHistoryRetentionDays,
    );
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SettingsTableCompanion toCompanion(bool nullToAbsent) {
    return SettingsTableCompanion(
      id: Value(id),
      appPort: Value(appPort),
      bindHost: Value(bindHost),
      enableBackgroundMode: Value(enableBackgroundMode),
      startWithOs: Value(startWithOs),
      allowLanAccess: Value(allowLanAccess),
      autoStartServer: Value(autoStartServer),
      jobsStartPaused: Value(jobsStartPaused),
      jobsMaxRetryAttempts: Value(jobsMaxRetryAttempts),
      jobsRetryDelaySeconds: Value(jobsRetryDelaySeconds),
      jobsHistoryRetentionDays: Value(jobsHistoryRetentionDays),
      updatedAt: Value(updatedAt),
    );
  }

  factory SettingsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsTableData(
      id: serializer.fromJson<int>(json['id']),
      appPort: serializer.fromJson<int>(json['appPort']),
      bindHost: serializer.fromJson<String>(json['bindHost']),
      enableBackgroundMode: serializer.fromJson<bool>(
        json['enableBackgroundMode'],
      ),
      startWithOs: serializer.fromJson<bool>(json['startWithOs']),
      allowLanAccess: serializer.fromJson<bool>(json['allowLanAccess']),
      autoStartServer: serializer.fromJson<bool>(json['autoStartServer']),
      jobsStartPaused: serializer.fromJson<bool>(json['jobsStartPaused']),
      jobsMaxRetryAttempts: serializer.fromJson<int>(
        json['jobsMaxRetryAttempts'],
      ),
      jobsRetryDelaySeconds: serializer.fromJson<int>(
        json['jobsRetryDelaySeconds'],
      ),
      jobsHistoryRetentionDays: serializer.fromJson<int>(
        json['jobsHistoryRetentionDays'],
      ),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'appPort': serializer.toJson<int>(appPort),
      'bindHost': serializer.toJson<String>(bindHost),
      'enableBackgroundMode': serializer.toJson<bool>(enableBackgroundMode),
      'startWithOs': serializer.toJson<bool>(startWithOs),
      'allowLanAccess': serializer.toJson<bool>(allowLanAccess),
      'autoStartServer': serializer.toJson<bool>(autoStartServer),
      'jobsStartPaused': serializer.toJson<bool>(jobsStartPaused),
      'jobsMaxRetryAttempts': serializer.toJson<int>(jobsMaxRetryAttempts),
      'jobsRetryDelaySeconds': serializer.toJson<int>(jobsRetryDelaySeconds),
      'jobsHistoryRetentionDays': serializer.toJson<int>(
        jobsHistoryRetentionDays,
      ),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SettingsTableData copyWith({
    int? id,
    int? appPort,
    String? bindHost,
    bool? enableBackgroundMode,
    bool? startWithOs,
    bool? allowLanAccess,
    bool? autoStartServer,
    bool? jobsStartPaused,
    int? jobsMaxRetryAttempts,
    int? jobsRetryDelaySeconds,
    int? jobsHistoryRetentionDays,
    DateTime? updatedAt,
  }) => SettingsTableData(
    id: id ?? this.id,
    appPort: appPort ?? this.appPort,
    bindHost: bindHost ?? this.bindHost,
    enableBackgroundMode: enableBackgroundMode ?? this.enableBackgroundMode,
    startWithOs: startWithOs ?? this.startWithOs,
    allowLanAccess: allowLanAccess ?? this.allowLanAccess,
    autoStartServer: autoStartServer ?? this.autoStartServer,
    jobsStartPaused: jobsStartPaused ?? this.jobsStartPaused,
    jobsMaxRetryAttempts: jobsMaxRetryAttempts ?? this.jobsMaxRetryAttempts,
    jobsRetryDelaySeconds: jobsRetryDelaySeconds ?? this.jobsRetryDelaySeconds,
    jobsHistoryRetentionDays:
        jobsHistoryRetentionDays ?? this.jobsHistoryRetentionDays,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SettingsTableData copyWithCompanion(SettingsTableCompanion data) {
    return SettingsTableData(
      id: data.id.present ? data.id.value : this.id,
      appPort: data.appPort.present ? data.appPort.value : this.appPort,
      bindHost: data.bindHost.present ? data.bindHost.value : this.bindHost,
      enableBackgroundMode: data.enableBackgroundMode.present
          ? data.enableBackgroundMode.value
          : this.enableBackgroundMode,
      startWithOs: data.startWithOs.present
          ? data.startWithOs.value
          : this.startWithOs,
      allowLanAccess: data.allowLanAccess.present
          ? data.allowLanAccess.value
          : this.allowLanAccess,
      autoStartServer: data.autoStartServer.present
          ? data.autoStartServer.value
          : this.autoStartServer,
      jobsStartPaused: data.jobsStartPaused.present
          ? data.jobsStartPaused.value
          : this.jobsStartPaused,
      jobsMaxRetryAttempts: data.jobsMaxRetryAttempts.present
          ? data.jobsMaxRetryAttempts.value
          : this.jobsMaxRetryAttempts,
      jobsRetryDelaySeconds: data.jobsRetryDelaySeconds.present
          ? data.jobsRetryDelaySeconds.value
          : this.jobsRetryDelaySeconds,
      jobsHistoryRetentionDays: data.jobsHistoryRetentionDays.present
          ? data.jobsHistoryRetentionDays.value
          : this.jobsHistoryRetentionDays,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingsTableData(')
          ..write('id: $id, ')
          ..write('appPort: $appPort, ')
          ..write('bindHost: $bindHost, ')
          ..write('enableBackgroundMode: $enableBackgroundMode, ')
          ..write('startWithOs: $startWithOs, ')
          ..write('allowLanAccess: $allowLanAccess, ')
          ..write('autoStartServer: $autoStartServer, ')
          ..write('jobsStartPaused: $jobsStartPaused, ')
          ..write('jobsMaxRetryAttempts: $jobsMaxRetryAttempts, ')
          ..write('jobsRetryDelaySeconds: $jobsRetryDelaySeconds, ')
          ..write('jobsHistoryRetentionDays: $jobsHistoryRetentionDays, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    appPort,
    bindHost,
    enableBackgroundMode,
    startWithOs,
    allowLanAccess,
    autoStartServer,
    jobsStartPaused,
    jobsMaxRetryAttempts,
    jobsRetryDelaySeconds,
    jobsHistoryRetentionDays,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsTableData &&
          other.id == this.id &&
          other.appPort == this.appPort &&
          other.bindHost == this.bindHost &&
          other.enableBackgroundMode == this.enableBackgroundMode &&
          other.startWithOs == this.startWithOs &&
          other.allowLanAccess == this.allowLanAccess &&
          other.autoStartServer == this.autoStartServer &&
          other.jobsStartPaused == this.jobsStartPaused &&
          other.jobsMaxRetryAttempts == this.jobsMaxRetryAttempts &&
          other.jobsRetryDelaySeconds == this.jobsRetryDelaySeconds &&
          other.jobsHistoryRetentionDays == this.jobsHistoryRetentionDays &&
          other.updatedAt == this.updatedAt);
}

class SettingsTableCompanion extends UpdateCompanion<SettingsTableData> {
  final Value<int> id;
  final Value<int> appPort;
  final Value<String> bindHost;
  final Value<bool> enableBackgroundMode;
  final Value<bool> startWithOs;
  final Value<bool> allowLanAccess;
  final Value<bool> autoStartServer;
  final Value<bool> jobsStartPaused;
  final Value<int> jobsMaxRetryAttempts;
  final Value<int> jobsRetryDelaySeconds;
  final Value<int> jobsHistoryRetentionDays;
  final Value<DateTime> updatedAt;
  const SettingsTableCompanion({
    this.id = const Value.absent(),
    this.appPort = const Value.absent(),
    this.bindHost = const Value.absent(),
    this.enableBackgroundMode = const Value.absent(),
    this.startWithOs = const Value.absent(),
    this.allowLanAccess = const Value.absent(),
    this.autoStartServer = const Value.absent(),
    this.jobsStartPaused = const Value.absent(),
    this.jobsMaxRetryAttempts = const Value.absent(),
    this.jobsRetryDelaySeconds = const Value.absent(),
    this.jobsHistoryRetentionDays = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SettingsTableCompanion.insert({
    this.id = const Value.absent(),
    this.appPort = const Value.absent(),
    this.bindHost = const Value.absent(),
    this.enableBackgroundMode = const Value.absent(),
    this.startWithOs = const Value.absent(),
    this.allowLanAccess = const Value.absent(),
    this.autoStartServer = const Value.absent(),
    this.jobsStartPaused = const Value.absent(),
    this.jobsMaxRetryAttempts = const Value.absent(),
    this.jobsRetryDelaySeconds = const Value.absent(),
    this.jobsHistoryRetentionDays = const Value.absent(),
    required DateTime updatedAt,
  }) : updatedAt = Value(updatedAt);
  static Insertable<SettingsTableData> custom({
    Expression<int>? id,
    Expression<int>? appPort,
    Expression<String>? bindHost,
    Expression<bool>? enableBackgroundMode,
    Expression<bool>? startWithOs,
    Expression<bool>? allowLanAccess,
    Expression<bool>? autoStartServer,
    Expression<bool>? jobsStartPaused,
    Expression<int>? jobsMaxRetryAttempts,
    Expression<int>? jobsRetryDelaySeconds,
    Expression<int>? jobsHistoryRetentionDays,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (appPort != null) 'app_port': appPort,
      if (bindHost != null) 'bind_host': bindHost,
      if (enableBackgroundMode != null)
        'enable_background_mode': enableBackgroundMode,
      if (startWithOs != null) 'start_with_os': startWithOs,
      if (allowLanAccess != null) 'allow_lan_access': allowLanAccess,
      if (autoStartServer != null) 'auto_start_server': autoStartServer,
      if (jobsStartPaused != null) 'jobs_start_paused': jobsStartPaused,
      if (jobsMaxRetryAttempts != null)
        'jobs_max_retry_attempts': jobsMaxRetryAttempts,
      if (jobsRetryDelaySeconds != null)
        'jobs_retry_delay_seconds': jobsRetryDelaySeconds,
      if (jobsHistoryRetentionDays != null)
        'jobs_history_retention_days': jobsHistoryRetentionDays,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SettingsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? appPort,
    Value<String>? bindHost,
    Value<bool>? enableBackgroundMode,
    Value<bool>? startWithOs,
    Value<bool>? allowLanAccess,
    Value<bool>? autoStartServer,
    Value<bool>? jobsStartPaused,
    Value<int>? jobsMaxRetryAttempts,
    Value<int>? jobsRetryDelaySeconds,
    Value<int>? jobsHistoryRetentionDays,
    Value<DateTime>? updatedAt,
  }) {
    return SettingsTableCompanion(
      id: id ?? this.id,
      appPort: appPort ?? this.appPort,
      bindHost: bindHost ?? this.bindHost,
      enableBackgroundMode: enableBackgroundMode ?? this.enableBackgroundMode,
      startWithOs: startWithOs ?? this.startWithOs,
      allowLanAccess: allowLanAccess ?? this.allowLanAccess,
      autoStartServer: autoStartServer ?? this.autoStartServer,
      jobsStartPaused: jobsStartPaused ?? this.jobsStartPaused,
      jobsMaxRetryAttempts: jobsMaxRetryAttempts ?? this.jobsMaxRetryAttempts,
      jobsRetryDelaySeconds:
          jobsRetryDelaySeconds ?? this.jobsRetryDelaySeconds,
      jobsHistoryRetentionDays:
          jobsHistoryRetentionDays ?? this.jobsHistoryRetentionDays,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (appPort.present) {
      map['app_port'] = Variable<int>(appPort.value);
    }
    if (bindHost.present) {
      map['bind_host'] = Variable<String>(bindHost.value);
    }
    if (enableBackgroundMode.present) {
      map['enable_background_mode'] = Variable<bool>(
        enableBackgroundMode.value,
      );
    }
    if (startWithOs.present) {
      map['start_with_os'] = Variable<bool>(startWithOs.value);
    }
    if (allowLanAccess.present) {
      map['allow_lan_access'] = Variable<bool>(allowLanAccess.value);
    }
    if (autoStartServer.present) {
      map['auto_start_server'] = Variable<bool>(autoStartServer.value);
    }
    if (jobsStartPaused.present) {
      map['jobs_start_paused'] = Variable<bool>(jobsStartPaused.value);
    }
    if (jobsMaxRetryAttempts.present) {
      map['jobs_max_retry_attempts'] = Variable<int>(
        jobsMaxRetryAttempts.value,
      );
    }
    if (jobsRetryDelaySeconds.present) {
      map['jobs_retry_delay_seconds'] = Variable<int>(
        jobsRetryDelaySeconds.value,
      );
    }
    if (jobsHistoryRetentionDays.present) {
      map['jobs_history_retention_days'] = Variable<int>(
        jobsHistoryRetentionDays.value,
      );
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('appPort: $appPort, ')
          ..write('bindHost: $bindHost, ')
          ..write('enableBackgroundMode: $enableBackgroundMode, ')
          ..write('startWithOs: $startWithOs, ')
          ..write('allowLanAccess: $allowLanAccess, ')
          ..write('autoStartServer: $autoStartServer, ')
          ..write('jobsStartPaused: $jobsStartPaused, ')
          ..write('jobsMaxRetryAttempts: $jobsMaxRetryAttempts, ')
          ..write('jobsRetryDelaySeconds: $jobsRetryDelaySeconds, ')
          ..write('jobsHistoryRetentionDays: $jobsHistoryRetentionDays, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PrintersTableTable extends PrintersTable
    with TableInfo<$PrintersTableTable, PrintersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrintersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _uniqueKeyMeta = const VerificationMeta(
    'uniqueKey',
  );
  @override
  late final GeneratedColumn<String> uniqueKey = GeneratedColumn<String>(
    'unique_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _connectionTypeMeta = const VerificationMeta(
    'connectionType',
  );
  @override
  late final GeneratedColumn<String> connectionType = GeneratedColumn<String>(
    'connection_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system_spooler'),
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tcpHostMeta = const VerificationMeta(
    'tcpHost',
  );
  @override
  late final GeneratedColumn<String> tcpHost = GeneratedColumn<String>(
    'tcp_host',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tcpPortMeta = const VerificationMeta(
    'tcpPort',
  );
  @override
  late final GeneratedColumn<int> tcpPort = GeneratedColumn<int>(
    'tcp_port',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tcpConnectTimeoutMsMeta =
      const VerificationMeta('tcpConnectTimeoutMs');
  @override
  late final GeneratedColumn<int> tcpConnectTimeoutMs = GeneratedColumn<int>(
    'tcp_connect_timeout_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tcpWriteTimeoutMsMeta = const VerificationMeta(
    'tcpWriteTimeoutMs',
  );
  @override
  late final GeneratedColumn<int> tcpWriteTimeoutMs = GeneratedColumn<int>(
    'tcp_write_timeout_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tcpReadTimeoutMsMeta = const VerificationMeta(
    'tcpReadTimeoutMs',
  );
  @override
  late final GeneratedColumn<int> tcpReadTimeoutMs = GeneratedColumn<int>(
    'tcp_read_timeout_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tcpAutoReconnectMeta = const VerificationMeta(
    'tcpAutoReconnect',
  );
  @override
  late final GeneratedColumn<bool> tcpAutoReconnect = GeneratedColumn<bool>(
    'tcp_auto_reconnect',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("tcp_auto_reconnect" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _tcpReconnectDelayMsMeta =
      const VerificationMeta('tcpReconnectDelayMs');
  @override
  late final GeneratedColumn<int> tcpReconnectDelayMs = GeneratedColumn<int>(
    'tcp_reconnect_delay_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tcpEncodingMeta = const VerificationMeta(
    'tcpEncoding',
  );
  @override
  late final GeneratedColumn<String> tcpEncoding = GeneratedColumn<String>(
    'tcp_encoding',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tcpCodePageMeta = const VerificationMeta(
    'tcpCodePage',
  );
  @override
  late final GeneratedColumn<String> tcpCodePage = GeneratedColumn<String>(
    'tcp_code_page',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tcpLineEndingMeta = const VerificationMeta(
    'tcpLineEnding',
  );
  @override
  late final GeneratedColumn<String> tcpLineEnding = GeneratedColumn<String>(
    'tcp_line_ending',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tcpKeepAliveMeta = const VerificationMeta(
    'tcpKeepAlive',
  );
  @override
  late final GeneratedColumn<bool> tcpKeepAlive = GeneratedColumn<bool>(
    'tcp_keep_alive',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("tcp_keep_alive" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _tcpNoDelayMeta = const VerificationMeta(
    'tcpNoDelay',
  );
  @override
  late final GeneratedColumn<bool> tcpNoDelay = GeneratedColumn<bool>(
    'tcp_no_delay',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("tcp_no_delay" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _tcpLingerSecondsMeta = const VerificationMeta(
    'tcpLingerSeconds',
  );
  @override
  late final GeneratedColumn<int> tcpLingerSeconds = GeneratedColumn<int>(
    'tcp_linger_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _systemPrinterNameMeta = const VerificationMeta(
    'systemPrinterName',
  );
  @override
  late final GeneratedColumn<String> systemPrinterName =
      GeneratedColumn<String>(
        'system_printer_name',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _systemPaperSizeMeta = const VerificationMeta(
    'systemPaperSize',
  );
  @override
  late final GeneratedColumn<String> systemPaperSize = GeneratedColumn<String>(
    'system_paper_size',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _systemDefaultCopiesMeta =
      const VerificationMeta('systemDefaultCopies');
  @override
  late final GeneratedColumn<int> systemDefaultCopies = GeneratedColumn<int>(
    'system_default_copies',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _systemColorEnabledMeta =
      const VerificationMeta('systemColorEnabled');
  @override
  late final GeneratedColumn<bool> systemColorEnabled = GeneratedColumn<bool>(
    'system_color_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("system_color_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _systemDuplexModeMeta = const VerificationMeta(
    'systemDuplexMode',
  );
  @override
  late final GeneratedColumn<String> systemDuplexMode = GeneratedColumn<String>(
    'system_duplex_mode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _systemOrientationMeta = const VerificationMeta(
    'systemOrientation',
  );
  @override
  late final GeneratedColumn<String> systemOrientation =
      GeneratedColumn<String>(
        'system_orientation',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _systemJobTimeoutMsMeta =
      const VerificationMeta('systemJobTimeoutMs');
  @override
  late final GeneratedColumn<int> systemJobTimeoutMs = GeneratedColumn<int>(
    'system_job_timeout_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _systemNotesMeta = const VerificationMeta(
    'systemNotes',
  );
  @override
  late final GeneratedColumn<String> systemNotes = GeneratedColumn<String>(
    'system_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _systemDriverNameMeta = const VerificationMeta(
    'systemDriverName',
  );
  @override
  late final GeneratedColumn<String> systemDriverName = GeneratedColumn<String>(
    'system_driver_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _systemQueueNameMeta = const VerificationMeta(
    'systemQueueName',
  );
  @override
  late final GeneratedColumn<String> systemQueueName = GeneratedColumn<String>(
    'system_queue_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _systemSpoolFormatMeta = const VerificationMeta(
    'systemSpoolFormat',
  );
  @override
  late final GeneratedColumn<String> systemSpoolFormat =
      GeneratedColumn<String>(
        'system_spool_format',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _systemUseRawSpoolMeta = const VerificationMeta(
    'systemUseRawSpool',
  );
  @override
  late final GeneratedColumn<bool> systemUseRawSpool = GeneratedColumn<bool>(
    'system_use_raw_spool',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("system_use_raw_spool" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _usbVendorIdMeta = const VerificationMeta(
    'usbVendorId',
  );
  @override
  late final GeneratedColumn<String> usbVendorId = GeneratedColumn<String>(
    'usb_vendor_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usbProductIdMeta = const VerificationMeta(
    'usbProductId',
  );
  @override
  late final GeneratedColumn<String> usbProductId = GeneratedColumn<String>(
    'usb_product_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usbSerialNumberMeta = const VerificationMeta(
    'usbSerialNumber',
  );
  @override
  late final GeneratedColumn<String> usbSerialNumber = GeneratedColumn<String>(
    'usb_serial_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usbInterfaceNumberMeta =
      const VerificationMeta('usbInterfaceNumber');
  @override
  late final GeneratedColumn<int> usbInterfaceNumber = GeneratedColumn<int>(
    'usb_interface_number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usbOutEndpointMeta = const VerificationMeta(
    'usbOutEndpoint',
  );
  @override
  late final GeneratedColumn<int> usbOutEndpoint = GeneratedColumn<int>(
    'usb_out_endpoint',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usbInEndpointMeta = const VerificationMeta(
    'usbInEndpoint',
  );
  @override
  late final GeneratedColumn<int> usbInEndpoint = GeneratedColumn<int>(
    'usb_in_endpoint',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usbTimeoutMsMeta = const VerificationMeta(
    'usbTimeoutMs',
  );
  @override
  late final GeneratedColumn<int> usbTimeoutMs = GeneratedColumn<int>(
    'usb_timeout_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usbEncodingMeta = const VerificationMeta(
    'usbEncoding',
  );
  @override
  late final GeneratedColumn<String> usbEncoding = GeneratedColumn<String>(
    'usb_encoding',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usbCodePageMeta = const VerificationMeta(
    'usbCodePage',
  );
  @override
  late final GeneratedColumn<String> usbCodePage = GeneratedColumn<String>(
    'usb_code_page',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usbCharacterTableMeta = const VerificationMeta(
    'usbCharacterTable',
  );
  @override
  late final GeneratedColumn<String> usbCharacterTable =
      GeneratedColumn<String>(
        'usb_character_table',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _usbAutoCutEnabledMeta = const VerificationMeta(
    'usbAutoCutEnabled',
  );
  @override
  late final GeneratedColumn<bool> usbAutoCutEnabled = GeneratedColumn<bool>(
    'usb_auto_cut_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("usb_auto_cut_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _usbCutModeMeta = const VerificationMeta(
    'usbCutMode',
  );
  @override
  late final GeneratedColumn<String> usbCutMode = GeneratedColumn<String>(
    'usb_cut_mode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usbCashDrawerEnabledMeta =
      const VerificationMeta('usbCashDrawerEnabled');
  @override
  late final GeneratedColumn<bool> usbCashDrawerEnabled = GeneratedColumn<bool>(
    'usb_cash_drawer_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("usb_cash_drawer_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _usbDrawerPinMeta = const VerificationMeta(
    'usbDrawerPin',
  );
  @override
  late final GeneratedColumn<int> usbDrawerPin = GeneratedColumn<int>(
    'usb_drawer_pin',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usbStatusMonitoringEnabledMeta =
      const VerificationMeta('usbStatusMonitoringEnabled');
  @override
  late final GeneratedColumn<bool> usbStatusMonitoringEnabled =
      GeneratedColumn<bool>(
        'usb_status_monitoring_enabled',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("usb_status_monitoring_enabled" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _usbManufacturerMeta = const VerificationMeta(
    'usbManufacturer',
  );
  @override
  late final GeneratedColumn<String> usbManufacturer = GeneratedColumn<String>(
    'usb_manufacturer',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usbProductNameMeta = const VerificationMeta(
    'usbProductName',
  );
  @override
  late final GeneratedColumn<String> usbProductName = GeneratedColumn<String>(
    'usb_product_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usbAlternateSettingMeta =
      const VerificationMeta('usbAlternateSetting');
  @override
  late final GeneratedColumn<int> usbAlternateSetting = GeneratedColumn<int>(
    'usb_alternate_setting',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usbPacketDelayMsMeta = const VerificationMeta(
    'usbPacketDelayMs',
  );
  @override
  late final GeneratedColumn<int> usbPacketDelayMs = GeneratedColumn<int>(
    'usb_packet_delay_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rawGraphicsModeMeta = const VerificationMeta(
    'rawGraphicsMode',
  );
  @override
  late final GeneratedColumn<String> rawGraphicsMode = GeneratedColumn<String>(
    'raw_graphics_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('modern'),
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _lastStatusMeta = const VerificationMeta(
    'lastStatus',
  );
  @override
  late final GeneratedColumn<String> lastStatus = GeneratedColumn<String>(
    'last_status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastStatusKeyMeta = const VerificationMeta(
    'lastStatusKey',
  );
  @override
  late final GeneratedColumn<String> lastStatusKey = GeneratedColumn<String>(
    'last_status_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastStatusMessageMeta = const VerificationMeta(
    'lastStatusMessage',
  );
  @override
  late final GeneratedColumn<String> lastStatusMessage =
      GeneratedColumn<String>(
        'last_status_message',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uniqueKey,
    name,
    description,
    connectionType,
    address,
    tcpHost,
    tcpPort,
    tcpConnectTimeoutMs,
    tcpWriteTimeoutMs,
    tcpReadTimeoutMs,
    tcpAutoReconnect,
    tcpReconnectDelayMs,
    tcpEncoding,
    tcpCodePage,
    tcpLineEnding,
    tcpKeepAlive,
    tcpNoDelay,
    tcpLingerSeconds,
    systemPrinterName,
    systemPaperSize,
    systemDefaultCopies,
    systemColorEnabled,
    systemDuplexMode,
    systemOrientation,
    systemJobTimeoutMs,
    systemNotes,
    systemDriverName,
    systemQueueName,
    systemSpoolFormat,
    systemUseRawSpool,
    usbVendorId,
    usbProductId,
    usbSerialNumber,
    usbInterfaceNumber,
    usbOutEndpoint,
    usbInEndpoint,
    usbTimeoutMs,
    usbEncoding,
    usbCodePage,
    usbCharacterTable,
    usbAutoCutEnabled,
    usbCutMode,
    usbCashDrawerEnabled,
    usbDrawerPin,
    usbStatusMonitoringEnabled,
    usbManufacturer,
    usbProductName,
    usbAlternateSetting,
    usbPacketDelayMs,
    rawGraphicsMode,
    isEnabled,
    lastStatus,
    lastStatusKey,
    lastStatusMessage,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'printers_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PrintersTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('unique_key')) {
      context.handle(
        _uniqueKeyMeta,
        uniqueKey.isAcceptableOrUnknown(data['unique_key']!, _uniqueKeyMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('connection_type')) {
      context.handle(
        _connectionTypeMeta,
        connectionType.isAcceptableOrUnknown(
          data['connection_type']!,
          _connectionTypeMeta,
        ),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('tcp_host')) {
      context.handle(
        _tcpHostMeta,
        tcpHost.isAcceptableOrUnknown(data['tcp_host']!, _tcpHostMeta),
      );
    }
    if (data.containsKey('tcp_port')) {
      context.handle(
        _tcpPortMeta,
        tcpPort.isAcceptableOrUnknown(data['tcp_port']!, _tcpPortMeta),
      );
    }
    if (data.containsKey('tcp_connect_timeout_ms')) {
      context.handle(
        _tcpConnectTimeoutMsMeta,
        tcpConnectTimeoutMs.isAcceptableOrUnknown(
          data['tcp_connect_timeout_ms']!,
          _tcpConnectTimeoutMsMeta,
        ),
      );
    }
    if (data.containsKey('tcp_write_timeout_ms')) {
      context.handle(
        _tcpWriteTimeoutMsMeta,
        tcpWriteTimeoutMs.isAcceptableOrUnknown(
          data['tcp_write_timeout_ms']!,
          _tcpWriteTimeoutMsMeta,
        ),
      );
    }
    if (data.containsKey('tcp_read_timeout_ms')) {
      context.handle(
        _tcpReadTimeoutMsMeta,
        tcpReadTimeoutMs.isAcceptableOrUnknown(
          data['tcp_read_timeout_ms']!,
          _tcpReadTimeoutMsMeta,
        ),
      );
    }
    if (data.containsKey('tcp_auto_reconnect')) {
      context.handle(
        _tcpAutoReconnectMeta,
        tcpAutoReconnect.isAcceptableOrUnknown(
          data['tcp_auto_reconnect']!,
          _tcpAutoReconnectMeta,
        ),
      );
    }
    if (data.containsKey('tcp_reconnect_delay_ms')) {
      context.handle(
        _tcpReconnectDelayMsMeta,
        tcpReconnectDelayMs.isAcceptableOrUnknown(
          data['tcp_reconnect_delay_ms']!,
          _tcpReconnectDelayMsMeta,
        ),
      );
    }
    if (data.containsKey('tcp_encoding')) {
      context.handle(
        _tcpEncodingMeta,
        tcpEncoding.isAcceptableOrUnknown(
          data['tcp_encoding']!,
          _tcpEncodingMeta,
        ),
      );
    }
    if (data.containsKey('tcp_code_page')) {
      context.handle(
        _tcpCodePageMeta,
        tcpCodePage.isAcceptableOrUnknown(
          data['tcp_code_page']!,
          _tcpCodePageMeta,
        ),
      );
    }
    if (data.containsKey('tcp_line_ending')) {
      context.handle(
        _tcpLineEndingMeta,
        tcpLineEnding.isAcceptableOrUnknown(
          data['tcp_line_ending']!,
          _tcpLineEndingMeta,
        ),
      );
    }
    if (data.containsKey('tcp_keep_alive')) {
      context.handle(
        _tcpKeepAliveMeta,
        tcpKeepAlive.isAcceptableOrUnknown(
          data['tcp_keep_alive']!,
          _tcpKeepAliveMeta,
        ),
      );
    }
    if (data.containsKey('tcp_no_delay')) {
      context.handle(
        _tcpNoDelayMeta,
        tcpNoDelay.isAcceptableOrUnknown(
          data['tcp_no_delay']!,
          _tcpNoDelayMeta,
        ),
      );
    }
    if (data.containsKey('tcp_linger_seconds')) {
      context.handle(
        _tcpLingerSecondsMeta,
        tcpLingerSeconds.isAcceptableOrUnknown(
          data['tcp_linger_seconds']!,
          _tcpLingerSecondsMeta,
        ),
      );
    }
    if (data.containsKey('system_printer_name')) {
      context.handle(
        _systemPrinterNameMeta,
        systemPrinterName.isAcceptableOrUnknown(
          data['system_printer_name']!,
          _systemPrinterNameMeta,
        ),
      );
    }
    if (data.containsKey('system_paper_size')) {
      context.handle(
        _systemPaperSizeMeta,
        systemPaperSize.isAcceptableOrUnknown(
          data['system_paper_size']!,
          _systemPaperSizeMeta,
        ),
      );
    }
    if (data.containsKey('system_default_copies')) {
      context.handle(
        _systemDefaultCopiesMeta,
        systemDefaultCopies.isAcceptableOrUnknown(
          data['system_default_copies']!,
          _systemDefaultCopiesMeta,
        ),
      );
    }
    if (data.containsKey('system_color_enabled')) {
      context.handle(
        _systemColorEnabledMeta,
        systemColorEnabled.isAcceptableOrUnknown(
          data['system_color_enabled']!,
          _systemColorEnabledMeta,
        ),
      );
    }
    if (data.containsKey('system_duplex_mode')) {
      context.handle(
        _systemDuplexModeMeta,
        systemDuplexMode.isAcceptableOrUnknown(
          data['system_duplex_mode']!,
          _systemDuplexModeMeta,
        ),
      );
    }
    if (data.containsKey('system_orientation')) {
      context.handle(
        _systemOrientationMeta,
        systemOrientation.isAcceptableOrUnknown(
          data['system_orientation']!,
          _systemOrientationMeta,
        ),
      );
    }
    if (data.containsKey('system_job_timeout_ms')) {
      context.handle(
        _systemJobTimeoutMsMeta,
        systemJobTimeoutMs.isAcceptableOrUnknown(
          data['system_job_timeout_ms']!,
          _systemJobTimeoutMsMeta,
        ),
      );
    }
    if (data.containsKey('system_notes')) {
      context.handle(
        _systemNotesMeta,
        systemNotes.isAcceptableOrUnknown(
          data['system_notes']!,
          _systemNotesMeta,
        ),
      );
    }
    if (data.containsKey('system_driver_name')) {
      context.handle(
        _systemDriverNameMeta,
        systemDriverName.isAcceptableOrUnknown(
          data['system_driver_name']!,
          _systemDriverNameMeta,
        ),
      );
    }
    if (data.containsKey('system_queue_name')) {
      context.handle(
        _systemQueueNameMeta,
        systemQueueName.isAcceptableOrUnknown(
          data['system_queue_name']!,
          _systemQueueNameMeta,
        ),
      );
    }
    if (data.containsKey('system_spool_format')) {
      context.handle(
        _systemSpoolFormatMeta,
        systemSpoolFormat.isAcceptableOrUnknown(
          data['system_spool_format']!,
          _systemSpoolFormatMeta,
        ),
      );
    }
    if (data.containsKey('system_use_raw_spool')) {
      context.handle(
        _systemUseRawSpoolMeta,
        systemUseRawSpool.isAcceptableOrUnknown(
          data['system_use_raw_spool']!,
          _systemUseRawSpoolMeta,
        ),
      );
    }
    if (data.containsKey('usb_vendor_id')) {
      context.handle(
        _usbVendorIdMeta,
        usbVendorId.isAcceptableOrUnknown(
          data['usb_vendor_id']!,
          _usbVendorIdMeta,
        ),
      );
    }
    if (data.containsKey('usb_product_id')) {
      context.handle(
        _usbProductIdMeta,
        usbProductId.isAcceptableOrUnknown(
          data['usb_product_id']!,
          _usbProductIdMeta,
        ),
      );
    }
    if (data.containsKey('usb_serial_number')) {
      context.handle(
        _usbSerialNumberMeta,
        usbSerialNumber.isAcceptableOrUnknown(
          data['usb_serial_number']!,
          _usbSerialNumberMeta,
        ),
      );
    }
    if (data.containsKey('usb_interface_number')) {
      context.handle(
        _usbInterfaceNumberMeta,
        usbInterfaceNumber.isAcceptableOrUnknown(
          data['usb_interface_number']!,
          _usbInterfaceNumberMeta,
        ),
      );
    }
    if (data.containsKey('usb_out_endpoint')) {
      context.handle(
        _usbOutEndpointMeta,
        usbOutEndpoint.isAcceptableOrUnknown(
          data['usb_out_endpoint']!,
          _usbOutEndpointMeta,
        ),
      );
    }
    if (data.containsKey('usb_in_endpoint')) {
      context.handle(
        _usbInEndpointMeta,
        usbInEndpoint.isAcceptableOrUnknown(
          data['usb_in_endpoint']!,
          _usbInEndpointMeta,
        ),
      );
    }
    if (data.containsKey('usb_timeout_ms')) {
      context.handle(
        _usbTimeoutMsMeta,
        usbTimeoutMs.isAcceptableOrUnknown(
          data['usb_timeout_ms']!,
          _usbTimeoutMsMeta,
        ),
      );
    }
    if (data.containsKey('usb_encoding')) {
      context.handle(
        _usbEncodingMeta,
        usbEncoding.isAcceptableOrUnknown(
          data['usb_encoding']!,
          _usbEncodingMeta,
        ),
      );
    }
    if (data.containsKey('usb_code_page')) {
      context.handle(
        _usbCodePageMeta,
        usbCodePage.isAcceptableOrUnknown(
          data['usb_code_page']!,
          _usbCodePageMeta,
        ),
      );
    }
    if (data.containsKey('usb_character_table')) {
      context.handle(
        _usbCharacterTableMeta,
        usbCharacterTable.isAcceptableOrUnknown(
          data['usb_character_table']!,
          _usbCharacterTableMeta,
        ),
      );
    }
    if (data.containsKey('usb_auto_cut_enabled')) {
      context.handle(
        _usbAutoCutEnabledMeta,
        usbAutoCutEnabled.isAcceptableOrUnknown(
          data['usb_auto_cut_enabled']!,
          _usbAutoCutEnabledMeta,
        ),
      );
    }
    if (data.containsKey('usb_cut_mode')) {
      context.handle(
        _usbCutModeMeta,
        usbCutMode.isAcceptableOrUnknown(
          data['usb_cut_mode']!,
          _usbCutModeMeta,
        ),
      );
    }
    if (data.containsKey('usb_cash_drawer_enabled')) {
      context.handle(
        _usbCashDrawerEnabledMeta,
        usbCashDrawerEnabled.isAcceptableOrUnknown(
          data['usb_cash_drawer_enabled']!,
          _usbCashDrawerEnabledMeta,
        ),
      );
    }
    if (data.containsKey('usb_drawer_pin')) {
      context.handle(
        _usbDrawerPinMeta,
        usbDrawerPin.isAcceptableOrUnknown(
          data['usb_drawer_pin']!,
          _usbDrawerPinMeta,
        ),
      );
    }
    if (data.containsKey('usb_status_monitoring_enabled')) {
      context.handle(
        _usbStatusMonitoringEnabledMeta,
        usbStatusMonitoringEnabled.isAcceptableOrUnknown(
          data['usb_status_monitoring_enabled']!,
          _usbStatusMonitoringEnabledMeta,
        ),
      );
    }
    if (data.containsKey('usb_manufacturer')) {
      context.handle(
        _usbManufacturerMeta,
        usbManufacturer.isAcceptableOrUnknown(
          data['usb_manufacturer']!,
          _usbManufacturerMeta,
        ),
      );
    }
    if (data.containsKey('usb_product_name')) {
      context.handle(
        _usbProductNameMeta,
        usbProductName.isAcceptableOrUnknown(
          data['usb_product_name']!,
          _usbProductNameMeta,
        ),
      );
    }
    if (data.containsKey('usb_alternate_setting')) {
      context.handle(
        _usbAlternateSettingMeta,
        usbAlternateSetting.isAcceptableOrUnknown(
          data['usb_alternate_setting']!,
          _usbAlternateSettingMeta,
        ),
      );
    }
    if (data.containsKey('usb_packet_delay_ms')) {
      context.handle(
        _usbPacketDelayMsMeta,
        usbPacketDelayMs.isAcceptableOrUnknown(
          data['usb_packet_delay_ms']!,
          _usbPacketDelayMsMeta,
        ),
      );
    }
    if (data.containsKey('raw_graphics_mode')) {
      context.handle(
        _rawGraphicsModeMeta,
        rawGraphicsMode.isAcceptableOrUnknown(
          data['raw_graphics_mode']!,
          _rawGraphicsModeMeta,
        ),
      );
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('last_status')) {
      context.handle(
        _lastStatusMeta,
        lastStatus.isAcceptableOrUnknown(data['last_status']!, _lastStatusMeta),
      );
    }
    if (data.containsKey('last_status_key')) {
      context.handle(
        _lastStatusKeyMeta,
        lastStatusKey.isAcceptableOrUnknown(
          data['last_status_key']!,
          _lastStatusKeyMeta,
        ),
      );
    }
    if (data.containsKey('last_status_message')) {
      context.handle(
        _lastStatusMessageMeta,
        lastStatusMessage.isAcceptableOrUnknown(
          data['last_status_message']!,
          _lastStatusMessageMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PrintersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrintersTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      uniqueKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unique_key'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      connectionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}connection_type'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      tcpHost: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tcp_host'],
      ),
      tcpPort: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tcp_port'],
      ),
      tcpConnectTimeoutMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tcp_connect_timeout_ms'],
      ),
      tcpWriteTimeoutMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tcp_write_timeout_ms'],
      ),
      tcpReadTimeoutMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tcp_read_timeout_ms'],
      ),
      tcpAutoReconnect: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}tcp_auto_reconnect'],
      )!,
      tcpReconnectDelayMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tcp_reconnect_delay_ms'],
      ),
      tcpEncoding: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tcp_encoding'],
      ),
      tcpCodePage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tcp_code_page'],
      ),
      tcpLineEnding: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tcp_line_ending'],
      ),
      tcpKeepAlive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}tcp_keep_alive'],
      )!,
      tcpNoDelay: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}tcp_no_delay'],
      )!,
      tcpLingerSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tcp_linger_seconds'],
      ),
      systemPrinterName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}system_printer_name'],
      ),
      systemPaperSize: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}system_paper_size'],
      ),
      systemDefaultCopies: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}system_default_copies'],
      )!,
      systemColorEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}system_color_enabled'],
      )!,
      systemDuplexMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}system_duplex_mode'],
      ),
      systemOrientation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}system_orientation'],
      ),
      systemJobTimeoutMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}system_job_timeout_ms'],
      ),
      systemNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}system_notes'],
      ),
      systemDriverName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}system_driver_name'],
      ),
      systemQueueName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}system_queue_name'],
      ),
      systemSpoolFormat: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}system_spool_format'],
      ),
      systemUseRawSpool: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}system_use_raw_spool'],
      )!,
      usbVendorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usb_vendor_id'],
      ),
      usbProductId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usb_product_id'],
      ),
      usbSerialNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usb_serial_number'],
      ),
      usbInterfaceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usb_interface_number'],
      ),
      usbOutEndpoint: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usb_out_endpoint'],
      ),
      usbInEndpoint: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usb_in_endpoint'],
      ),
      usbTimeoutMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usb_timeout_ms'],
      ),
      usbEncoding: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usb_encoding'],
      ),
      usbCodePage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usb_code_page'],
      ),
      usbCharacterTable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usb_character_table'],
      ),
      usbAutoCutEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}usb_auto_cut_enabled'],
      )!,
      usbCutMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usb_cut_mode'],
      ),
      usbCashDrawerEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}usb_cash_drawer_enabled'],
      )!,
      usbDrawerPin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usb_drawer_pin'],
      ),
      usbStatusMonitoringEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}usb_status_monitoring_enabled'],
      )!,
      usbManufacturer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usb_manufacturer'],
      ),
      usbProductName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usb_product_name'],
      ),
      usbAlternateSetting: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usb_alternate_setting'],
      ),
      usbPacketDelayMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usb_packet_delay_ms'],
      ),
      rawGraphicsMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_graphics_mode'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      lastStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_status'],
      ),
      lastStatusKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_status_key'],
      ),
      lastStatusMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_status_message'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PrintersTableTable createAlias(String alias) {
    return $PrintersTableTable(attachedDatabase, alias);
  }
}

class PrintersTableData extends DataClass
    implements Insertable<PrintersTableData> {
  final String id;
  final String uniqueKey;
  final String name;
  final String? description;
  final String connectionType;
  final String? address;
  final String? tcpHost;
  final int? tcpPort;
  final int? tcpConnectTimeoutMs;
  final int? tcpWriteTimeoutMs;
  final int? tcpReadTimeoutMs;
  final bool tcpAutoReconnect;
  final int? tcpReconnectDelayMs;
  final String? tcpEncoding;
  final String? tcpCodePage;
  final String? tcpLineEnding;
  final bool tcpKeepAlive;
  final bool tcpNoDelay;
  final int? tcpLingerSeconds;
  final String? systemPrinterName;
  final String? systemPaperSize;
  final int systemDefaultCopies;
  final bool systemColorEnabled;
  final String? systemDuplexMode;
  final String? systemOrientation;
  final int? systemJobTimeoutMs;
  final String? systemNotes;
  final String? systemDriverName;
  final String? systemQueueName;
  final String? systemSpoolFormat;
  final bool systemUseRawSpool;
  final String? usbVendorId;
  final String? usbProductId;
  final String? usbSerialNumber;
  final int? usbInterfaceNumber;
  final int? usbOutEndpoint;
  final int? usbInEndpoint;
  final int? usbTimeoutMs;
  final String? usbEncoding;
  final String? usbCodePage;
  final String? usbCharacterTable;
  final bool usbAutoCutEnabled;
  final String? usbCutMode;
  final bool usbCashDrawerEnabled;
  final int? usbDrawerPin;
  final bool usbStatusMonitoringEnabled;
  final String? usbManufacturer;
  final String? usbProductName;
  final int? usbAlternateSetting;
  final int? usbPacketDelayMs;
  final String rawGraphicsMode;
  final bool isEnabled;
  final String? lastStatus;
  final String? lastStatusKey;
  final String? lastStatusMessage;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PrintersTableData({
    required this.id,
    required this.uniqueKey,
    required this.name,
    this.description,
    required this.connectionType,
    this.address,
    this.tcpHost,
    this.tcpPort,
    this.tcpConnectTimeoutMs,
    this.tcpWriteTimeoutMs,
    this.tcpReadTimeoutMs,
    required this.tcpAutoReconnect,
    this.tcpReconnectDelayMs,
    this.tcpEncoding,
    this.tcpCodePage,
    this.tcpLineEnding,
    required this.tcpKeepAlive,
    required this.tcpNoDelay,
    this.tcpLingerSeconds,
    this.systemPrinterName,
    this.systemPaperSize,
    required this.systemDefaultCopies,
    required this.systemColorEnabled,
    this.systemDuplexMode,
    this.systemOrientation,
    this.systemJobTimeoutMs,
    this.systemNotes,
    this.systemDriverName,
    this.systemQueueName,
    this.systemSpoolFormat,
    required this.systemUseRawSpool,
    this.usbVendorId,
    this.usbProductId,
    this.usbSerialNumber,
    this.usbInterfaceNumber,
    this.usbOutEndpoint,
    this.usbInEndpoint,
    this.usbTimeoutMs,
    this.usbEncoding,
    this.usbCodePage,
    this.usbCharacterTable,
    required this.usbAutoCutEnabled,
    this.usbCutMode,
    required this.usbCashDrawerEnabled,
    this.usbDrawerPin,
    required this.usbStatusMonitoringEnabled,
    this.usbManufacturer,
    this.usbProductName,
    this.usbAlternateSetting,
    this.usbPacketDelayMs,
    required this.rawGraphicsMode,
    required this.isEnabled,
    this.lastStatus,
    this.lastStatusKey,
    this.lastStatusMessage,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['unique_key'] = Variable<String>(uniqueKey);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['connection_type'] = Variable<String>(connectionType);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || tcpHost != null) {
      map['tcp_host'] = Variable<String>(tcpHost);
    }
    if (!nullToAbsent || tcpPort != null) {
      map['tcp_port'] = Variable<int>(tcpPort);
    }
    if (!nullToAbsent || tcpConnectTimeoutMs != null) {
      map['tcp_connect_timeout_ms'] = Variable<int>(tcpConnectTimeoutMs);
    }
    if (!nullToAbsent || tcpWriteTimeoutMs != null) {
      map['tcp_write_timeout_ms'] = Variable<int>(tcpWriteTimeoutMs);
    }
    if (!nullToAbsent || tcpReadTimeoutMs != null) {
      map['tcp_read_timeout_ms'] = Variable<int>(tcpReadTimeoutMs);
    }
    map['tcp_auto_reconnect'] = Variable<bool>(tcpAutoReconnect);
    if (!nullToAbsent || tcpReconnectDelayMs != null) {
      map['tcp_reconnect_delay_ms'] = Variable<int>(tcpReconnectDelayMs);
    }
    if (!nullToAbsent || tcpEncoding != null) {
      map['tcp_encoding'] = Variable<String>(tcpEncoding);
    }
    if (!nullToAbsent || tcpCodePage != null) {
      map['tcp_code_page'] = Variable<String>(tcpCodePage);
    }
    if (!nullToAbsent || tcpLineEnding != null) {
      map['tcp_line_ending'] = Variable<String>(tcpLineEnding);
    }
    map['tcp_keep_alive'] = Variable<bool>(tcpKeepAlive);
    map['tcp_no_delay'] = Variable<bool>(tcpNoDelay);
    if (!nullToAbsent || tcpLingerSeconds != null) {
      map['tcp_linger_seconds'] = Variable<int>(tcpLingerSeconds);
    }
    if (!nullToAbsent || systemPrinterName != null) {
      map['system_printer_name'] = Variable<String>(systemPrinterName);
    }
    if (!nullToAbsent || systemPaperSize != null) {
      map['system_paper_size'] = Variable<String>(systemPaperSize);
    }
    map['system_default_copies'] = Variable<int>(systemDefaultCopies);
    map['system_color_enabled'] = Variable<bool>(systemColorEnabled);
    if (!nullToAbsent || systemDuplexMode != null) {
      map['system_duplex_mode'] = Variable<String>(systemDuplexMode);
    }
    if (!nullToAbsent || systemOrientation != null) {
      map['system_orientation'] = Variable<String>(systemOrientation);
    }
    if (!nullToAbsent || systemJobTimeoutMs != null) {
      map['system_job_timeout_ms'] = Variable<int>(systemJobTimeoutMs);
    }
    if (!nullToAbsent || systemNotes != null) {
      map['system_notes'] = Variable<String>(systemNotes);
    }
    if (!nullToAbsent || systemDriverName != null) {
      map['system_driver_name'] = Variable<String>(systemDriverName);
    }
    if (!nullToAbsent || systemQueueName != null) {
      map['system_queue_name'] = Variable<String>(systemQueueName);
    }
    if (!nullToAbsent || systemSpoolFormat != null) {
      map['system_spool_format'] = Variable<String>(systemSpoolFormat);
    }
    map['system_use_raw_spool'] = Variable<bool>(systemUseRawSpool);
    if (!nullToAbsent || usbVendorId != null) {
      map['usb_vendor_id'] = Variable<String>(usbVendorId);
    }
    if (!nullToAbsent || usbProductId != null) {
      map['usb_product_id'] = Variable<String>(usbProductId);
    }
    if (!nullToAbsent || usbSerialNumber != null) {
      map['usb_serial_number'] = Variable<String>(usbSerialNumber);
    }
    if (!nullToAbsent || usbInterfaceNumber != null) {
      map['usb_interface_number'] = Variable<int>(usbInterfaceNumber);
    }
    if (!nullToAbsent || usbOutEndpoint != null) {
      map['usb_out_endpoint'] = Variable<int>(usbOutEndpoint);
    }
    if (!nullToAbsent || usbInEndpoint != null) {
      map['usb_in_endpoint'] = Variable<int>(usbInEndpoint);
    }
    if (!nullToAbsent || usbTimeoutMs != null) {
      map['usb_timeout_ms'] = Variable<int>(usbTimeoutMs);
    }
    if (!nullToAbsent || usbEncoding != null) {
      map['usb_encoding'] = Variable<String>(usbEncoding);
    }
    if (!nullToAbsent || usbCodePage != null) {
      map['usb_code_page'] = Variable<String>(usbCodePage);
    }
    if (!nullToAbsent || usbCharacterTable != null) {
      map['usb_character_table'] = Variable<String>(usbCharacterTable);
    }
    map['usb_auto_cut_enabled'] = Variable<bool>(usbAutoCutEnabled);
    if (!nullToAbsent || usbCutMode != null) {
      map['usb_cut_mode'] = Variable<String>(usbCutMode);
    }
    map['usb_cash_drawer_enabled'] = Variable<bool>(usbCashDrawerEnabled);
    if (!nullToAbsent || usbDrawerPin != null) {
      map['usb_drawer_pin'] = Variable<int>(usbDrawerPin);
    }
    map['usb_status_monitoring_enabled'] = Variable<bool>(
      usbStatusMonitoringEnabled,
    );
    if (!nullToAbsent || usbManufacturer != null) {
      map['usb_manufacturer'] = Variable<String>(usbManufacturer);
    }
    if (!nullToAbsent || usbProductName != null) {
      map['usb_product_name'] = Variable<String>(usbProductName);
    }
    if (!nullToAbsent || usbAlternateSetting != null) {
      map['usb_alternate_setting'] = Variable<int>(usbAlternateSetting);
    }
    if (!nullToAbsent || usbPacketDelayMs != null) {
      map['usb_packet_delay_ms'] = Variable<int>(usbPacketDelayMs);
    }
    map['raw_graphics_mode'] = Variable<String>(rawGraphicsMode);
    map['is_enabled'] = Variable<bool>(isEnabled);
    if (!nullToAbsent || lastStatus != null) {
      map['last_status'] = Variable<String>(lastStatus);
    }
    if (!nullToAbsent || lastStatusKey != null) {
      map['last_status_key'] = Variable<String>(lastStatusKey);
    }
    if (!nullToAbsent || lastStatusMessage != null) {
      map['last_status_message'] = Variable<String>(lastStatusMessage);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PrintersTableCompanion toCompanion(bool nullToAbsent) {
    return PrintersTableCompanion(
      id: Value(id),
      uniqueKey: Value(uniqueKey),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      connectionType: Value(connectionType),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      tcpHost: tcpHost == null && nullToAbsent
          ? const Value.absent()
          : Value(tcpHost),
      tcpPort: tcpPort == null && nullToAbsent
          ? const Value.absent()
          : Value(tcpPort),
      tcpConnectTimeoutMs: tcpConnectTimeoutMs == null && nullToAbsent
          ? const Value.absent()
          : Value(tcpConnectTimeoutMs),
      tcpWriteTimeoutMs: tcpWriteTimeoutMs == null && nullToAbsent
          ? const Value.absent()
          : Value(tcpWriteTimeoutMs),
      tcpReadTimeoutMs: tcpReadTimeoutMs == null && nullToAbsent
          ? const Value.absent()
          : Value(tcpReadTimeoutMs),
      tcpAutoReconnect: Value(tcpAutoReconnect),
      tcpReconnectDelayMs: tcpReconnectDelayMs == null && nullToAbsent
          ? const Value.absent()
          : Value(tcpReconnectDelayMs),
      tcpEncoding: tcpEncoding == null && nullToAbsent
          ? const Value.absent()
          : Value(tcpEncoding),
      tcpCodePage: tcpCodePage == null && nullToAbsent
          ? const Value.absent()
          : Value(tcpCodePage),
      tcpLineEnding: tcpLineEnding == null && nullToAbsent
          ? const Value.absent()
          : Value(tcpLineEnding),
      tcpKeepAlive: Value(tcpKeepAlive),
      tcpNoDelay: Value(tcpNoDelay),
      tcpLingerSeconds: tcpLingerSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(tcpLingerSeconds),
      systemPrinterName: systemPrinterName == null && nullToAbsent
          ? const Value.absent()
          : Value(systemPrinterName),
      systemPaperSize: systemPaperSize == null && nullToAbsent
          ? const Value.absent()
          : Value(systemPaperSize),
      systemDefaultCopies: Value(systemDefaultCopies),
      systemColorEnabled: Value(systemColorEnabled),
      systemDuplexMode: systemDuplexMode == null && nullToAbsent
          ? const Value.absent()
          : Value(systemDuplexMode),
      systemOrientation: systemOrientation == null && nullToAbsent
          ? const Value.absent()
          : Value(systemOrientation),
      systemJobTimeoutMs: systemJobTimeoutMs == null && nullToAbsent
          ? const Value.absent()
          : Value(systemJobTimeoutMs),
      systemNotes: systemNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(systemNotes),
      systemDriverName: systemDriverName == null && nullToAbsent
          ? const Value.absent()
          : Value(systemDriverName),
      systemQueueName: systemQueueName == null && nullToAbsent
          ? const Value.absent()
          : Value(systemQueueName),
      systemSpoolFormat: systemSpoolFormat == null && nullToAbsent
          ? const Value.absent()
          : Value(systemSpoolFormat),
      systemUseRawSpool: Value(systemUseRawSpool),
      usbVendorId: usbVendorId == null && nullToAbsent
          ? const Value.absent()
          : Value(usbVendorId),
      usbProductId: usbProductId == null && nullToAbsent
          ? const Value.absent()
          : Value(usbProductId),
      usbSerialNumber: usbSerialNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(usbSerialNumber),
      usbInterfaceNumber: usbInterfaceNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(usbInterfaceNumber),
      usbOutEndpoint: usbOutEndpoint == null && nullToAbsent
          ? const Value.absent()
          : Value(usbOutEndpoint),
      usbInEndpoint: usbInEndpoint == null && nullToAbsent
          ? const Value.absent()
          : Value(usbInEndpoint),
      usbTimeoutMs: usbTimeoutMs == null && nullToAbsent
          ? const Value.absent()
          : Value(usbTimeoutMs),
      usbEncoding: usbEncoding == null && nullToAbsent
          ? const Value.absent()
          : Value(usbEncoding),
      usbCodePage: usbCodePage == null && nullToAbsent
          ? const Value.absent()
          : Value(usbCodePage),
      usbCharacterTable: usbCharacterTable == null && nullToAbsent
          ? const Value.absent()
          : Value(usbCharacterTable),
      usbAutoCutEnabled: Value(usbAutoCutEnabled),
      usbCutMode: usbCutMode == null && nullToAbsent
          ? const Value.absent()
          : Value(usbCutMode),
      usbCashDrawerEnabled: Value(usbCashDrawerEnabled),
      usbDrawerPin: usbDrawerPin == null && nullToAbsent
          ? const Value.absent()
          : Value(usbDrawerPin),
      usbStatusMonitoringEnabled: Value(usbStatusMonitoringEnabled),
      usbManufacturer: usbManufacturer == null && nullToAbsent
          ? const Value.absent()
          : Value(usbManufacturer),
      usbProductName: usbProductName == null && nullToAbsent
          ? const Value.absent()
          : Value(usbProductName),
      usbAlternateSetting: usbAlternateSetting == null && nullToAbsent
          ? const Value.absent()
          : Value(usbAlternateSetting),
      usbPacketDelayMs: usbPacketDelayMs == null && nullToAbsent
          ? const Value.absent()
          : Value(usbPacketDelayMs),
      rawGraphicsMode: Value(rawGraphicsMode),
      isEnabled: Value(isEnabled),
      lastStatus: lastStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(lastStatus),
      lastStatusKey: lastStatusKey == null && nullToAbsent
          ? const Value.absent()
          : Value(lastStatusKey),
      lastStatusMessage: lastStatusMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(lastStatusMessage),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PrintersTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrintersTableData(
      id: serializer.fromJson<String>(json['id']),
      uniqueKey: serializer.fromJson<String>(json['uniqueKey']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      connectionType: serializer.fromJson<String>(json['connectionType']),
      address: serializer.fromJson<String?>(json['address']),
      tcpHost: serializer.fromJson<String?>(json['tcpHost']),
      tcpPort: serializer.fromJson<int?>(json['tcpPort']),
      tcpConnectTimeoutMs: serializer.fromJson<int?>(
        json['tcpConnectTimeoutMs'],
      ),
      tcpWriteTimeoutMs: serializer.fromJson<int?>(json['tcpWriteTimeoutMs']),
      tcpReadTimeoutMs: serializer.fromJson<int?>(json['tcpReadTimeoutMs']),
      tcpAutoReconnect: serializer.fromJson<bool>(json['tcpAutoReconnect']),
      tcpReconnectDelayMs: serializer.fromJson<int?>(
        json['tcpReconnectDelayMs'],
      ),
      tcpEncoding: serializer.fromJson<String?>(json['tcpEncoding']),
      tcpCodePage: serializer.fromJson<String?>(json['tcpCodePage']),
      tcpLineEnding: serializer.fromJson<String?>(json['tcpLineEnding']),
      tcpKeepAlive: serializer.fromJson<bool>(json['tcpKeepAlive']),
      tcpNoDelay: serializer.fromJson<bool>(json['tcpNoDelay']),
      tcpLingerSeconds: serializer.fromJson<int?>(json['tcpLingerSeconds']),
      systemPrinterName: serializer.fromJson<String?>(
        json['systemPrinterName'],
      ),
      systemPaperSize: serializer.fromJson<String?>(json['systemPaperSize']),
      systemDefaultCopies: serializer.fromJson<int>(
        json['systemDefaultCopies'],
      ),
      systemColorEnabled: serializer.fromJson<bool>(json['systemColorEnabled']),
      systemDuplexMode: serializer.fromJson<String?>(json['systemDuplexMode']),
      systemOrientation: serializer.fromJson<String?>(
        json['systemOrientation'],
      ),
      systemJobTimeoutMs: serializer.fromJson<int?>(json['systemJobTimeoutMs']),
      systemNotes: serializer.fromJson<String?>(json['systemNotes']),
      systemDriverName: serializer.fromJson<String?>(json['systemDriverName']),
      systemQueueName: serializer.fromJson<String?>(json['systemQueueName']),
      systemSpoolFormat: serializer.fromJson<String?>(
        json['systemSpoolFormat'],
      ),
      systemUseRawSpool: serializer.fromJson<bool>(json['systemUseRawSpool']),
      usbVendorId: serializer.fromJson<String?>(json['usbVendorId']),
      usbProductId: serializer.fromJson<String?>(json['usbProductId']),
      usbSerialNumber: serializer.fromJson<String?>(json['usbSerialNumber']),
      usbInterfaceNumber: serializer.fromJson<int?>(json['usbInterfaceNumber']),
      usbOutEndpoint: serializer.fromJson<int?>(json['usbOutEndpoint']),
      usbInEndpoint: serializer.fromJson<int?>(json['usbInEndpoint']),
      usbTimeoutMs: serializer.fromJson<int?>(json['usbTimeoutMs']),
      usbEncoding: serializer.fromJson<String?>(json['usbEncoding']),
      usbCodePage: serializer.fromJson<String?>(json['usbCodePage']),
      usbCharacterTable: serializer.fromJson<String?>(
        json['usbCharacterTable'],
      ),
      usbAutoCutEnabled: serializer.fromJson<bool>(json['usbAutoCutEnabled']),
      usbCutMode: serializer.fromJson<String?>(json['usbCutMode']),
      usbCashDrawerEnabled: serializer.fromJson<bool>(
        json['usbCashDrawerEnabled'],
      ),
      usbDrawerPin: serializer.fromJson<int?>(json['usbDrawerPin']),
      usbStatusMonitoringEnabled: serializer.fromJson<bool>(
        json['usbStatusMonitoringEnabled'],
      ),
      usbManufacturer: serializer.fromJson<String?>(json['usbManufacturer']),
      usbProductName: serializer.fromJson<String?>(json['usbProductName']),
      usbAlternateSetting: serializer.fromJson<int?>(
        json['usbAlternateSetting'],
      ),
      usbPacketDelayMs: serializer.fromJson<int?>(json['usbPacketDelayMs']),
      rawGraphicsMode: serializer.fromJson<String>(json['rawGraphicsMode']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      lastStatus: serializer.fromJson<String?>(json['lastStatus']),
      lastStatusKey: serializer.fromJson<String?>(json['lastStatusKey']),
      lastStatusMessage: serializer.fromJson<String?>(
        json['lastStatusMessage'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'uniqueKey': serializer.toJson<String>(uniqueKey),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'connectionType': serializer.toJson<String>(connectionType),
      'address': serializer.toJson<String?>(address),
      'tcpHost': serializer.toJson<String?>(tcpHost),
      'tcpPort': serializer.toJson<int?>(tcpPort),
      'tcpConnectTimeoutMs': serializer.toJson<int?>(tcpConnectTimeoutMs),
      'tcpWriteTimeoutMs': serializer.toJson<int?>(tcpWriteTimeoutMs),
      'tcpReadTimeoutMs': serializer.toJson<int?>(tcpReadTimeoutMs),
      'tcpAutoReconnect': serializer.toJson<bool>(tcpAutoReconnect),
      'tcpReconnectDelayMs': serializer.toJson<int?>(tcpReconnectDelayMs),
      'tcpEncoding': serializer.toJson<String?>(tcpEncoding),
      'tcpCodePage': serializer.toJson<String?>(tcpCodePage),
      'tcpLineEnding': serializer.toJson<String?>(tcpLineEnding),
      'tcpKeepAlive': serializer.toJson<bool>(tcpKeepAlive),
      'tcpNoDelay': serializer.toJson<bool>(tcpNoDelay),
      'tcpLingerSeconds': serializer.toJson<int?>(tcpLingerSeconds),
      'systemPrinterName': serializer.toJson<String?>(systemPrinterName),
      'systemPaperSize': serializer.toJson<String?>(systemPaperSize),
      'systemDefaultCopies': serializer.toJson<int>(systemDefaultCopies),
      'systemColorEnabled': serializer.toJson<bool>(systemColorEnabled),
      'systemDuplexMode': serializer.toJson<String?>(systemDuplexMode),
      'systemOrientation': serializer.toJson<String?>(systemOrientation),
      'systemJobTimeoutMs': serializer.toJson<int?>(systemJobTimeoutMs),
      'systemNotes': serializer.toJson<String?>(systemNotes),
      'systemDriverName': serializer.toJson<String?>(systemDriverName),
      'systemQueueName': serializer.toJson<String?>(systemQueueName),
      'systemSpoolFormat': serializer.toJson<String?>(systemSpoolFormat),
      'systemUseRawSpool': serializer.toJson<bool>(systemUseRawSpool),
      'usbVendorId': serializer.toJson<String?>(usbVendorId),
      'usbProductId': serializer.toJson<String?>(usbProductId),
      'usbSerialNumber': serializer.toJson<String?>(usbSerialNumber),
      'usbInterfaceNumber': serializer.toJson<int?>(usbInterfaceNumber),
      'usbOutEndpoint': serializer.toJson<int?>(usbOutEndpoint),
      'usbInEndpoint': serializer.toJson<int?>(usbInEndpoint),
      'usbTimeoutMs': serializer.toJson<int?>(usbTimeoutMs),
      'usbEncoding': serializer.toJson<String?>(usbEncoding),
      'usbCodePage': serializer.toJson<String?>(usbCodePage),
      'usbCharacterTable': serializer.toJson<String?>(usbCharacterTable),
      'usbAutoCutEnabled': serializer.toJson<bool>(usbAutoCutEnabled),
      'usbCutMode': serializer.toJson<String?>(usbCutMode),
      'usbCashDrawerEnabled': serializer.toJson<bool>(usbCashDrawerEnabled),
      'usbDrawerPin': serializer.toJson<int?>(usbDrawerPin),
      'usbStatusMonitoringEnabled': serializer.toJson<bool>(
        usbStatusMonitoringEnabled,
      ),
      'usbManufacturer': serializer.toJson<String?>(usbManufacturer),
      'usbProductName': serializer.toJson<String?>(usbProductName),
      'usbAlternateSetting': serializer.toJson<int?>(usbAlternateSetting),
      'usbPacketDelayMs': serializer.toJson<int?>(usbPacketDelayMs),
      'rawGraphicsMode': serializer.toJson<String>(rawGraphicsMode),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'lastStatus': serializer.toJson<String?>(lastStatus),
      'lastStatusKey': serializer.toJson<String?>(lastStatusKey),
      'lastStatusMessage': serializer.toJson<String?>(lastStatusMessage),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PrintersTableData copyWith({
    String? id,
    String? uniqueKey,
    String? name,
    Value<String?> description = const Value.absent(),
    String? connectionType,
    Value<String?> address = const Value.absent(),
    Value<String?> tcpHost = const Value.absent(),
    Value<int?> tcpPort = const Value.absent(),
    Value<int?> tcpConnectTimeoutMs = const Value.absent(),
    Value<int?> tcpWriteTimeoutMs = const Value.absent(),
    Value<int?> tcpReadTimeoutMs = const Value.absent(),
    bool? tcpAutoReconnect,
    Value<int?> tcpReconnectDelayMs = const Value.absent(),
    Value<String?> tcpEncoding = const Value.absent(),
    Value<String?> tcpCodePage = const Value.absent(),
    Value<String?> tcpLineEnding = const Value.absent(),
    bool? tcpKeepAlive,
    bool? tcpNoDelay,
    Value<int?> tcpLingerSeconds = const Value.absent(),
    Value<String?> systemPrinterName = const Value.absent(),
    Value<String?> systemPaperSize = const Value.absent(),
    int? systemDefaultCopies,
    bool? systemColorEnabled,
    Value<String?> systemDuplexMode = const Value.absent(),
    Value<String?> systemOrientation = const Value.absent(),
    Value<int?> systemJobTimeoutMs = const Value.absent(),
    Value<String?> systemNotes = const Value.absent(),
    Value<String?> systemDriverName = const Value.absent(),
    Value<String?> systemQueueName = const Value.absent(),
    Value<String?> systemSpoolFormat = const Value.absent(),
    bool? systemUseRawSpool,
    Value<String?> usbVendorId = const Value.absent(),
    Value<String?> usbProductId = const Value.absent(),
    Value<String?> usbSerialNumber = const Value.absent(),
    Value<int?> usbInterfaceNumber = const Value.absent(),
    Value<int?> usbOutEndpoint = const Value.absent(),
    Value<int?> usbInEndpoint = const Value.absent(),
    Value<int?> usbTimeoutMs = const Value.absent(),
    Value<String?> usbEncoding = const Value.absent(),
    Value<String?> usbCodePage = const Value.absent(),
    Value<String?> usbCharacterTable = const Value.absent(),
    bool? usbAutoCutEnabled,
    Value<String?> usbCutMode = const Value.absent(),
    bool? usbCashDrawerEnabled,
    Value<int?> usbDrawerPin = const Value.absent(),
    bool? usbStatusMonitoringEnabled,
    Value<String?> usbManufacturer = const Value.absent(),
    Value<String?> usbProductName = const Value.absent(),
    Value<int?> usbAlternateSetting = const Value.absent(),
    Value<int?> usbPacketDelayMs = const Value.absent(),
    String? rawGraphicsMode,
    bool? isEnabled,
    Value<String?> lastStatus = const Value.absent(),
    Value<String?> lastStatusKey = const Value.absent(),
    Value<String?> lastStatusMessage = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => PrintersTableData(
    id: id ?? this.id,
    uniqueKey: uniqueKey ?? this.uniqueKey,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    connectionType: connectionType ?? this.connectionType,
    address: address.present ? address.value : this.address,
    tcpHost: tcpHost.present ? tcpHost.value : this.tcpHost,
    tcpPort: tcpPort.present ? tcpPort.value : this.tcpPort,
    tcpConnectTimeoutMs: tcpConnectTimeoutMs.present
        ? tcpConnectTimeoutMs.value
        : this.tcpConnectTimeoutMs,
    tcpWriteTimeoutMs: tcpWriteTimeoutMs.present
        ? tcpWriteTimeoutMs.value
        : this.tcpWriteTimeoutMs,
    tcpReadTimeoutMs: tcpReadTimeoutMs.present
        ? tcpReadTimeoutMs.value
        : this.tcpReadTimeoutMs,
    tcpAutoReconnect: tcpAutoReconnect ?? this.tcpAutoReconnect,
    tcpReconnectDelayMs: tcpReconnectDelayMs.present
        ? tcpReconnectDelayMs.value
        : this.tcpReconnectDelayMs,
    tcpEncoding: tcpEncoding.present ? tcpEncoding.value : this.tcpEncoding,
    tcpCodePage: tcpCodePage.present ? tcpCodePage.value : this.tcpCodePage,
    tcpLineEnding: tcpLineEnding.present
        ? tcpLineEnding.value
        : this.tcpLineEnding,
    tcpKeepAlive: tcpKeepAlive ?? this.tcpKeepAlive,
    tcpNoDelay: tcpNoDelay ?? this.tcpNoDelay,
    tcpLingerSeconds: tcpLingerSeconds.present
        ? tcpLingerSeconds.value
        : this.tcpLingerSeconds,
    systemPrinterName: systemPrinterName.present
        ? systemPrinterName.value
        : this.systemPrinterName,
    systemPaperSize: systemPaperSize.present
        ? systemPaperSize.value
        : this.systemPaperSize,
    systemDefaultCopies: systemDefaultCopies ?? this.systemDefaultCopies,
    systemColorEnabled: systemColorEnabled ?? this.systemColorEnabled,
    systemDuplexMode: systemDuplexMode.present
        ? systemDuplexMode.value
        : this.systemDuplexMode,
    systemOrientation: systemOrientation.present
        ? systemOrientation.value
        : this.systemOrientation,
    systemJobTimeoutMs: systemJobTimeoutMs.present
        ? systemJobTimeoutMs.value
        : this.systemJobTimeoutMs,
    systemNotes: systemNotes.present ? systemNotes.value : this.systemNotes,
    systemDriverName: systemDriverName.present
        ? systemDriverName.value
        : this.systemDriverName,
    systemQueueName: systemQueueName.present
        ? systemQueueName.value
        : this.systemQueueName,
    systemSpoolFormat: systemSpoolFormat.present
        ? systemSpoolFormat.value
        : this.systemSpoolFormat,
    systemUseRawSpool: systemUseRawSpool ?? this.systemUseRawSpool,
    usbVendorId: usbVendorId.present ? usbVendorId.value : this.usbVendorId,
    usbProductId: usbProductId.present ? usbProductId.value : this.usbProductId,
    usbSerialNumber: usbSerialNumber.present
        ? usbSerialNumber.value
        : this.usbSerialNumber,
    usbInterfaceNumber: usbInterfaceNumber.present
        ? usbInterfaceNumber.value
        : this.usbInterfaceNumber,
    usbOutEndpoint: usbOutEndpoint.present
        ? usbOutEndpoint.value
        : this.usbOutEndpoint,
    usbInEndpoint: usbInEndpoint.present
        ? usbInEndpoint.value
        : this.usbInEndpoint,
    usbTimeoutMs: usbTimeoutMs.present ? usbTimeoutMs.value : this.usbTimeoutMs,
    usbEncoding: usbEncoding.present ? usbEncoding.value : this.usbEncoding,
    usbCodePage: usbCodePage.present ? usbCodePage.value : this.usbCodePage,
    usbCharacterTable: usbCharacterTable.present
        ? usbCharacterTable.value
        : this.usbCharacterTable,
    usbAutoCutEnabled: usbAutoCutEnabled ?? this.usbAutoCutEnabled,
    usbCutMode: usbCutMode.present ? usbCutMode.value : this.usbCutMode,
    usbCashDrawerEnabled: usbCashDrawerEnabled ?? this.usbCashDrawerEnabled,
    usbDrawerPin: usbDrawerPin.present ? usbDrawerPin.value : this.usbDrawerPin,
    usbStatusMonitoringEnabled:
        usbStatusMonitoringEnabled ?? this.usbStatusMonitoringEnabled,
    usbManufacturer: usbManufacturer.present
        ? usbManufacturer.value
        : this.usbManufacturer,
    usbProductName: usbProductName.present
        ? usbProductName.value
        : this.usbProductName,
    usbAlternateSetting: usbAlternateSetting.present
        ? usbAlternateSetting.value
        : this.usbAlternateSetting,
    usbPacketDelayMs: usbPacketDelayMs.present
        ? usbPacketDelayMs.value
        : this.usbPacketDelayMs,
    rawGraphicsMode: rawGraphicsMode ?? this.rawGraphicsMode,
    isEnabled: isEnabled ?? this.isEnabled,
    lastStatus: lastStatus.present ? lastStatus.value : this.lastStatus,
    lastStatusKey: lastStatusKey.present
        ? lastStatusKey.value
        : this.lastStatusKey,
    lastStatusMessage: lastStatusMessage.present
        ? lastStatusMessage.value
        : this.lastStatusMessage,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PrintersTableData copyWithCompanion(PrintersTableCompanion data) {
    return PrintersTableData(
      id: data.id.present ? data.id.value : this.id,
      uniqueKey: data.uniqueKey.present ? data.uniqueKey.value : this.uniqueKey,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      connectionType: data.connectionType.present
          ? data.connectionType.value
          : this.connectionType,
      address: data.address.present ? data.address.value : this.address,
      tcpHost: data.tcpHost.present ? data.tcpHost.value : this.tcpHost,
      tcpPort: data.tcpPort.present ? data.tcpPort.value : this.tcpPort,
      tcpConnectTimeoutMs: data.tcpConnectTimeoutMs.present
          ? data.tcpConnectTimeoutMs.value
          : this.tcpConnectTimeoutMs,
      tcpWriteTimeoutMs: data.tcpWriteTimeoutMs.present
          ? data.tcpWriteTimeoutMs.value
          : this.tcpWriteTimeoutMs,
      tcpReadTimeoutMs: data.tcpReadTimeoutMs.present
          ? data.tcpReadTimeoutMs.value
          : this.tcpReadTimeoutMs,
      tcpAutoReconnect: data.tcpAutoReconnect.present
          ? data.tcpAutoReconnect.value
          : this.tcpAutoReconnect,
      tcpReconnectDelayMs: data.tcpReconnectDelayMs.present
          ? data.tcpReconnectDelayMs.value
          : this.tcpReconnectDelayMs,
      tcpEncoding: data.tcpEncoding.present
          ? data.tcpEncoding.value
          : this.tcpEncoding,
      tcpCodePage: data.tcpCodePage.present
          ? data.tcpCodePage.value
          : this.tcpCodePage,
      tcpLineEnding: data.tcpLineEnding.present
          ? data.tcpLineEnding.value
          : this.tcpLineEnding,
      tcpKeepAlive: data.tcpKeepAlive.present
          ? data.tcpKeepAlive.value
          : this.tcpKeepAlive,
      tcpNoDelay: data.tcpNoDelay.present
          ? data.tcpNoDelay.value
          : this.tcpNoDelay,
      tcpLingerSeconds: data.tcpLingerSeconds.present
          ? data.tcpLingerSeconds.value
          : this.tcpLingerSeconds,
      systemPrinterName: data.systemPrinterName.present
          ? data.systemPrinterName.value
          : this.systemPrinterName,
      systemPaperSize: data.systemPaperSize.present
          ? data.systemPaperSize.value
          : this.systemPaperSize,
      systemDefaultCopies: data.systemDefaultCopies.present
          ? data.systemDefaultCopies.value
          : this.systemDefaultCopies,
      systemColorEnabled: data.systemColorEnabled.present
          ? data.systemColorEnabled.value
          : this.systemColorEnabled,
      systemDuplexMode: data.systemDuplexMode.present
          ? data.systemDuplexMode.value
          : this.systemDuplexMode,
      systemOrientation: data.systemOrientation.present
          ? data.systemOrientation.value
          : this.systemOrientation,
      systemJobTimeoutMs: data.systemJobTimeoutMs.present
          ? data.systemJobTimeoutMs.value
          : this.systemJobTimeoutMs,
      systemNotes: data.systemNotes.present
          ? data.systemNotes.value
          : this.systemNotes,
      systemDriverName: data.systemDriverName.present
          ? data.systemDriverName.value
          : this.systemDriverName,
      systemQueueName: data.systemQueueName.present
          ? data.systemQueueName.value
          : this.systemQueueName,
      systemSpoolFormat: data.systemSpoolFormat.present
          ? data.systemSpoolFormat.value
          : this.systemSpoolFormat,
      systemUseRawSpool: data.systemUseRawSpool.present
          ? data.systemUseRawSpool.value
          : this.systemUseRawSpool,
      usbVendorId: data.usbVendorId.present
          ? data.usbVendorId.value
          : this.usbVendorId,
      usbProductId: data.usbProductId.present
          ? data.usbProductId.value
          : this.usbProductId,
      usbSerialNumber: data.usbSerialNumber.present
          ? data.usbSerialNumber.value
          : this.usbSerialNumber,
      usbInterfaceNumber: data.usbInterfaceNumber.present
          ? data.usbInterfaceNumber.value
          : this.usbInterfaceNumber,
      usbOutEndpoint: data.usbOutEndpoint.present
          ? data.usbOutEndpoint.value
          : this.usbOutEndpoint,
      usbInEndpoint: data.usbInEndpoint.present
          ? data.usbInEndpoint.value
          : this.usbInEndpoint,
      usbTimeoutMs: data.usbTimeoutMs.present
          ? data.usbTimeoutMs.value
          : this.usbTimeoutMs,
      usbEncoding: data.usbEncoding.present
          ? data.usbEncoding.value
          : this.usbEncoding,
      usbCodePage: data.usbCodePage.present
          ? data.usbCodePage.value
          : this.usbCodePage,
      usbCharacterTable: data.usbCharacterTable.present
          ? data.usbCharacterTable.value
          : this.usbCharacterTable,
      usbAutoCutEnabled: data.usbAutoCutEnabled.present
          ? data.usbAutoCutEnabled.value
          : this.usbAutoCutEnabled,
      usbCutMode: data.usbCutMode.present
          ? data.usbCutMode.value
          : this.usbCutMode,
      usbCashDrawerEnabled: data.usbCashDrawerEnabled.present
          ? data.usbCashDrawerEnabled.value
          : this.usbCashDrawerEnabled,
      usbDrawerPin: data.usbDrawerPin.present
          ? data.usbDrawerPin.value
          : this.usbDrawerPin,
      usbStatusMonitoringEnabled: data.usbStatusMonitoringEnabled.present
          ? data.usbStatusMonitoringEnabled.value
          : this.usbStatusMonitoringEnabled,
      usbManufacturer: data.usbManufacturer.present
          ? data.usbManufacturer.value
          : this.usbManufacturer,
      usbProductName: data.usbProductName.present
          ? data.usbProductName.value
          : this.usbProductName,
      usbAlternateSetting: data.usbAlternateSetting.present
          ? data.usbAlternateSetting.value
          : this.usbAlternateSetting,
      usbPacketDelayMs: data.usbPacketDelayMs.present
          ? data.usbPacketDelayMs.value
          : this.usbPacketDelayMs,
      rawGraphicsMode: data.rawGraphicsMode.present
          ? data.rawGraphicsMode.value
          : this.rawGraphicsMode,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      lastStatus: data.lastStatus.present
          ? data.lastStatus.value
          : this.lastStatus,
      lastStatusKey: data.lastStatusKey.present
          ? data.lastStatusKey.value
          : this.lastStatusKey,
      lastStatusMessage: data.lastStatusMessage.present
          ? data.lastStatusMessage.value
          : this.lastStatusMessage,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrintersTableData(')
          ..write('id: $id, ')
          ..write('uniqueKey: $uniqueKey, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('connectionType: $connectionType, ')
          ..write('address: $address, ')
          ..write('tcpHost: $tcpHost, ')
          ..write('tcpPort: $tcpPort, ')
          ..write('tcpConnectTimeoutMs: $tcpConnectTimeoutMs, ')
          ..write('tcpWriteTimeoutMs: $tcpWriteTimeoutMs, ')
          ..write('tcpReadTimeoutMs: $tcpReadTimeoutMs, ')
          ..write('tcpAutoReconnect: $tcpAutoReconnect, ')
          ..write('tcpReconnectDelayMs: $tcpReconnectDelayMs, ')
          ..write('tcpEncoding: $tcpEncoding, ')
          ..write('tcpCodePage: $tcpCodePage, ')
          ..write('tcpLineEnding: $tcpLineEnding, ')
          ..write('tcpKeepAlive: $tcpKeepAlive, ')
          ..write('tcpNoDelay: $tcpNoDelay, ')
          ..write('tcpLingerSeconds: $tcpLingerSeconds, ')
          ..write('systemPrinterName: $systemPrinterName, ')
          ..write('systemPaperSize: $systemPaperSize, ')
          ..write('systemDefaultCopies: $systemDefaultCopies, ')
          ..write('systemColorEnabled: $systemColorEnabled, ')
          ..write('systemDuplexMode: $systemDuplexMode, ')
          ..write('systemOrientation: $systemOrientation, ')
          ..write('systemJobTimeoutMs: $systemJobTimeoutMs, ')
          ..write('systemNotes: $systemNotes, ')
          ..write('systemDriverName: $systemDriverName, ')
          ..write('systemQueueName: $systemQueueName, ')
          ..write('systemSpoolFormat: $systemSpoolFormat, ')
          ..write('systemUseRawSpool: $systemUseRawSpool, ')
          ..write('usbVendorId: $usbVendorId, ')
          ..write('usbProductId: $usbProductId, ')
          ..write('usbSerialNumber: $usbSerialNumber, ')
          ..write('usbInterfaceNumber: $usbInterfaceNumber, ')
          ..write('usbOutEndpoint: $usbOutEndpoint, ')
          ..write('usbInEndpoint: $usbInEndpoint, ')
          ..write('usbTimeoutMs: $usbTimeoutMs, ')
          ..write('usbEncoding: $usbEncoding, ')
          ..write('usbCodePage: $usbCodePage, ')
          ..write('usbCharacterTable: $usbCharacterTable, ')
          ..write('usbAutoCutEnabled: $usbAutoCutEnabled, ')
          ..write('usbCutMode: $usbCutMode, ')
          ..write('usbCashDrawerEnabled: $usbCashDrawerEnabled, ')
          ..write('usbDrawerPin: $usbDrawerPin, ')
          ..write('usbStatusMonitoringEnabled: $usbStatusMonitoringEnabled, ')
          ..write('usbManufacturer: $usbManufacturer, ')
          ..write('usbProductName: $usbProductName, ')
          ..write('usbAlternateSetting: $usbAlternateSetting, ')
          ..write('usbPacketDelayMs: $usbPacketDelayMs, ')
          ..write('rawGraphicsMode: $rawGraphicsMode, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('lastStatus: $lastStatus, ')
          ..write('lastStatusKey: $lastStatusKey, ')
          ..write('lastStatusMessage: $lastStatusMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    uniqueKey,
    name,
    description,
    connectionType,
    address,
    tcpHost,
    tcpPort,
    tcpConnectTimeoutMs,
    tcpWriteTimeoutMs,
    tcpReadTimeoutMs,
    tcpAutoReconnect,
    tcpReconnectDelayMs,
    tcpEncoding,
    tcpCodePage,
    tcpLineEnding,
    tcpKeepAlive,
    tcpNoDelay,
    tcpLingerSeconds,
    systemPrinterName,
    systemPaperSize,
    systemDefaultCopies,
    systemColorEnabled,
    systemDuplexMode,
    systemOrientation,
    systemJobTimeoutMs,
    systemNotes,
    systemDriverName,
    systemQueueName,
    systemSpoolFormat,
    systemUseRawSpool,
    usbVendorId,
    usbProductId,
    usbSerialNumber,
    usbInterfaceNumber,
    usbOutEndpoint,
    usbInEndpoint,
    usbTimeoutMs,
    usbEncoding,
    usbCodePage,
    usbCharacterTable,
    usbAutoCutEnabled,
    usbCutMode,
    usbCashDrawerEnabled,
    usbDrawerPin,
    usbStatusMonitoringEnabled,
    usbManufacturer,
    usbProductName,
    usbAlternateSetting,
    usbPacketDelayMs,
    rawGraphicsMode,
    isEnabled,
    lastStatus,
    lastStatusKey,
    lastStatusMessage,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrintersTableData &&
          other.id == this.id &&
          other.uniqueKey == this.uniqueKey &&
          other.name == this.name &&
          other.description == this.description &&
          other.connectionType == this.connectionType &&
          other.address == this.address &&
          other.tcpHost == this.tcpHost &&
          other.tcpPort == this.tcpPort &&
          other.tcpConnectTimeoutMs == this.tcpConnectTimeoutMs &&
          other.tcpWriteTimeoutMs == this.tcpWriteTimeoutMs &&
          other.tcpReadTimeoutMs == this.tcpReadTimeoutMs &&
          other.tcpAutoReconnect == this.tcpAutoReconnect &&
          other.tcpReconnectDelayMs == this.tcpReconnectDelayMs &&
          other.tcpEncoding == this.tcpEncoding &&
          other.tcpCodePage == this.tcpCodePage &&
          other.tcpLineEnding == this.tcpLineEnding &&
          other.tcpKeepAlive == this.tcpKeepAlive &&
          other.tcpNoDelay == this.tcpNoDelay &&
          other.tcpLingerSeconds == this.tcpLingerSeconds &&
          other.systemPrinterName == this.systemPrinterName &&
          other.systemPaperSize == this.systemPaperSize &&
          other.systemDefaultCopies == this.systemDefaultCopies &&
          other.systemColorEnabled == this.systemColorEnabled &&
          other.systemDuplexMode == this.systemDuplexMode &&
          other.systemOrientation == this.systemOrientation &&
          other.systemJobTimeoutMs == this.systemJobTimeoutMs &&
          other.systemNotes == this.systemNotes &&
          other.systemDriverName == this.systemDriverName &&
          other.systemQueueName == this.systemQueueName &&
          other.systemSpoolFormat == this.systemSpoolFormat &&
          other.systemUseRawSpool == this.systemUseRawSpool &&
          other.usbVendorId == this.usbVendorId &&
          other.usbProductId == this.usbProductId &&
          other.usbSerialNumber == this.usbSerialNumber &&
          other.usbInterfaceNumber == this.usbInterfaceNumber &&
          other.usbOutEndpoint == this.usbOutEndpoint &&
          other.usbInEndpoint == this.usbInEndpoint &&
          other.usbTimeoutMs == this.usbTimeoutMs &&
          other.usbEncoding == this.usbEncoding &&
          other.usbCodePage == this.usbCodePage &&
          other.usbCharacterTable == this.usbCharacterTable &&
          other.usbAutoCutEnabled == this.usbAutoCutEnabled &&
          other.usbCutMode == this.usbCutMode &&
          other.usbCashDrawerEnabled == this.usbCashDrawerEnabled &&
          other.usbDrawerPin == this.usbDrawerPin &&
          other.usbStatusMonitoringEnabled == this.usbStatusMonitoringEnabled &&
          other.usbManufacturer == this.usbManufacturer &&
          other.usbProductName == this.usbProductName &&
          other.usbAlternateSetting == this.usbAlternateSetting &&
          other.usbPacketDelayMs == this.usbPacketDelayMs &&
          other.rawGraphicsMode == this.rawGraphicsMode &&
          other.isEnabled == this.isEnabled &&
          other.lastStatus == this.lastStatus &&
          other.lastStatusKey == this.lastStatusKey &&
          other.lastStatusMessage == this.lastStatusMessage &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PrintersTableCompanion extends UpdateCompanion<PrintersTableData> {
  final Value<String> id;
  final Value<String> uniqueKey;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> connectionType;
  final Value<String?> address;
  final Value<String?> tcpHost;
  final Value<int?> tcpPort;
  final Value<int?> tcpConnectTimeoutMs;
  final Value<int?> tcpWriteTimeoutMs;
  final Value<int?> tcpReadTimeoutMs;
  final Value<bool> tcpAutoReconnect;
  final Value<int?> tcpReconnectDelayMs;
  final Value<String?> tcpEncoding;
  final Value<String?> tcpCodePage;
  final Value<String?> tcpLineEnding;
  final Value<bool> tcpKeepAlive;
  final Value<bool> tcpNoDelay;
  final Value<int?> tcpLingerSeconds;
  final Value<String?> systemPrinterName;
  final Value<String?> systemPaperSize;
  final Value<int> systemDefaultCopies;
  final Value<bool> systemColorEnabled;
  final Value<String?> systemDuplexMode;
  final Value<String?> systemOrientation;
  final Value<int?> systemJobTimeoutMs;
  final Value<String?> systemNotes;
  final Value<String?> systemDriverName;
  final Value<String?> systemQueueName;
  final Value<String?> systemSpoolFormat;
  final Value<bool> systemUseRawSpool;
  final Value<String?> usbVendorId;
  final Value<String?> usbProductId;
  final Value<String?> usbSerialNumber;
  final Value<int?> usbInterfaceNumber;
  final Value<int?> usbOutEndpoint;
  final Value<int?> usbInEndpoint;
  final Value<int?> usbTimeoutMs;
  final Value<String?> usbEncoding;
  final Value<String?> usbCodePage;
  final Value<String?> usbCharacterTable;
  final Value<bool> usbAutoCutEnabled;
  final Value<String?> usbCutMode;
  final Value<bool> usbCashDrawerEnabled;
  final Value<int?> usbDrawerPin;
  final Value<bool> usbStatusMonitoringEnabled;
  final Value<String?> usbManufacturer;
  final Value<String?> usbProductName;
  final Value<int?> usbAlternateSetting;
  final Value<int?> usbPacketDelayMs;
  final Value<String> rawGraphicsMode;
  final Value<bool> isEnabled;
  final Value<String?> lastStatus;
  final Value<String?> lastStatusKey;
  final Value<String?> lastStatusMessage;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PrintersTableCompanion({
    this.id = const Value.absent(),
    this.uniqueKey = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.connectionType = const Value.absent(),
    this.address = const Value.absent(),
    this.tcpHost = const Value.absent(),
    this.tcpPort = const Value.absent(),
    this.tcpConnectTimeoutMs = const Value.absent(),
    this.tcpWriteTimeoutMs = const Value.absent(),
    this.tcpReadTimeoutMs = const Value.absent(),
    this.tcpAutoReconnect = const Value.absent(),
    this.tcpReconnectDelayMs = const Value.absent(),
    this.tcpEncoding = const Value.absent(),
    this.tcpCodePage = const Value.absent(),
    this.tcpLineEnding = const Value.absent(),
    this.tcpKeepAlive = const Value.absent(),
    this.tcpNoDelay = const Value.absent(),
    this.tcpLingerSeconds = const Value.absent(),
    this.systemPrinterName = const Value.absent(),
    this.systemPaperSize = const Value.absent(),
    this.systemDefaultCopies = const Value.absent(),
    this.systemColorEnabled = const Value.absent(),
    this.systemDuplexMode = const Value.absent(),
    this.systemOrientation = const Value.absent(),
    this.systemJobTimeoutMs = const Value.absent(),
    this.systemNotes = const Value.absent(),
    this.systemDriverName = const Value.absent(),
    this.systemQueueName = const Value.absent(),
    this.systemSpoolFormat = const Value.absent(),
    this.systemUseRawSpool = const Value.absent(),
    this.usbVendorId = const Value.absent(),
    this.usbProductId = const Value.absent(),
    this.usbSerialNumber = const Value.absent(),
    this.usbInterfaceNumber = const Value.absent(),
    this.usbOutEndpoint = const Value.absent(),
    this.usbInEndpoint = const Value.absent(),
    this.usbTimeoutMs = const Value.absent(),
    this.usbEncoding = const Value.absent(),
    this.usbCodePage = const Value.absent(),
    this.usbCharacterTable = const Value.absent(),
    this.usbAutoCutEnabled = const Value.absent(),
    this.usbCutMode = const Value.absent(),
    this.usbCashDrawerEnabled = const Value.absent(),
    this.usbDrawerPin = const Value.absent(),
    this.usbStatusMonitoringEnabled = const Value.absent(),
    this.usbManufacturer = const Value.absent(),
    this.usbProductName = const Value.absent(),
    this.usbAlternateSetting = const Value.absent(),
    this.usbPacketDelayMs = const Value.absent(),
    this.rawGraphicsMode = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.lastStatus = const Value.absent(),
    this.lastStatusKey = const Value.absent(),
    this.lastStatusMessage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PrintersTableCompanion.insert({
    required String id,
    this.uniqueKey = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.connectionType = const Value.absent(),
    this.address = const Value.absent(),
    this.tcpHost = const Value.absent(),
    this.tcpPort = const Value.absent(),
    this.tcpConnectTimeoutMs = const Value.absent(),
    this.tcpWriteTimeoutMs = const Value.absent(),
    this.tcpReadTimeoutMs = const Value.absent(),
    this.tcpAutoReconnect = const Value.absent(),
    this.tcpReconnectDelayMs = const Value.absent(),
    this.tcpEncoding = const Value.absent(),
    this.tcpCodePage = const Value.absent(),
    this.tcpLineEnding = const Value.absent(),
    this.tcpKeepAlive = const Value.absent(),
    this.tcpNoDelay = const Value.absent(),
    this.tcpLingerSeconds = const Value.absent(),
    this.systemPrinterName = const Value.absent(),
    this.systemPaperSize = const Value.absent(),
    this.systemDefaultCopies = const Value.absent(),
    this.systemColorEnabled = const Value.absent(),
    this.systemDuplexMode = const Value.absent(),
    this.systemOrientation = const Value.absent(),
    this.systemJobTimeoutMs = const Value.absent(),
    this.systemNotes = const Value.absent(),
    this.systemDriverName = const Value.absent(),
    this.systemQueueName = const Value.absent(),
    this.systemSpoolFormat = const Value.absent(),
    this.systemUseRawSpool = const Value.absent(),
    this.usbVendorId = const Value.absent(),
    this.usbProductId = const Value.absent(),
    this.usbSerialNumber = const Value.absent(),
    this.usbInterfaceNumber = const Value.absent(),
    this.usbOutEndpoint = const Value.absent(),
    this.usbInEndpoint = const Value.absent(),
    this.usbTimeoutMs = const Value.absent(),
    this.usbEncoding = const Value.absent(),
    this.usbCodePage = const Value.absent(),
    this.usbCharacterTable = const Value.absent(),
    this.usbAutoCutEnabled = const Value.absent(),
    this.usbCutMode = const Value.absent(),
    this.usbCashDrawerEnabled = const Value.absent(),
    this.usbDrawerPin = const Value.absent(),
    this.usbStatusMonitoringEnabled = const Value.absent(),
    this.usbManufacturer = const Value.absent(),
    this.usbProductName = const Value.absent(),
    this.usbAlternateSetting = const Value.absent(),
    this.usbPacketDelayMs = const Value.absent(),
    this.rawGraphicsMode = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.lastStatus = const Value.absent(),
    this.lastStatusKey = const Value.absent(),
    this.lastStatusMessage = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<PrintersTableData> custom({
    Expression<String>? id,
    Expression<String>? uniqueKey,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? connectionType,
    Expression<String>? address,
    Expression<String>? tcpHost,
    Expression<int>? tcpPort,
    Expression<int>? tcpConnectTimeoutMs,
    Expression<int>? tcpWriteTimeoutMs,
    Expression<int>? tcpReadTimeoutMs,
    Expression<bool>? tcpAutoReconnect,
    Expression<int>? tcpReconnectDelayMs,
    Expression<String>? tcpEncoding,
    Expression<String>? tcpCodePage,
    Expression<String>? tcpLineEnding,
    Expression<bool>? tcpKeepAlive,
    Expression<bool>? tcpNoDelay,
    Expression<int>? tcpLingerSeconds,
    Expression<String>? systemPrinterName,
    Expression<String>? systemPaperSize,
    Expression<int>? systemDefaultCopies,
    Expression<bool>? systemColorEnabled,
    Expression<String>? systemDuplexMode,
    Expression<String>? systemOrientation,
    Expression<int>? systemJobTimeoutMs,
    Expression<String>? systemNotes,
    Expression<String>? systemDriverName,
    Expression<String>? systemQueueName,
    Expression<String>? systemSpoolFormat,
    Expression<bool>? systemUseRawSpool,
    Expression<String>? usbVendorId,
    Expression<String>? usbProductId,
    Expression<String>? usbSerialNumber,
    Expression<int>? usbInterfaceNumber,
    Expression<int>? usbOutEndpoint,
    Expression<int>? usbInEndpoint,
    Expression<int>? usbTimeoutMs,
    Expression<String>? usbEncoding,
    Expression<String>? usbCodePage,
    Expression<String>? usbCharacterTable,
    Expression<bool>? usbAutoCutEnabled,
    Expression<String>? usbCutMode,
    Expression<bool>? usbCashDrawerEnabled,
    Expression<int>? usbDrawerPin,
    Expression<bool>? usbStatusMonitoringEnabled,
    Expression<String>? usbManufacturer,
    Expression<String>? usbProductName,
    Expression<int>? usbAlternateSetting,
    Expression<int>? usbPacketDelayMs,
    Expression<String>? rawGraphicsMode,
    Expression<bool>? isEnabled,
    Expression<String>? lastStatus,
    Expression<String>? lastStatusKey,
    Expression<String>? lastStatusMessage,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uniqueKey != null) 'unique_key': uniqueKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (connectionType != null) 'connection_type': connectionType,
      if (address != null) 'address': address,
      if (tcpHost != null) 'tcp_host': tcpHost,
      if (tcpPort != null) 'tcp_port': tcpPort,
      if (tcpConnectTimeoutMs != null)
        'tcp_connect_timeout_ms': tcpConnectTimeoutMs,
      if (tcpWriteTimeoutMs != null) 'tcp_write_timeout_ms': tcpWriteTimeoutMs,
      if (tcpReadTimeoutMs != null) 'tcp_read_timeout_ms': tcpReadTimeoutMs,
      if (tcpAutoReconnect != null) 'tcp_auto_reconnect': tcpAutoReconnect,
      if (tcpReconnectDelayMs != null)
        'tcp_reconnect_delay_ms': tcpReconnectDelayMs,
      if (tcpEncoding != null) 'tcp_encoding': tcpEncoding,
      if (tcpCodePage != null) 'tcp_code_page': tcpCodePage,
      if (tcpLineEnding != null) 'tcp_line_ending': tcpLineEnding,
      if (tcpKeepAlive != null) 'tcp_keep_alive': tcpKeepAlive,
      if (tcpNoDelay != null) 'tcp_no_delay': tcpNoDelay,
      if (tcpLingerSeconds != null) 'tcp_linger_seconds': tcpLingerSeconds,
      if (systemPrinterName != null) 'system_printer_name': systemPrinterName,
      if (systemPaperSize != null) 'system_paper_size': systemPaperSize,
      if (systemDefaultCopies != null)
        'system_default_copies': systemDefaultCopies,
      if (systemColorEnabled != null)
        'system_color_enabled': systemColorEnabled,
      if (systemDuplexMode != null) 'system_duplex_mode': systemDuplexMode,
      if (systemOrientation != null) 'system_orientation': systemOrientation,
      if (systemJobTimeoutMs != null)
        'system_job_timeout_ms': systemJobTimeoutMs,
      if (systemNotes != null) 'system_notes': systemNotes,
      if (systemDriverName != null) 'system_driver_name': systemDriverName,
      if (systemQueueName != null) 'system_queue_name': systemQueueName,
      if (systemSpoolFormat != null) 'system_spool_format': systemSpoolFormat,
      if (systemUseRawSpool != null) 'system_use_raw_spool': systemUseRawSpool,
      if (usbVendorId != null) 'usb_vendor_id': usbVendorId,
      if (usbProductId != null) 'usb_product_id': usbProductId,
      if (usbSerialNumber != null) 'usb_serial_number': usbSerialNumber,
      if (usbInterfaceNumber != null)
        'usb_interface_number': usbInterfaceNumber,
      if (usbOutEndpoint != null) 'usb_out_endpoint': usbOutEndpoint,
      if (usbInEndpoint != null) 'usb_in_endpoint': usbInEndpoint,
      if (usbTimeoutMs != null) 'usb_timeout_ms': usbTimeoutMs,
      if (usbEncoding != null) 'usb_encoding': usbEncoding,
      if (usbCodePage != null) 'usb_code_page': usbCodePage,
      if (usbCharacterTable != null) 'usb_character_table': usbCharacterTable,
      if (usbAutoCutEnabled != null) 'usb_auto_cut_enabled': usbAutoCutEnabled,
      if (usbCutMode != null) 'usb_cut_mode': usbCutMode,
      if (usbCashDrawerEnabled != null)
        'usb_cash_drawer_enabled': usbCashDrawerEnabled,
      if (usbDrawerPin != null) 'usb_drawer_pin': usbDrawerPin,
      if (usbStatusMonitoringEnabled != null)
        'usb_status_monitoring_enabled': usbStatusMonitoringEnabled,
      if (usbManufacturer != null) 'usb_manufacturer': usbManufacturer,
      if (usbProductName != null) 'usb_product_name': usbProductName,
      if (usbAlternateSetting != null)
        'usb_alternate_setting': usbAlternateSetting,
      if (usbPacketDelayMs != null) 'usb_packet_delay_ms': usbPacketDelayMs,
      if (rawGraphicsMode != null) 'raw_graphics_mode': rawGraphicsMode,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (lastStatus != null) 'last_status': lastStatus,
      if (lastStatusKey != null) 'last_status_key': lastStatusKey,
      if (lastStatusMessage != null) 'last_status_message': lastStatusMessage,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PrintersTableCompanion copyWith({
    Value<String>? id,
    Value<String>? uniqueKey,
    Value<String>? name,
    Value<String?>? description,
    Value<String>? connectionType,
    Value<String?>? address,
    Value<String?>? tcpHost,
    Value<int?>? tcpPort,
    Value<int?>? tcpConnectTimeoutMs,
    Value<int?>? tcpWriteTimeoutMs,
    Value<int?>? tcpReadTimeoutMs,
    Value<bool>? tcpAutoReconnect,
    Value<int?>? tcpReconnectDelayMs,
    Value<String?>? tcpEncoding,
    Value<String?>? tcpCodePage,
    Value<String?>? tcpLineEnding,
    Value<bool>? tcpKeepAlive,
    Value<bool>? tcpNoDelay,
    Value<int?>? tcpLingerSeconds,
    Value<String?>? systemPrinterName,
    Value<String?>? systemPaperSize,
    Value<int>? systemDefaultCopies,
    Value<bool>? systemColorEnabled,
    Value<String?>? systemDuplexMode,
    Value<String?>? systemOrientation,
    Value<int?>? systemJobTimeoutMs,
    Value<String?>? systemNotes,
    Value<String?>? systemDriverName,
    Value<String?>? systemQueueName,
    Value<String?>? systemSpoolFormat,
    Value<bool>? systemUseRawSpool,
    Value<String?>? usbVendorId,
    Value<String?>? usbProductId,
    Value<String?>? usbSerialNumber,
    Value<int?>? usbInterfaceNumber,
    Value<int?>? usbOutEndpoint,
    Value<int?>? usbInEndpoint,
    Value<int?>? usbTimeoutMs,
    Value<String?>? usbEncoding,
    Value<String?>? usbCodePage,
    Value<String?>? usbCharacterTable,
    Value<bool>? usbAutoCutEnabled,
    Value<String?>? usbCutMode,
    Value<bool>? usbCashDrawerEnabled,
    Value<int?>? usbDrawerPin,
    Value<bool>? usbStatusMonitoringEnabled,
    Value<String?>? usbManufacturer,
    Value<String?>? usbProductName,
    Value<int?>? usbAlternateSetting,
    Value<int?>? usbPacketDelayMs,
    Value<String>? rawGraphicsMode,
    Value<bool>? isEnabled,
    Value<String?>? lastStatus,
    Value<String?>? lastStatusKey,
    Value<String?>? lastStatusMessage,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return PrintersTableCompanion(
      id: id ?? this.id,
      uniqueKey: uniqueKey ?? this.uniqueKey,
      name: name ?? this.name,
      description: description ?? this.description,
      connectionType: connectionType ?? this.connectionType,
      address: address ?? this.address,
      tcpHost: tcpHost ?? this.tcpHost,
      tcpPort: tcpPort ?? this.tcpPort,
      tcpConnectTimeoutMs: tcpConnectTimeoutMs ?? this.tcpConnectTimeoutMs,
      tcpWriteTimeoutMs: tcpWriteTimeoutMs ?? this.tcpWriteTimeoutMs,
      tcpReadTimeoutMs: tcpReadTimeoutMs ?? this.tcpReadTimeoutMs,
      tcpAutoReconnect: tcpAutoReconnect ?? this.tcpAutoReconnect,
      tcpReconnectDelayMs: tcpReconnectDelayMs ?? this.tcpReconnectDelayMs,
      tcpEncoding: tcpEncoding ?? this.tcpEncoding,
      tcpCodePage: tcpCodePage ?? this.tcpCodePage,
      tcpLineEnding: tcpLineEnding ?? this.tcpLineEnding,
      tcpKeepAlive: tcpKeepAlive ?? this.tcpKeepAlive,
      tcpNoDelay: tcpNoDelay ?? this.tcpNoDelay,
      tcpLingerSeconds: tcpLingerSeconds ?? this.tcpLingerSeconds,
      systemPrinterName: systemPrinterName ?? this.systemPrinterName,
      systemPaperSize: systemPaperSize ?? this.systemPaperSize,
      systemDefaultCopies: systemDefaultCopies ?? this.systemDefaultCopies,
      systemColorEnabled: systemColorEnabled ?? this.systemColorEnabled,
      systemDuplexMode: systemDuplexMode ?? this.systemDuplexMode,
      systemOrientation: systemOrientation ?? this.systemOrientation,
      systemJobTimeoutMs: systemJobTimeoutMs ?? this.systemJobTimeoutMs,
      systemNotes: systemNotes ?? this.systemNotes,
      systemDriverName: systemDriverName ?? this.systemDriverName,
      systemQueueName: systemQueueName ?? this.systemQueueName,
      systemSpoolFormat: systemSpoolFormat ?? this.systemSpoolFormat,
      systemUseRawSpool: systemUseRawSpool ?? this.systemUseRawSpool,
      usbVendorId: usbVendorId ?? this.usbVendorId,
      usbProductId: usbProductId ?? this.usbProductId,
      usbSerialNumber: usbSerialNumber ?? this.usbSerialNumber,
      usbInterfaceNumber: usbInterfaceNumber ?? this.usbInterfaceNumber,
      usbOutEndpoint: usbOutEndpoint ?? this.usbOutEndpoint,
      usbInEndpoint: usbInEndpoint ?? this.usbInEndpoint,
      usbTimeoutMs: usbTimeoutMs ?? this.usbTimeoutMs,
      usbEncoding: usbEncoding ?? this.usbEncoding,
      usbCodePage: usbCodePage ?? this.usbCodePage,
      usbCharacterTable: usbCharacterTable ?? this.usbCharacterTable,
      usbAutoCutEnabled: usbAutoCutEnabled ?? this.usbAutoCutEnabled,
      usbCutMode: usbCutMode ?? this.usbCutMode,
      usbCashDrawerEnabled: usbCashDrawerEnabled ?? this.usbCashDrawerEnabled,
      usbDrawerPin: usbDrawerPin ?? this.usbDrawerPin,
      usbStatusMonitoringEnabled:
          usbStatusMonitoringEnabled ?? this.usbStatusMonitoringEnabled,
      usbManufacturer: usbManufacturer ?? this.usbManufacturer,
      usbProductName: usbProductName ?? this.usbProductName,
      usbAlternateSetting: usbAlternateSetting ?? this.usbAlternateSetting,
      usbPacketDelayMs: usbPacketDelayMs ?? this.usbPacketDelayMs,
      rawGraphicsMode: rawGraphicsMode ?? this.rawGraphicsMode,
      isEnabled: isEnabled ?? this.isEnabled,
      lastStatus: lastStatus ?? this.lastStatus,
      lastStatusKey: lastStatusKey ?? this.lastStatusKey,
      lastStatusMessage: lastStatusMessage ?? this.lastStatusMessage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (uniqueKey.present) {
      map['unique_key'] = Variable<String>(uniqueKey.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (connectionType.present) {
      map['connection_type'] = Variable<String>(connectionType.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (tcpHost.present) {
      map['tcp_host'] = Variable<String>(tcpHost.value);
    }
    if (tcpPort.present) {
      map['tcp_port'] = Variable<int>(tcpPort.value);
    }
    if (tcpConnectTimeoutMs.present) {
      map['tcp_connect_timeout_ms'] = Variable<int>(tcpConnectTimeoutMs.value);
    }
    if (tcpWriteTimeoutMs.present) {
      map['tcp_write_timeout_ms'] = Variable<int>(tcpWriteTimeoutMs.value);
    }
    if (tcpReadTimeoutMs.present) {
      map['tcp_read_timeout_ms'] = Variable<int>(tcpReadTimeoutMs.value);
    }
    if (tcpAutoReconnect.present) {
      map['tcp_auto_reconnect'] = Variable<bool>(tcpAutoReconnect.value);
    }
    if (tcpReconnectDelayMs.present) {
      map['tcp_reconnect_delay_ms'] = Variable<int>(tcpReconnectDelayMs.value);
    }
    if (tcpEncoding.present) {
      map['tcp_encoding'] = Variable<String>(tcpEncoding.value);
    }
    if (tcpCodePage.present) {
      map['tcp_code_page'] = Variable<String>(tcpCodePage.value);
    }
    if (tcpLineEnding.present) {
      map['tcp_line_ending'] = Variable<String>(tcpLineEnding.value);
    }
    if (tcpKeepAlive.present) {
      map['tcp_keep_alive'] = Variable<bool>(tcpKeepAlive.value);
    }
    if (tcpNoDelay.present) {
      map['tcp_no_delay'] = Variable<bool>(tcpNoDelay.value);
    }
    if (tcpLingerSeconds.present) {
      map['tcp_linger_seconds'] = Variable<int>(tcpLingerSeconds.value);
    }
    if (systemPrinterName.present) {
      map['system_printer_name'] = Variable<String>(systemPrinterName.value);
    }
    if (systemPaperSize.present) {
      map['system_paper_size'] = Variable<String>(systemPaperSize.value);
    }
    if (systemDefaultCopies.present) {
      map['system_default_copies'] = Variable<int>(systemDefaultCopies.value);
    }
    if (systemColorEnabled.present) {
      map['system_color_enabled'] = Variable<bool>(systemColorEnabled.value);
    }
    if (systemDuplexMode.present) {
      map['system_duplex_mode'] = Variable<String>(systemDuplexMode.value);
    }
    if (systemOrientation.present) {
      map['system_orientation'] = Variable<String>(systemOrientation.value);
    }
    if (systemJobTimeoutMs.present) {
      map['system_job_timeout_ms'] = Variable<int>(systemJobTimeoutMs.value);
    }
    if (systemNotes.present) {
      map['system_notes'] = Variable<String>(systemNotes.value);
    }
    if (systemDriverName.present) {
      map['system_driver_name'] = Variable<String>(systemDriverName.value);
    }
    if (systemQueueName.present) {
      map['system_queue_name'] = Variable<String>(systemQueueName.value);
    }
    if (systemSpoolFormat.present) {
      map['system_spool_format'] = Variable<String>(systemSpoolFormat.value);
    }
    if (systemUseRawSpool.present) {
      map['system_use_raw_spool'] = Variable<bool>(systemUseRawSpool.value);
    }
    if (usbVendorId.present) {
      map['usb_vendor_id'] = Variable<String>(usbVendorId.value);
    }
    if (usbProductId.present) {
      map['usb_product_id'] = Variable<String>(usbProductId.value);
    }
    if (usbSerialNumber.present) {
      map['usb_serial_number'] = Variable<String>(usbSerialNumber.value);
    }
    if (usbInterfaceNumber.present) {
      map['usb_interface_number'] = Variable<int>(usbInterfaceNumber.value);
    }
    if (usbOutEndpoint.present) {
      map['usb_out_endpoint'] = Variable<int>(usbOutEndpoint.value);
    }
    if (usbInEndpoint.present) {
      map['usb_in_endpoint'] = Variable<int>(usbInEndpoint.value);
    }
    if (usbTimeoutMs.present) {
      map['usb_timeout_ms'] = Variable<int>(usbTimeoutMs.value);
    }
    if (usbEncoding.present) {
      map['usb_encoding'] = Variable<String>(usbEncoding.value);
    }
    if (usbCodePage.present) {
      map['usb_code_page'] = Variable<String>(usbCodePage.value);
    }
    if (usbCharacterTable.present) {
      map['usb_character_table'] = Variable<String>(usbCharacterTable.value);
    }
    if (usbAutoCutEnabled.present) {
      map['usb_auto_cut_enabled'] = Variable<bool>(usbAutoCutEnabled.value);
    }
    if (usbCutMode.present) {
      map['usb_cut_mode'] = Variable<String>(usbCutMode.value);
    }
    if (usbCashDrawerEnabled.present) {
      map['usb_cash_drawer_enabled'] = Variable<bool>(
        usbCashDrawerEnabled.value,
      );
    }
    if (usbDrawerPin.present) {
      map['usb_drawer_pin'] = Variable<int>(usbDrawerPin.value);
    }
    if (usbStatusMonitoringEnabled.present) {
      map['usb_status_monitoring_enabled'] = Variable<bool>(
        usbStatusMonitoringEnabled.value,
      );
    }
    if (usbManufacturer.present) {
      map['usb_manufacturer'] = Variable<String>(usbManufacturer.value);
    }
    if (usbProductName.present) {
      map['usb_product_name'] = Variable<String>(usbProductName.value);
    }
    if (usbAlternateSetting.present) {
      map['usb_alternate_setting'] = Variable<int>(usbAlternateSetting.value);
    }
    if (usbPacketDelayMs.present) {
      map['usb_packet_delay_ms'] = Variable<int>(usbPacketDelayMs.value);
    }
    if (rawGraphicsMode.present) {
      map['raw_graphics_mode'] = Variable<String>(rawGraphicsMode.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (lastStatus.present) {
      map['last_status'] = Variable<String>(lastStatus.value);
    }
    if (lastStatusKey.present) {
      map['last_status_key'] = Variable<String>(lastStatusKey.value);
    }
    if (lastStatusMessage.present) {
      map['last_status_message'] = Variable<String>(lastStatusMessage.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrintersTableCompanion(')
          ..write('id: $id, ')
          ..write('uniqueKey: $uniqueKey, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('connectionType: $connectionType, ')
          ..write('address: $address, ')
          ..write('tcpHost: $tcpHost, ')
          ..write('tcpPort: $tcpPort, ')
          ..write('tcpConnectTimeoutMs: $tcpConnectTimeoutMs, ')
          ..write('tcpWriteTimeoutMs: $tcpWriteTimeoutMs, ')
          ..write('tcpReadTimeoutMs: $tcpReadTimeoutMs, ')
          ..write('tcpAutoReconnect: $tcpAutoReconnect, ')
          ..write('tcpReconnectDelayMs: $tcpReconnectDelayMs, ')
          ..write('tcpEncoding: $tcpEncoding, ')
          ..write('tcpCodePage: $tcpCodePage, ')
          ..write('tcpLineEnding: $tcpLineEnding, ')
          ..write('tcpKeepAlive: $tcpKeepAlive, ')
          ..write('tcpNoDelay: $tcpNoDelay, ')
          ..write('tcpLingerSeconds: $tcpLingerSeconds, ')
          ..write('systemPrinterName: $systemPrinterName, ')
          ..write('systemPaperSize: $systemPaperSize, ')
          ..write('systemDefaultCopies: $systemDefaultCopies, ')
          ..write('systemColorEnabled: $systemColorEnabled, ')
          ..write('systemDuplexMode: $systemDuplexMode, ')
          ..write('systemOrientation: $systemOrientation, ')
          ..write('systemJobTimeoutMs: $systemJobTimeoutMs, ')
          ..write('systemNotes: $systemNotes, ')
          ..write('systemDriverName: $systemDriverName, ')
          ..write('systemQueueName: $systemQueueName, ')
          ..write('systemSpoolFormat: $systemSpoolFormat, ')
          ..write('systemUseRawSpool: $systemUseRawSpool, ')
          ..write('usbVendorId: $usbVendorId, ')
          ..write('usbProductId: $usbProductId, ')
          ..write('usbSerialNumber: $usbSerialNumber, ')
          ..write('usbInterfaceNumber: $usbInterfaceNumber, ')
          ..write('usbOutEndpoint: $usbOutEndpoint, ')
          ..write('usbInEndpoint: $usbInEndpoint, ')
          ..write('usbTimeoutMs: $usbTimeoutMs, ')
          ..write('usbEncoding: $usbEncoding, ')
          ..write('usbCodePage: $usbCodePage, ')
          ..write('usbCharacterTable: $usbCharacterTable, ')
          ..write('usbAutoCutEnabled: $usbAutoCutEnabled, ')
          ..write('usbCutMode: $usbCutMode, ')
          ..write('usbCashDrawerEnabled: $usbCashDrawerEnabled, ')
          ..write('usbDrawerPin: $usbDrawerPin, ')
          ..write('usbStatusMonitoringEnabled: $usbStatusMonitoringEnabled, ')
          ..write('usbManufacturer: $usbManufacturer, ')
          ..write('usbProductName: $usbProductName, ')
          ..write('usbAlternateSetting: $usbAlternateSetting, ')
          ..write('usbPacketDelayMs: $usbPacketDelayMs, ')
          ..write('rawGraphicsMode: $rawGraphicsMode, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('lastStatus: $lastStatus, ')
          ..write('lastStatusKey: $lastStatusKey, ')
          ..write('lastStatusMessage: $lastStatusMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppsTableTable extends AppsTable
    with TableInfo<$AppsTableTable, AppsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _apiKeyMeta = const VerificationMeta('apiKey');
  @override
  late final GeneratedColumn<String> apiKey = GeneratedColumn<String>(
    'api_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    isEnabled,
    description,
    apiKey,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'apps_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('api_key')) {
      context.handle(
        _apiKeyMeta,
        apiKey.isAcceptableOrUnknown(data['api_key']!, _apiKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_apiKeyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      apiKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}api_key'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AppsTableTable createAlias(String alias) {
    return $AppsTableTable(attachedDatabase, alias);
  }
}

class AppsTableData extends DataClass implements Insertable<AppsTableData> {
  final String id;
  final String name;
  final bool isEnabled;
  final String? description;
  final String apiKey;
  final DateTime createdAt;
  final DateTime updatedAt;
  const AppsTableData({
    required this.id,
    required this.name,
    required this.isEnabled,
    this.description,
    required this.apiKey,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['is_enabled'] = Variable<bool>(isEnabled);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['api_key'] = Variable<String>(apiKey);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppsTableCompanion toCompanion(bool nullToAbsent) {
    return AppsTableCompanion(
      id: Value(id),
      name: Value(name),
      isEnabled: Value(isEnabled),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      apiKey: Value(apiKey),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppsTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      description: serializer.fromJson<String?>(json['description']),
      apiKey: serializer.fromJson<String>(json['apiKey']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'description': serializer.toJson<String?>(description),
      'apiKey': serializer.toJson<String>(apiKey),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppsTableData copyWith({
    String? id,
    String? name,
    bool? isEnabled,
    Value<String?> description = const Value.absent(),
    String? apiKey,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => AppsTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    isEnabled: isEnabled ?? this.isEnabled,
    description: description.present ? description.value : this.description,
    apiKey: apiKey ?? this.apiKey,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AppsTableData copyWithCompanion(AppsTableCompanion data) {
    return AppsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      description: data.description.present
          ? data.description.value
          : this.description,
      apiKey: data.apiKey.present ? data.apiKey.value : this.apiKey,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('description: $description, ')
          ..write('apiKey: $apiKey, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    isEnabled,
    description,
    apiKey,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.isEnabled == this.isEnabled &&
          other.description == this.description &&
          other.apiKey == this.apiKey &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AppsTableCompanion extends UpdateCompanion<AppsTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<bool> isEnabled;
  final Value<String?> description;
  final Value<String> apiKey;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AppsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.description = const Value.absent(),
    this.apiKey = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppsTableCompanion.insert({
    required String id,
    required String name,
    this.isEnabled = const Value.absent(),
    this.description = const Value.absent(),
    required String apiKey,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       apiKey = Value(apiKey),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<AppsTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<bool>? isEnabled,
    Expression<String>? description,
    Expression<String>? apiKey,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (description != null) 'description': description,
      if (apiKey != null) 'api_key': apiKey,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<bool>? isEnabled,
    Value<String?>? description,
    Value<String>? apiKey,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AppsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      isEnabled: isEnabled ?? this.isEnabled,
      description: description ?? this.description,
      apiKey: apiKey ?? this.apiKey,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (apiKey.present) {
      map['api_key'] = Variable<String>(apiKey.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('description: $description, ')
          ..write('apiKey: $apiKey, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppPrintersTableTable extends AppPrintersTable
    with TableInfo<$AppPrintersTableTable, AppPrintersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppPrintersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _appIdMeta = const VerificationMeta('appId');
  @override
  late final GeneratedColumn<String> appId = GeneratedColumn<String>(
    'app_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES apps_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _printerIdMeta = const VerificationMeta(
    'printerId',
  );
  @override
  late final GeneratedColumn<String> printerId = GeneratedColumn<String>(
    'printer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES printers_table (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [appId, printerId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_printers_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppPrintersTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('app_id')) {
      context.handle(
        _appIdMeta,
        appId.isAcceptableOrUnknown(data['app_id']!, _appIdMeta),
      );
    } else if (isInserting) {
      context.missing(_appIdMeta);
    }
    if (data.containsKey('printer_id')) {
      context.handle(
        _printerIdMeta,
        printerId.isAcceptableOrUnknown(data['printer_id']!, _printerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_printerIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {appId, printerId};
  @override
  AppPrintersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppPrintersTableData(
      appId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}app_id'],
      )!,
      printerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}printer_id'],
      )!,
    );
  }

  @override
  $AppPrintersTableTable createAlias(String alias) {
    return $AppPrintersTableTable(attachedDatabase, alias);
  }
}

class AppPrintersTableData extends DataClass
    implements Insertable<AppPrintersTableData> {
  final String appId;
  final String printerId;
  const AppPrintersTableData({required this.appId, required this.printerId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['app_id'] = Variable<String>(appId);
    map['printer_id'] = Variable<String>(printerId);
    return map;
  }

  AppPrintersTableCompanion toCompanion(bool nullToAbsent) {
    return AppPrintersTableCompanion(
      appId: Value(appId),
      printerId: Value(printerId),
    );
  }

  factory AppPrintersTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppPrintersTableData(
      appId: serializer.fromJson<String>(json['appId']),
      printerId: serializer.fromJson<String>(json['printerId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'appId': serializer.toJson<String>(appId),
      'printerId': serializer.toJson<String>(printerId),
    };
  }

  AppPrintersTableData copyWith({String? appId, String? printerId}) =>
      AppPrintersTableData(
        appId: appId ?? this.appId,
        printerId: printerId ?? this.printerId,
      );
  AppPrintersTableData copyWithCompanion(AppPrintersTableCompanion data) {
    return AppPrintersTableData(
      appId: data.appId.present ? data.appId.value : this.appId,
      printerId: data.printerId.present ? data.printerId.value : this.printerId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppPrintersTableData(')
          ..write('appId: $appId, ')
          ..write('printerId: $printerId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(appId, printerId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppPrintersTableData &&
          other.appId == this.appId &&
          other.printerId == this.printerId);
}

class AppPrintersTableCompanion extends UpdateCompanion<AppPrintersTableData> {
  final Value<String> appId;
  final Value<String> printerId;
  final Value<int> rowid;
  const AppPrintersTableCompanion({
    this.appId = const Value.absent(),
    this.printerId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppPrintersTableCompanion.insert({
    required String appId,
    required String printerId,
    this.rowid = const Value.absent(),
  }) : appId = Value(appId),
       printerId = Value(printerId);
  static Insertable<AppPrintersTableData> custom({
    Expression<String>? appId,
    Expression<String>? printerId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (appId != null) 'app_id': appId,
      if (printerId != null) 'printer_id': printerId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppPrintersTableCompanion copyWith({
    Value<String>? appId,
    Value<String>? printerId,
    Value<int>? rowid,
  }) {
    return AppPrintersTableCompanion(
      appId: appId ?? this.appId,
      printerId: printerId ?? this.printerId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (appId.present) {
      map['app_id'] = Variable<String>(appId.value);
    }
    if (printerId.present) {
      map['printer_id'] = Variable<String>(printerId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppPrintersTableCompanion(')
          ..write('appId: $appId, ')
          ..write('printerId: $printerId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PrintJobsTableTable extends PrintJobsTable
    with TableInfo<$PrintJobsTableTable, PrintJobsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrintJobsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _printerIdMeta = const VerificationMeta(
    'printerId',
  );
  @override
  late final GeneratedColumn<String> printerId = GeneratedColumn<String>(
    'printer_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _appIdMeta = const VerificationMeta('appId');
  @override
  late final GeneratedColumn<String> appId = GeneratedColumn<String>(
    'app_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('accepted'),
  );
  static const VerificationMeta _contentTypeMeta = const VerificationMeta(
    'contentType',
  );
  @override
  late final GeneratedColumn<String> contentType = GeneratedColumn<String>(
    'content_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _copiesMeta = const VerificationMeta('copies');
  @override
  late final GeneratedColumn<int> copies = GeneratedColumn<int>(
    'copies',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _payloadSourceTypeMeta = const VerificationMeta(
    'payloadSourceType',
  );
  @override
  late final GeneratedColumn<String> payloadSourceType =
      GeneratedColumn<String>(
        'payload_source_type',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _payloadSummaryMeta = const VerificationMeta(
    'payloadSummary',
  );
  @override
  late final GeneratedColumn<String> payloadSummary = GeneratedColumn<String>(
    'payload_summary',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _artifactPathMeta = const VerificationMeta(
    'artifactPath',
  );
  @override
  late final GeneratedColumn<String> artifactPath = GeneratedColumn<String>(
    'artifact_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _artifactMimeTypeMeta = const VerificationMeta(
    'artifactMimeType',
  );
  @override
  late final GeneratedColumn<String> artifactMimeType = GeneratedColumn<String>(
    'artifact_mime_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _artifactSizeMeta = const VerificationMeta(
    'artifactSize',
  );
  @override
  late final GeneratedColumn<int> artifactSize = GeneratedColumn<int>(
    'artifact_size',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _artifactCreatedAtMeta = const VerificationMeta(
    'artifactCreatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> artifactCreatedAt =
      GeneratedColumn<DateTime>(
        'artifact_created_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _artifactChecksumMeta = const VerificationMeta(
    'artifactChecksum',
  );
  @override
  late final GeneratedColumn<String> artifactChecksum = GeneratedColumn<String>(
    'artifact_checksum',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _optionsJsonMeta = const VerificationMeta(
    'optionsJson',
  );
  @override
  late final GeneratedColumn<String> optionsJson = GeneratedColumn<String>(
    'options_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _metaJsonMeta = const VerificationMeta(
    'metaJson',
  );
  @override
  late final GeneratedColumn<String> metaJson = GeneratedColumn<String>(
    'meta_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _referenceTypeMeta = const VerificationMeta(
    'referenceType',
  );
  @override
  late final GeneratedColumn<String> referenceType = GeneratedColumn<String>(
    'reference_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _referenceIdMeta = const VerificationMeta(
    'referenceId',
  );
  @override
  late final GeneratedColumn<String> referenceId = GeneratedColumn<String>(
    'reference_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idempotencyKeyMeta = const VerificationMeta(
    'idempotencyKey',
  );
  @override
  late final GeneratedColumn<String> idempotencyKey = GeneratedColumn<String>(
    'idempotency_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _failureCategoryMeta = const VerificationMeta(
    'failureCategory',
  );
  @override
  late final GeneratedColumn<String> failureCategory = GeneratedColumn<String>(
    'failure_category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _failureMessageMeta = const VerificationMeta(
    'failureMessage',
  );
  @override
  late final GeneratedColumn<String> failureMessage = GeneratedColumn<String>(
    'failure_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastRetryAtMeta = const VerificationMeta(
    'lastRetryAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastRetryAt = GeneratedColumn<DateTime>(
    'last_retry_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextRetryAtMeta = const VerificationMeta(
    'nextRetryAt',
  );
  @override
  late final GeneratedColumn<DateTime> nextRetryAt = GeneratedColumn<DateTime>(
    'next_retry_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _queuedAtMeta = const VerificationMeta(
    'queuedAt',
  );
  @override
  late final GeneratedColumn<DateTime> queuedAt = GeneratedColumn<DateTime>(
    'queued_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _canceledAtMeta = const VerificationMeta(
    'canceledAt',
  );
  @override
  late final GeneratedColumn<DateTime> canceledAt = GeneratedColumn<DateTime>(
    'canceled_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    printerId,
    appId,
    title,
    status,
    contentType,
    copies,
    payloadSourceType,
    payloadSummary,
    artifactPath,
    artifactMimeType,
    artifactSize,
    artifactCreatedAt,
    artifactChecksum,
    optionsJson,
    metaJson,
    referenceType,
    referenceId,
    source,
    idempotencyKey,
    failureCategory,
    failureMessage,
    retryCount,
    lastRetryAt,
    nextRetryAt,
    queuedAt,
    startedAt,
    completedAt,
    canceledAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'print_jobs_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PrintJobsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('printer_id')) {
      context.handle(
        _printerIdMeta,
        printerId.isAcceptableOrUnknown(data['printer_id']!, _printerIdMeta),
      );
    }
    if (data.containsKey('app_id')) {
      context.handle(
        _appIdMeta,
        appId.isAcceptableOrUnknown(data['app_id']!, _appIdMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('content_type')) {
      context.handle(
        _contentTypeMeta,
        contentType.isAcceptableOrUnknown(
          data['content_type']!,
          _contentTypeMeta,
        ),
      );
    }
    if (data.containsKey('copies')) {
      context.handle(
        _copiesMeta,
        copies.isAcceptableOrUnknown(data['copies']!, _copiesMeta),
      );
    }
    if (data.containsKey('payload_source_type')) {
      context.handle(
        _payloadSourceTypeMeta,
        payloadSourceType.isAcceptableOrUnknown(
          data['payload_source_type']!,
          _payloadSourceTypeMeta,
        ),
      );
    }
    if (data.containsKey('payload_summary')) {
      context.handle(
        _payloadSummaryMeta,
        payloadSummary.isAcceptableOrUnknown(
          data['payload_summary']!,
          _payloadSummaryMeta,
        ),
      );
    }
    if (data.containsKey('artifact_path')) {
      context.handle(
        _artifactPathMeta,
        artifactPath.isAcceptableOrUnknown(
          data['artifact_path']!,
          _artifactPathMeta,
        ),
      );
    }
    if (data.containsKey('artifact_mime_type')) {
      context.handle(
        _artifactMimeTypeMeta,
        artifactMimeType.isAcceptableOrUnknown(
          data['artifact_mime_type']!,
          _artifactMimeTypeMeta,
        ),
      );
    }
    if (data.containsKey('artifact_size')) {
      context.handle(
        _artifactSizeMeta,
        artifactSize.isAcceptableOrUnknown(
          data['artifact_size']!,
          _artifactSizeMeta,
        ),
      );
    }
    if (data.containsKey('artifact_created_at')) {
      context.handle(
        _artifactCreatedAtMeta,
        artifactCreatedAt.isAcceptableOrUnknown(
          data['artifact_created_at']!,
          _artifactCreatedAtMeta,
        ),
      );
    }
    if (data.containsKey('artifact_checksum')) {
      context.handle(
        _artifactChecksumMeta,
        artifactChecksum.isAcceptableOrUnknown(
          data['artifact_checksum']!,
          _artifactChecksumMeta,
        ),
      );
    }
    if (data.containsKey('options_json')) {
      context.handle(
        _optionsJsonMeta,
        optionsJson.isAcceptableOrUnknown(
          data['options_json']!,
          _optionsJsonMeta,
        ),
      );
    }
    if (data.containsKey('meta_json')) {
      context.handle(
        _metaJsonMeta,
        metaJson.isAcceptableOrUnknown(data['meta_json']!, _metaJsonMeta),
      );
    }
    if (data.containsKey('reference_type')) {
      context.handle(
        _referenceTypeMeta,
        referenceType.isAcceptableOrUnknown(
          data['reference_type']!,
          _referenceTypeMeta,
        ),
      );
    }
    if (data.containsKey('reference_id')) {
      context.handle(
        _referenceIdMeta,
        referenceId.isAcceptableOrUnknown(
          data['reference_id']!,
          _referenceIdMeta,
        ),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('idempotency_key')) {
      context.handle(
        _idempotencyKeyMeta,
        idempotencyKey.isAcceptableOrUnknown(
          data['idempotency_key']!,
          _idempotencyKeyMeta,
        ),
      );
    }
    if (data.containsKey('failure_category')) {
      context.handle(
        _failureCategoryMeta,
        failureCategory.isAcceptableOrUnknown(
          data['failure_category']!,
          _failureCategoryMeta,
        ),
      );
    }
    if (data.containsKey('failure_message')) {
      context.handle(
        _failureMessageMeta,
        failureMessage.isAcceptableOrUnknown(
          data['failure_message']!,
          _failureMessageMeta,
        ),
      );
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('last_retry_at')) {
      context.handle(
        _lastRetryAtMeta,
        lastRetryAt.isAcceptableOrUnknown(
          data['last_retry_at']!,
          _lastRetryAtMeta,
        ),
      );
    }
    if (data.containsKey('next_retry_at')) {
      context.handle(
        _nextRetryAtMeta,
        nextRetryAt.isAcceptableOrUnknown(
          data['next_retry_at']!,
          _nextRetryAtMeta,
        ),
      );
    }
    if (data.containsKey('queued_at')) {
      context.handle(
        _queuedAtMeta,
        queuedAt.isAcceptableOrUnknown(data['queued_at']!, _queuedAtMeta),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('canceled_at')) {
      context.handle(
        _canceledAtMeta,
        canceledAt.isAcceptableOrUnknown(data['canceled_at']!, _canceledAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PrintJobsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrintJobsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      printerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}printer_id'],
      ),
      appId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}app_id'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      contentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_type'],
      ),
      copies: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}copies'],
      )!,
      payloadSourceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_source_type'],
      ),
      payloadSummary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_summary'],
      ),
      artifactPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artifact_path'],
      ),
      artifactMimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artifact_mime_type'],
      ),
      artifactSize: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}artifact_size'],
      ),
      artifactCreatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}artifact_created_at'],
      ),
      artifactChecksum: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artifact_checksum'],
      ),
      optionsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}options_json'],
      ),
      metaJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meta_json'],
      ),
      referenceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_type'],
      ),
      referenceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_id'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      ),
      idempotencyKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}idempotency_key'],
      ),
      failureCategory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}failure_category'],
      ),
      failureMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}failure_message'],
      ),
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      lastRetryAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_retry_at'],
      ),
      nextRetryAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_retry_at'],
      ),
      queuedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}queued_at'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      canceledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}canceled_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PrintJobsTableTable createAlias(String alias) {
    return $PrintJobsTableTable(attachedDatabase, alias);
  }
}

class PrintJobsTableData extends DataClass
    implements Insertable<PrintJobsTableData> {
  final String id;
  final String? printerId;
  final String? appId;
  final String title;
  final String status;
  final String? contentType;
  final int copies;
  final String? payloadSourceType;
  final String? payloadSummary;
  final String? artifactPath;
  final String? artifactMimeType;
  final int? artifactSize;
  final DateTime? artifactCreatedAt;
  final String? artifactChecksum;
  final String? optionsJson;
  final String? metaJson;
  final String? referenceType;
  final String? referenceId;
  final String? source;
  final String? idempotencyKey;
  final String? failureCategory;
  final String? failureMessage;
  final int retryCount;
  final DateTime? lastRetryAt;
  final DateTime? nextRetryAt;
  final DateTime? queuedAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final DateTime? canceledAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PrintJobsTableData({
    required this.id,
    this.printerId,
    this.appId,
    required this.title,
    required this.status,
    this.contentType,
    required this.copies,
    this.payloadSourceType,
    this.payloadSummary,
    this.artifactPath,
    this.artifactMimeType,
    this.artifactSize,
    this.artifactCreatedAt,
    this.artifactChecksum,
    this.optionsJson,
    this.metaJson,
    this.referenceType,
    this.referenceId,
    this.source,
    this.idempotencyKey,
    this.failureCategory,
    this.failureMessage,
    required this.retryCount,
    this.lastRetryAt,
    this.nextRetryAt,
    this.queuedAt,
    this.startedAt,
    this.completedAt,
    this.canceledAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || printerId != null) {
      map['printer_id'] = Variable<String>(printerId);
    }
    if (!nullToAbsent || appId != null) {
      map['app_id'] = Variable<String>(appId);
    }
    map['title'] = Variable<String>(title);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || contentType != null) {
      map['content_type'] = Variable<String>(contentType);
    }
    map['copies'] = Variable<int>(copies);
    if (!nullToAbsent || payloadSourceType != null) {
      map['payload_source_type'] = Variable<String>(payloadSourceType);
    }
    if (!nullToAbsent || payloadSummary != null) {
      map['payload_summary'] = Variable<String>(payloadSummary);
    }
    if (!nullToAbsent || artifactPath != null) {
      map['artifact_path'] = Variable<String>(artifactPath);
    }
    if (!nullToAbsent || artifactMimeType != null) {
      map['artifact_mime_type'] = Variable<String>(artifactMimeType);
    }
    if (!nullToAbsent || artifactSize != null) {
      map['artifact_size'] = Variable<int>(artifactSize);
    }
    if (!nullToAbsent || artifactCreatedAt != null) {
      map['artifact_created_at'] = Variable<DateTime>(artifactCreatedAt);
    }
    if (!nullToAbsent || artifactChecksum != null) {
      map['artifact_checksum'] = Variable<String>(artifactChecksum);
    }
    if (!nullToAbsent || optionsJson != null) {
      map['options_json'] = Variable<String>(optionsJson);
    }
    if (!nullToAbsent || metaJson != null) {
      map['meta_json'] = Variable<String>(metaJson);
    }
    if (!nullToAbsent || referenceType != null) {
      map['reference_type'] = Variable<String>(referenceType);
    }
    if (!nullToAbsent || referenceId != null) {
      map['reference_id'] = Variable<String>(referenceId);
    }
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    if (!nullToAbsent || idempotencyKey != null) {
      map['idempotency_key'] = Variable<String>(idempotencyKey);
    }
    if (!nullToAbsent || failureCategory != null) {
      map['failure_category'] = Variable<String>(failureCategory);
    }
    if (!nullToAbsent || failureMessage != null) {
      map['failure_message'] = Variable<String>(failureMessage);
    }
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || lastRetryAt != null) {
      map['last_retry_at'] = Variable<DateTime>(lastRetryAt);
    }
    if (!nullToAbsent || nextRetryAt != null) {
      map['next_retry_at'] = Variable<DateTime>(nextRetryAt);
    }
    if (!nullToAbsent || queuedAt != null) {
      map['queued_at'] = Variable<DateTime>(queuedAt);
    }
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<DateTime>(startedAt);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    if (!nullToAbsent || canceledAt != null) {
      map['canceled_at'] = Variable<DateTime>(canceledAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PrintJobsTableCompanion toCompanion(bool nullToAbsent) {
    return PrintJobsTableCompanion(
      id: Value(id),
      printerId: printerId == null && nullToAbsent
          ? const Value.absent()
          : Value(printerId),
      appId: appId == null && nullToAbsent
          ? const Value.absent()
          : Value(appId),
      title: Value(title),
      status: Value(status),
      contentType: contentType == null && nullToAbsent
          ? const Value.absent()
          : Value(contentType),
      copies: Value(copies),
      payloadSourceType: payloadSourceType == null && nullToAbsent
          ? const Value.absent()
          : Value(payloadSourceType),
      payloadSummary: payloadSummary == null && nullToAbsent
          ? const Value.absent()
          : Value(payloadSummary),
      artifactPath: artifactPath == null && nullToAbsent
          ? const Value.absent()
          : Value(artifactPath),
      artifactMimeType: artifactMimeType == null && nullToAbsent
          ? const Value.absent()
          : Value(artifactMimeType),
      artifactSize: artifactSize == null && nullToAbsent
          ? const Value.absent()
          : Value(artifactSize),
      artifactCreatedAt: artifactCreatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(artifactCreatedAt),
      artifactChecksum: artifactChecksum == null && nullToAbsent
          ? const Value.absent()
          : Value(artifactChecksum),
      optionsJson: optionsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(optionsJson),
      metaJson: metaJson == null && nullToAbsent
          ? const Value.absent()
          : Value(metaJson),
      referenceType: referenceType == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceType),
      referenceId: referenceId == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceId),
      source: source == null && nullToAbsent
          ? const Value.absent()
          : Value(source),
      idempotencyKey: idempotencyKey == null && nullToAbsent
          ? const Value.absent()
          : Value(idempotencyKey),
      failureCategory: failureCategory == null && nullToAbsent
          ? const Value.absent()
          : Value(failureCategory),
      failureMessage: failureMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(failureMessage),
      retryCount: Value(retryCount),
      lastRetryAt: lastRetryAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastRetryAt),
      nextRetryAt: nextRetryAt == null && nullToAbsent
          ? const Value.absent()
          : Value(nextRetryAt),
      queuedAt: queuedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(queuedAt),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      canceledAt: canceledAt == null && nullToAbsent
          ? const Value.absent()
          : Value(canceledAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PrintJobsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrintJobsTableData(
      id: serializer.fromJson<String>(json['id']),
      printerId: serializer.fromJson<String?>(json['printerId']),
      appId: serializer.fromJson<String?>(json['appId']),
      title: serializer.fromJson<String>(json['title']),
      status: serializer.fromJson<String>(json['status']),
      contentType: serializer.fromJson<String?>(json['contentType']),
      copies: serializer.fromJson<int>(json['copies']),
      payloadSourceType: serializer.fromJson<String?>(
        json['payloadSourceType'],
      ),
      payloadSummary: serializer.fromJson<String?>(json['payloadSummary']),
      artifactPath: serializer.fromJson<String?>(json['artifactPath']),
      artifactMimeType: serializer.fromJson<String?>(json['artifactMimeType']),
      artifactSize: serializer.fromJson<int?>(json['artifactSize']),
      artifactCreatedAt: serializer.fromJson<DateTime?>(
        json['artifactCreatedAt'],
      ),
      artifactChecksum: serializer.fromJson<String?>(json['artifactChecksum']),
      optionsJson: serializer.fromJson<String?>(json['optionsJson']),
      metaJson: serializer.fromJson<String?>(json['metaJson']),
      referenceType: serializer.fromJson<String?>(json['referenceType']),
      referenceId: serializer.fromJson<String?>(json['referenceId']),
      source: serializer.fromJson<String?>(json['source']),
      idempotencyKey: serializer.fromJson<String?>(json['idempotencyKey']),
      failureCategory: serializer.fromJson<String?>(json['failureCategory']),
      failureMessage: serializer.fromJson<String?>(json['failureMessage']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      lastRetryAt: serializer.fromJson<DateTime?>(json['lastRetryAt']),
      nextRetryAt: serializer.fromJson<DateTime?>(json['nextRetryAt']),
      queuedAt: serializer.fromJson<DateTime?>(json['queuedAt']),
      startedAt: serializer.fromJson<DateTime?>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      canceledAt: serializer.fromJson<DateTime?>(json['canceledAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'printerId': serializer.toJson<String?>(printerId),
      'appId': serializer.toJson<String?>(appId),
      'title': serializer.toJson<String>(title),
      'status': serializer.toJson<String>(status),
      'contentType': serializer.toJson<String?>(contentType),
      'copies': serializer.toJson<int>(copies),
      'payloadSourceType': serializer.toJson<String?>(payloadSourceType),
      'payloadSummary': serializer.toJson<String?>(payloadSummary),
      'artifactPath': serializer.toJson<String?>(artifactPath),
      'artifactMimeType': serializer.toJson<String?>(artifactMimeType),
      'artifactSize': serializer.toJson<int?>(artifactSize),
      'artifactCreatedAt': serializer.toJson<DateTime?>(artifactCreatedAt),
      'artifactChecksum': serializer.toJson<String?>(artifactChecksum),
      'optionsJson': serializer.toJson<String?>(optionsJson),
      'metaJson': serializer.toJson<String?>(metaJson),
      'referenceType': serializer.toJson<String?>(referenceType),
      'referenceId': serializer.toJson<String?>(referenceId),
      'source': serializer.toJson<String?>(source),
      'idempotencyKey': serializer.toJson<String?>(idempotencyKey),
      'failureCategory': serializer.toJson<String?>(failureCategory),
      'failureMessage': serializer.toJson<String?>(failureMessage),
      'retryCount': serializer.toJson<int>(retryCount),
      'lastRetryAt': serializer.toJson<DateTime?>(lastRetryAt),
      'nextRetryAt': serializer.toJson<DateTime?>(nextRetryAt),
      'queuedAt': serializer.toJson<DateTime?>(queuedAt),
      'startedAt': serializer.toJson<DateTime?>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'canceledAt': serializer.toJson<DateTime?>(canceledAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PrintJobsTableData copyWith({
    String? id,
    Value<String?> printerId = const Value.absent(),
    Value<String?> appId = const Value.absent(),
    String? title,
    String? status,
    Value<String?> contentType = const Value.absent(),
    int? copies,
    Value<String?> payloadSourceType = const Value.absent(),
    Value<String?> payloadSummary = const Value.absent(),
    Value<String?> artifactPath = const Value.absent(),
    Value<String?> artifactMimeType = const Value.absent(),
    Value<int?> artifactSize = const Value.absent(),
    Value<DateTime?> artifactCreatedAt = const Value.absent(),
    Value<String?> artifactChecksum = const Value.absent(),
    Value<String?> optionsJson = const Value.absent(),
    Value<String?> metaJson = const Value.absent(),
    Value<String?> referenceType = const Value.absent(),
    Value<String?> referenceId = const Value.absent(),
    Value<String?> source = const Value.absent(),
    Value<String?> idempotencyKey = const Value.absent(),
    Value<String?> failureCategory = const Value.absent(),
    Value<String?> failureMessage = const Value.absent(),
    int? retryCount,
    Value<DateTime?> lastRetryAt = const Value.absent(),
    Value<DateTime?> nextRetryAt = const Value.absent(),
    Value<DateTime?> queuedAt = const Value.absent(),
    Value<DateTime?> startedAt = const Value.absent(),
    Value<DateTime?> completedAt = const Value.absent(),
    Value<DateTime?> canceledAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => PrintJobsTableData(
    id: id ?? this.id,
    printerId: printerId.present ? printerId.value : this.printerId,
    appId: appId.present ? appId.value : this.appId,
    title: title ?? this.title,
    status: status ?? this.status,
    contentType: contentType.present ? contentType.value : this.contentType,
    copies: copies ?? this.copies,
    payloadSourceType: payloadSourceType.present
        ? payloadSourceType.value
        : this.payloadSourceType,
    payloadSummary: payloadSummary.present
        ? payloadSummary.value
        : this.payloadSummary,
    artifactPath: artifactPath.present ? artifactPath.value : this.artifactPath,
    artifactMimeType: artifactMimeType.present
        ? artifactMimeType.value
        : this.artifactMimeType,
    artifactSize: artifactSize.present ? artifactSize.value : this.artifactSize,
    artifactCreatedAt: artifactCreatedAt.present
        ? artifactCreatedAt.value
        : this.artifactCreatedAt,
    artifactChecksum: artifactChecksum.present
        ? artifactChecksum.value
        : this.artifactChecksum,
    optionsJson: optionsJson.present ? optionsJson.value : this.optionsJson,
    metaJson: metaJson.present ? metaJson.value : this.metaJson,
    referenceType: referenceType.present
        ? referenceType.value
        : this.referenceType,
    referenceId: referenceId.present ? referenceId.value : this.referenceId,
    source: source.present ? source.value : this.source,
    idempotencyKey: idempotencyKey.present
        ? idempotencyKey.value
        : this.idempotencyKey,
    failureCategory: failureCategory.present
        ? failureCategory.value
        : this.failureCategory,
    failureMessage: failureMessage.present
        ? failureMessage.value
        : this.failureMessage,
    retryCount: retryCount ?? this.retryCount,
    lastRetryAt: lastRetryAt.present ? lastRetryAt.value : this.lastRetryAt,
    nextRetryAt: nextRetryAt.present ? nextRetryAt.value : this.nextRetryAt,
    queuedAt: queuedAt.present ? queuedAt.value : this.queuedAt,
    startedAt: startedAt.present ? startedAt.value : this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    canceledAt: canceledAt.present ? canceledAt.value : this.canceledAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PrintJobsTableData copyWithCompanion(PrintJobsTableCompanion data) {
    return PrintJobsTableData(
      id: data.id.present ? data.id.value : this.id,
      printerId: data.printerId.present ? data.printerId.value : this.printerId,
      appId: data.appId.present ? data.appId.value : this.appId,
      title: data.title.present ? data.title.value : this.title,
      status: data.status.present ? data.status.value : this.status,
      contentType: data.contentType.present
          ? data.contentType.value
          : this.contentType,
      copies: data.copies.present ? data.copies.value : this.copies,
      payloadSourceType: data.payloadSourceType.present
          ? data.payloadSourceType.value
          : this.payloadSourceType,
      payloadSummary: data.payloadSummary.present
          ? data.payloadSummary.value
          : this.payloadSummary,
      artifactPath: data.artifactPath.present
          ? data.artifactPath.value
          : this.artifactPath,
      artifactMimeType: data.artifactMimeType.present
          ? data.artifactMimeType.value
          : this.artifactMimeType,
      artifactSize: data.artifactSize.present
          ? data.artifactSize.value
          : this.artifactSize,
      artifactCreatedAt: data.artifactCreatedAt.present
          ? data.artifactCreatedAt.value
          : this.artifactCreatedAt,
      artifactChecksum: data.artifactChecksum.present
          ? data.artifactChecksum.value
          : this.artifactChecksum,
      optionsJson: data.optionsJson.present
          ? data.optionsJson.value
          : this.optionsJson,
      metaJson: data.metaJson.present ? data.metaJson.value : this.metaJson,
      referenceType: data.referenceType.present
          ? data.referenceType.value
          : this.referenceType,
      referenceId: data.referenceId.present
          ? data.referenceId.value
          : this.referenceId,
      source: data.source.present ? data.source.value : this.source,
      idempotencyKey: data.idempotencyKey.present
          ? data.idempotencyKey.value
          : this.idempotencyKey,
      failureCategory: data.failureCategory.present
          ? data.failureCategory.value
          : this.failureCategory,
      failureMessage: data.failureMessage.present
          ? data.failureMessage.value
          : this.failureMessage,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      lastRetryAt: data.lastRetryAt.present
          ? data.lastRetryAt.value
          : this.lastRetryAt,
      nextRetryAt: data.nextRetryAt.present
          ? data.nextRetryAt.value
          : this.nextRetryAt,
      queuedAt: data.queuedAt.present ? data.queuedAt.value : this.queuedAt,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      canceledAt: data.canceledAt.present
          ? data.canceledAt.value
          : this.canceledAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrintJobsTableData(')
          ..write('id: $id, ')
          ..write('printerId: $printerId, ')
          ..write('appId: $appId, ')
          ..write('title: $title, ')
          ..write('status: $status, ')
          ..write('contentType: $contentType, ')
          ..write('copies: $copies, ')
          ..write('payloadSourceType: $payloadSourceType, ')
          ..write('payloadSummary: $payloadSummary, ')
          ..write('artifactPath: $artifactPath, ')
          ..write('artifactMimeType: $artifactMimeType, ')
          ..write('artifactSize: $artifactSize, ')
          ..write('artifactCreatedAt: $artifactCreatedAt, ')
          ..write('artifactChecksum: $artifactChecksum, ')
          ..write('optionsJson: $optionsJson, ')
          ..write('metaJson: $metaJson, ')
          ..write('referenceType: $referenceType, ')
          ..write('referenceId: $referenceId, ')
          ..write('source: $source, ')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('failureCategory: $failureCategory, ')
          ..write('failureMessage: $failureMessage, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastRetryAt: $lastRetryAt, ')
          ..write('nextRetryAt: $nextRetryAt, ')
          ..write('queuedAt: $queuedAt, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('canceledAt: $canceledAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    printerId,
    appId,
    title,
    status,
    contentType,
    copies,
    payloadSourceType,
    payloadSummary,
    artifactPath,
    artifactMimeType,
    artifactSize,
    artifactCreatedAt,
    artifactChecksum,
    optionsJson,
    metaJson,
    referenceType,
    referenceId,
    source,
    idempotencyKey,
    failureCategory,
    failureMessage,
    retryCount,
    lastRetryAt,
    nextRetryAt,
    queuedAt,
    startedAt,
    completedAt,
    canceledAt,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrintJobsTableData &&
          other.id == this.id &&
          other.printerId == this.printerId &&
          other.appId == this.appId &&
          other.title == this.title &&
          other.status == this.status &&
          other.contentType == this.contentType &&
          other.copies == this.copies &&
          other.payloadSourceType == this.payloadSourceType &&
          other.payloadSummary == this.payloadSummary &&
          other.artifactPath == this.artifactPath &&
          other.artifactMimeType == this.artifactMimeType &&
          other.artifactSize == this.artifactSize &&
          other.artifactCreatedAt == this.artifactCreatedAt &&
          other.artifactChecksum == this.artifactChecksum &&
          other.optionsJson == this.optionsJson &&
          other.metaJson == this.metaJson &&
          other.referenceType == this.referenceType &&
          other.referenceId == this.referenceId &&
          other.source == this.source &&
          other.idempotencyKey == this.idempotencyKey &&
          other.failureCategory == this.failureCategory &&
          other.failureMessage == this.failureMessage &&
          other.retryCount == this.retryCount &&
          other.lastRetryAt == this.lastRetryAt &&
          other.nextRetryAt == this.nextRetryAt &&
          other.queuedAt == this.queuedAt &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.canceledAt == this.canceledAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PrintJobsTableCompanion extends UpdateCompanion<PrintJobsTableData> {
  final Value<String> id;
  final Value<String?> printerId;
  final Value<String?> appId;
  final Value<String> title;
  final Value<String> status;
  final Value<String?> contentType;
  final Value<int> copies;
  final Value<String?> payloadSourceType;
  final Value<String?> payloadSummary;
  final Value<String?> artifactPath;
  final Value<String?> artifactMimeType;
  final Value<int?> artifactSize;
  final Value<DateTime?> artifactCreatedAt;
  final Value<String?> artifactChecksum;
  final Value<String?> optionsJson;
  final Value<String?> metaJson;
  final Value<String?> referenceType;
  final Value<String?> referenceId;
  final Value<String?> source;
  final Value<String?> idempotencyKey;
  final Value<String?> failureCategory;
  final Value<String?> failureMessage;
  final Value<int> retryCount;
  final Value<DateTime?> lastRetryAt;
  final Value<DateTime?> nextRetryAt;
  final Value<DateTime?> queuedAt;
  final Value<DateTime?> startedAt;
  final Value<DateTime?> completedAt;
  final Value<DateTime?> canceledAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PrintJobsTableCompanion({
    this.id = const Value.absent(),
    this.printerId = const Value.absent(),
    this.appId = const Value.absent(),
    this.title = const Value.absent(),
    this.status = const Value.absent(),
    this.contentType = const Value.absent(),
    this.copies = const Value.absent(),
    this.payloadSourceType = const Value.absent(),
    this.payloadSummary = const Value.absent(),
    this.artifactPath = const Value.absent(),
    this.artifactMimeType = const Value.absent(),
    this.artifactSize = const Value.absent(),
    this.artifactCreatedAt = const Value.absent(),
    this.artifactChecksum = const Value.absent(),
    this.optionsJson = const Value.absent(),
    this.metaJson = const Value.absent(),
    this.referenceType = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.source = const Value.absent(),
    this.idempotencyKey = const Value.absent(),
    this.failureCategory = const Value.absent(),
    this.failureMessage = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastRetryAt = const Value.absent(),
    this.nextRetryAt = const Value.absent(),
    this.queuedAt = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.canceledAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PrintJobsTableCompanion.insert({
    required String id,
    this.printerId = const Value.absent(),
    this.appId = const Value.absent(),
    required String title,
    this.status = const Value.absent(),
    this.contentType = const Value.absent(),
    this.copies = const Value.absent(),
    this.payloadSourceType = const Value.absent(),
    this.payloadSummary = const Value.absent(),
    this.artifactPath = const Value.absent(),
    this.artifactMimeType = const Value.absent(),
    this.artifactSize = const Value.absent(),
    this.artifactCreatedAt = const Value.absent(),
    this.artifactChecksum = const Value.absent(),
    this.optionsJson = const Value.absent(),
    this.metaJson = const Value.absent(),
    this.referenceType = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.source = const Value.absent(),
    this.idempotencyKey = const Value.absent(),
    this.failureCategory = const Value.absent(),
    this.failureMessage = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastRetryAt = const Value.absent(),
    this.nextRetryAt = const Value.absent(),
    this.queuedAt = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.canceledAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<PrintJobsTableData> custom({
    Expression<String>? id,
    Expression<String>? printerId,
    Expression<String>? appId,
    Expression<String>? title,
    Expression<String>? status,
    Expression<String>? contentType,
    Expression<int>? copies,
    Expression<String>? payloadSourceType,
    Expression<String>? payloadSummary,
    Expression<String>? artifactPath,
    Expression<String>? artifactMimeType,
    Expression<int>? artifactSize,
    Expression<DateTime>? artifactCreatedAt,
    Expression<String>? artifactChecksum,
    Expression<String>? optionsJson,
    Expression<String>? metaJson,
    Expression<String>? referenceType,
    Expression<String>? referenceId,
    Expression<String>? source,
    Expression<String>? idempotencyKey,
    Expression<String>? failureCategory,
    Expression<String>? failureMessage,
    Expression<int>? retryCount,
    Expression<DateTime>? lastRetryAt,
    Expression<DateTime>? nextRetryAt,
    Expression<DateTime>? queuedAt,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? canceledAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (printerId != null) 'printer_id': printerId,
      if (appId != null) 'app_id': appId,
      if (title != null) 'title': title,
      if (status != null) 'status': status,
      if (contentType != null) 'content_type': contentType,
      if (copies != null) 'copies': copies,
      if (payloadSourceType != null) 'payload_source_type': payloadSourceType,
      if (payloadSummary != null) 'payload_summary': payloadSummary,
      if (artifactPath != null) 'artifact_path': artifactPath,
      if (artifactMimeType != null) 'artifact_mime_type': artifactMimeType,
      if (artifactSize != null) 'artifact_size': artifactSize,
      if (artifactCreatedAt != null) 'artifact_created_at': artifactCreatedAt,
      if (artifactChecksum != null) 'artifact_checksum': artifactChecksum,
      if (optionsJson != null) 'options_json': optionsJson,
      if (metaJson != null) 'meta_json': metaJson,
      if (referenceType != null) 'reference_type': referenceType,
      if (referenceId != null) 'reference_id': referenceId,
      if (source != null) 'source': source,
      if (idempotencyKey != null) 'idempotency_key': idempotencyKey,
      if (failureCategory != null) 'failure_category': failureCategory,
      if (failureMessage != null) 'failure_message': failureMessage,
      if (retryCount != null) 'retry_count': retryCount,
      if (lastRetryAt != null) 'last_retry_at': lastRetryAt,
      if (nextRetryAt != null) 'next_retry_at': nextRetryAt,
      if (queuedAt != null) 'queued_at': queuedAt,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (canceledAt != null) 'canceled_at': canceledAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PrintJobsTableCompanion copyWith({
    Value<String>? id,
    Value<String?>? printerId,
    Value<String?>? appId,
    Value<String>? title,
    Value<String>? status,
    Value<String?>? contentType,
    Value<int>? copies,
    Value<String?>? payloadSourceType,
    Value<String?>? payloadSummary,
    Value<String?>? artifactPath,
    Value<String?>? artifactMimeType,
    Value<int?>? artifactSize,
    Value<DateTime?>? artifactCreatedAt,
    Value<String?>? artifactChecksum,
    Value<String?>? optionsJson,
    Value<String?>? metaJson,
    Value<String?>? referenceType,
    Value<String?>? referenceId,
    Value<String?>? source,
    Value<String?>? idempotencyKey,
    Value<String?>? failureCategory,
    Value<String?>? failureMessage,
    Value<int>? retryCount,
    Value<DateTime?>? lastRetryAt,
    Value<DateTime?>? nextRetryAt,
    Value<DateTime?>? queuedAt,
    Value<DateTime?>? startedAt,
    Value<DateTime?>? completedAt,
    Value<DateTime?>? canceledAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return PrintJobsTableCompanion(
      id: id ?? this.id,
      printerId: printerId ?? this.printerId,
      appId: appId ?? this.appId,
      title: title ?? this.title,
      status: status ?? this.status,
      contentType: contentType ?? this.contentType,
      copies: copies ?? this.copies,
      payloadSourceType: payloadSourceType ?? this.payloadSourceType,
      payloadSummary: payloadSummary ?? this.payloadSummary,
      artifactPath: artifactPath ?? this.artifactPath,
      artifactMimeType: artifactMimeType ?? this.artifactMimeType,
      artifactSize: artifactSize ?? this.artifactSize,
      artifactCreatedAt: artifactCreatedAt ?? this.artifactCreatedAt,
      artifactChecksum: artifactChecksum ?? this.artifactChecksum,
      optionsJson: optionsJson ?? this.optionsJson,
      metaJson: metaJson ?? this.metaJson,
      referenceType: referenceType ?? this.referenceType,
      referenceId: referenceId ?? this.referenceId,
      source: source ?? this.source,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      failureCategory: failureCategory ?? this.failureCategory,
      failureMessage: failureMessage ?? this.failureMessage,
      retryCount: retryCount ?? this.retryCount,
      lastRetryAt: lastRetryAt ?? this.lastRetryAt,
      nextRetryAt: nextRetryAt ?? this.nextRetryAt,
      queuedAt: queuedAt ?? this.queuedAt,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      canceledAt: canceledAt ?? this.canceledAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (printerId.present) {
      map['printer_id'] = Variable<String>(printerId.value);
    }
    if (appId.present) {
      map['app_id'] = Variable<String>(appId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (contentType.present) {
      map['content_type'] = Variable<String>(contentType.value);
    }
    if (copies.present) {
      map['copies'] = Variable<int>(copies.value);
    }
    if (payloadSourceType.present) {
      map['payload_source_type'] = Variable<String>(payloadSourceType.value);
    }
    if (payloadSummary.present) {
      map['payload_summary'] = Variable<String>(payloadSummary.value);
    }
    if (artifactPath.present) {
      map['artifact_path'] = Variable<String>(artifactPath.value);
    }
    if (artifactMimeType.present) {
      map['artifact_mime_type'] = Variable<String>(artifactMimeType.value);
    }
    if (artifactSize.present) {
      map['artifact_size'] = Variable<int>(artifactSize.value);
    }
    if (artifactCreatedAt.present) {
      map['artifact_created_at'] = Variable<DateTime>(artifactCreatedAt.value);
    }
    if (artifactChecksum.present) {
      map['artifact_checksum'] = Variable<String>(artifactChecksum.value);
    }
    if (optionsJson.present) {
      map['options_json'] = Variable<String>(optionsJson.value);
    }
    if (metaJson.present) {
      map['meta_json'] = Variable<String>(metaJson.value);
    }
    if (referenceType.present) {
      map['reference_type'] = Variable<String>(referenceType.value);
    }
    if (referenceId.present) {
      map['reference_id'] = Variable<String>(referenceId.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (idempotencyKey.present) {
      map['idempotency_key'] = Variable<String>(idempotencyKey.value);
    }
    if (failureCategory.present) {
      map['failure_category'] = Variable<String>(failureCategory.value);
    }
    if (failureMessage.present) {
      map['failure_message'] = Variable<String>(failureMessage.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (lastRetryAt.present) {
      map['last_retry_at'] = Variable<DateTime>(lastRetryAt.value);
    }
    if (nextRetryAt.present) {
      map['next_retry_at'] = Variable<DateTime>(nextRetryAt.value);
    }
    if (queuedAt.present) {
      map['queued_at'] = Variable<DateTime>(queuedAt.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (canceledAt.present) {
      map['canceled_at'] = Variable<DateTime>(canceledAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrintJobsTableCompanion(')
          ..write('id: $id, ')
          ..write('printerId: $printerId, ')
          ..write('appId: $appId, ')
          ..write('title: $title, ')
          ..write('status: $status, ')
          ..write('contentType: $contentType, ')
          ..write('copies: $copies, ')
          ..write('payloadSourceType: $payloadSourceType, ')
          ..write('payloadSummary: $payloadSummary, ')
          ..write('artifactPath: $artifactPath, ')
          ..write('artifactMimeType: $artifactMimeType, ')
          ..write('artifactSize: $artifactSize, ')
          ..write('artifactCreatedAt: $artifactCreatedAt, ')
          ..write('artifactChecksum: $artifactChecksum, ')
          ..write('optionsJson: $optionsJson, ')
          ..write('metaJson: $metaJson, ')
          ..write('referenceType: $referenceType, ')
          ..write('referenceId: $referenceId, ')
          ..write('source: $source, ')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('failureCategory: $failureCategory, ')
          ..write('failureMessage: $failureMessage, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastRetryAt: $lastRetryAt, ')
          ..write('nextRetryAt: $nextRetryAt, ')
          ..write('queuedAt: $queuedAt, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('canceledAt: $canceledAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LogsTableTable extends LogsTable
    with TableInfo<$LogsTableTable, LogsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LogsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<String> level = GeneratedColumn<String>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metadataMeta = const VerificationMeta(
    'metadata',
  );
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
    'metadata',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    level,
    eventType,
    title,
    message,
    metadata,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'logs_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<LogsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('metadata')) {
      context.handle(
        _metadataMeta,
        metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LogsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LogsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}level'],
      )!,
      eventType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_type'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      metadata: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $LogsTableTable createAlias(String alias) {
    return $LogsTableTable(attachedDatabase, alias);
  }
}

class LogsTableData extends DataClass implements Insertable<LogsTableData> {
  final String id;
  final String level;
  final String eventType;
  final String title;
  final String message;
  final String? metadata;
  final DateTime createdAt;
  const LogsTableData({
    required this.id,
    required this.level,
    required this.eventType,
    required this.title,
    required this.message,
    this.metadata,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['level'] = Variable<String>(level);
    map['event_type'] = Variable<String>(eventType);
    map['title'] = Variable<String>(title);
    map['message'] = Variable<String>(message);
    if (!nullToAbsent || metadata != null) {
      map['metadata'] = Variable<String>(metadata);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LogsTableCompanion toCompanion(bool nullToAbsent) {
    return LogsTableCompanion(
      id: Value(id),
      level: Value(level),
      eventType: Value(eventType),
      title: Value(title),
      message: Value(message),
      metadata: metadata == null && nullToAbsent
          ? const Value.absent()
          : Value(metadata),
      createdAt: Value(createdAt),
    );
  }

  factory LogsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LogsTableData(
      id: serializer.fromJson<String>(json['id']),
      level: serializer.fromJson<String>(json['level']),
      eventType: serializer.fromJson<String>(json['eventType']),
      title: serializer.fromJson<String>(json['title']),
      message: serializer.fromJson<String>(json['message']),
      metadata: serializer.fromJson<String?>(json['metadata']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'level': serializer.toJson<String>(level),
      'eventType': serializer.toJson<String>(eventType),
      'title': serializer.toJson<String>(title),
      'message': serializer.toJson<String>(message),
      'metadata': serializer.toJson<String?>(metadata),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LogsTableData copyWith({
    String? id,
    String? level,
    String? eventType,
    String? title,
    String? message,
    Value<String?> metadata = const Value.absent(),
    DateTime? createdAt,
  }) => LogsTableData(
    id: id ?? this.id,
    level: level ?? this.level,
    eventType: eventType ?? this.eventType,
    title: title ?? this.title,
    message: message ?? this.message,
    metadata: metadata.present ? metadata.value : this.metadata,
    createdAt: createdAt ?? this.createdAt,
  );
  LogsTableData copyWithCompanion(LogsTableCompanion data) {
    return LogsTableData(
      id: data.id.present ? data.id.value : this.id,
      level: data.level.present ? data.level.value : this.level,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      title: data.title.present ? data.title.value : this.title,
      message: data.message.present ? data.message.value : this.message,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LogsTableData(')
          ..write('id: $id, ')
          ..write('level: $level, ')
          ..write('eventType: $eventType, ')
          ..write('title: $title, ')
          ..write('message: $message, ')
          ..write('metadata: $metadata, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, level, eventType, title, message, metadata, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LogsTableData &&
          other.id == this.id &&
          other.level == this.level &&
          other.eventType == this.eventType &&
          other.title == this.title &&
          other.message == this.message &&
          other.metadata == this.metadata &&
          other.createdAt == this.createdAt);
}

class LogsTableCompanion extends UpdateCompanion<LogsTableData> {
  final Value<String> id;
  final Value<String> level;
  final Value<String> eventType;
  final Value<String> title;
  final Value<String> message;
  final Value<String?> metadata;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const LogsTableCompanion({
    this.id = const Value.absent(),
    this.level = const Value.absent(),
    this.eventType = const Value.absent(),
    this.title = const Value.absent(),
    this.message = const Value.absent(),
    this.metadata = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LogsTableCompanion.insert({
    required String id,
    required String level,
    required String eventType,
    required String title,
    required String message,
    this.metadata = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       level = Value(level),
       eventType = Value(eventType),
       title = Value(title),
       message = Value(message),
       createdAt = Value(createdAt);
  static Insertable<LogsTableData> custom({
    Expression<String>? id,
    Expression<String>? level,
    Expression<String>? eventType,
    Expression<String>? title,
    Expression<String>? message,
    Expression<String>? metadata,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (level != null) 'level': level,
      if (eventType != null) 'event_type': eventType,
      if (title != null) 'title': title,
      if (message != null) 'message': message,
      if (metadata != null) 'metadata': metadata,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LogsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? level,
    Value<String>? eventType,
    Value<String>? title,
    Value<String>? message,
    Value<String?>? metadata,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return LogsTableCompanion(
      id: id ?? this.id,
      level: level ?? this.level,
      eventType: eventType ?? this.eventType,
      title: title ?? this.title,
      message: message ?? this.message,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (level.present) {
      map['level'] = Variable<String>(level.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LogsTableCompanion(')
          ..write('id: $id, ')
          ..write('level: $level, ')
          ..write('eventType: $eventType, ')
          ..write('title: $title, ')
          ..write('message: $message, ')
          ..write('metadata: $metadata, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SettingsTableTable settingsTable = $SettingsTableTable(this);
  late final $PrintersTableTable printersTable = $PrintersTableTable(this);
  late final $AppsTableTable appsTable = $AppsTableTable(this);
  late final $AppPrintersTableTable appPrintersTable = $AppPrintersTableTable(
    this,
  );
  late final $PrintJobsTableTable printJobsTable = $PrintJobsTableTable(this);
  late final $LogsTableTable logsTable = $LogsTableTable(this);
  late final PrintersDao printersDao = PrintersDao(this as AppDatabase);
  late final AppsDao appsDao = AppsDao(this as AppDatabase);
  late final PrintJobsDao printJobsDao = PrintJobsDao(this as AppDatabase);
  late final LogsDao logsDao = LogsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    settingsTable,
    printersTable,
    appsTable,
    appPrintersTable,
    printJobsTable,
    logsTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'apps_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('app_printers_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'printers_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('app_printers_table', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$SettingsTableTableCreateCompanionBuilder =
    SettingsTableCompanion Function({
      Value<int> id,
      Value<int> appPort,
      Value<String> bindHost,
      Value<bool> enableBackgroundMode,
      Value<bool> startWithOs,
      Value<bool> allowLanAccess,
      Value<bool> autoStartServer,
      Value<bool> jobsStartPaused,
      Value<int> jobsMaxRetryAttempts,
      Value<int> jobsRetryDelaySeconds,
      Value<int> jobsHistoryRetentionDays,
      required DateTime updatedAt,
    });
typedef $$SettingsTableTableUpdateCompanionBuilder =
    SettingsTableCompanion Function({
      Value<int> id,
      Value<int> appPort,
      Value<String> bindHost,
      Value<bool> enableBackgroundMode,
      Value<bool> startWithOs,
      Value<bool> allowLanAccess,
      Value<bool> autoStartServer,
      Value<bool> jobsStartPaused,
      Value<int> jobsMaxRetryAttempts,
      Value<int> jobsRetryDelaySeconds,
      Value<int> jobsHistoryRetentionDays,
      Value<DateTime> updatedAt,
    });

class $$SettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get appPort => $composableBuilder(
    column: $table.appPort,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bindHost => $composableBuilder(
    column: $table.bindHost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enableBackgroundMode => $composableBuilder(
    column: $table.enableBackgroundMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get startWithOs => $composableBuilder(
    column: $table.startWithOs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get allowLanAccess => $composableBuilder(
    column: $table.allowLanAccess,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get autoStartServer => $composableBuilder(
    column: $table.autoStartServer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get jobsStartPaused => $composableBuilder(
    column: $table.jobsStartPaused,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get jobsMaxRetryAttempts => $composableBuilder(
    column: $table.jobsMaxRetryAttempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get jobsRetryDelaySeconds => $composableBuilder(
    column: $table.jobsRetryDelaySeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get jobsHistoryRetentionDays => $composableBuilder(
    column: $table.jobsHistoryRetentionDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get appPort => $composableBuilder(
    column: $table.appPort,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bindHost => $composableBuilder(
    column: $table.bindHost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enableBackgroundMode => $composableBuilder(
    column: $table.enableBackgroundMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get startWithOs => $composableBuilder(
    column: $table.startWithOs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get allowLanAccess => $composableBuilder(
    column: $table.allowLanAccess,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get autoStartServer => $composableBuilder(
    column: $table.autoStartServer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get jobsStartPaused => $composableBuilder(
    column: $table.jobsStartPaused,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get jobsMaxRetryAttempts => $composableBuilder(
    column: $table.jobsMaxRetryAttempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get jobsRetryDelaySeconds => $composableBuilder(
    column: $table.jobsRetryDelaySeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get jobsHistoryRetentionDays => $composableBuilder(
    column: $table.jobsHistoryRetentionDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get appPort =>
      $composableBuilder(column: $table.appPort, builder: (column) => column);

  GeneratedColumn<String> get bindHost =>
      $composableBuilder(column: $table.bindHost, builder: (column) => column);

  GeneratedColumn<bool> get enableBackgroundMode => $composableBuilder(
    column: $table.enableBackgroundMode,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get startWithOs => $composableBuilder(
    column: $table.startWithOs,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get allowLanAccess => $composableBuilder(
    column: $table.allowLanAccess,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get autoStartServer => $composableBuilder(
    column: $table.autoStartServer,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get jobsStartPaused => $composableBuilder(
    column: $table.jobsStartPaused,
    builder: (column) => column,
  );

  GeneratedColumn<int> get jobsMaxRetryAttempts => $composableBuilder(
    column: $table.jobsMaxRetryAttempts,
    builder: (column) => column,
  );

  GeneratedColumn<int> get jobsRetryDelaySeconds => $composableBuilder(
    column: $table.jobsRetryDelaySeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get jobsHistoryRetentionDays => $composableBuilder(
    column: $table.jobsHistoryRetentionDays,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTableTable,
          SettingsTableData,
          $$SettingsTableTableFilterComposer,
          $$SettingsTableTableOrderingComposer,
          $$SettingsTableTableAnnotationComposer,
          $$SettingsTableTableCreateCompanionBuilder,
          $$SettingsTableTableUpdateCompanionBuilder,
          (
            SettingsTableData,
            BaseReferences<
              _$AppDatabase,
              $SettingsTableTable,
              SettingsTableData
            >,
          ),
          SettingsTableData,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableTableManager(_$AppDatabase db, $SettingsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> appPort = const Value.absent(),
                Value<String> bindHost = const Value.absent(),
                Value<bool> enableBackgroundMode = const Value.absent(),
                Value<bool> startWithOs = const Value.absent(),
                Value<bool> allowLanAccess = const Value.absent(),
                Value<bool> autoStartServer = const Value.absent(),
                Value<bool> jobsStartPaused = const Value.absent(),
                Value<int> jobsMaxRetryAttempts = const Value.absent(),
                Value<int> jobsRetryDelaySeconds = const Value.absent(),
                Value<int> jobsHistoryRetentionDays = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SettingsTableCompanion(
                id: id,
                appPort: appPort,
                bindHost: bindHost,
                enableBackgroundMode: enableBackgroundMode,
                startWithOs: startWithOs,
                allowLanAccess: allowLanAccess,
                autoStartServer: autoStartServer,
                jobsStartPaused: jobsStartPaused,
                jobsMaxRetryAttempts: jobsMaxRetryAttempts,
                jobsRetryDelaySeconds: jobsRetryDelaySeconds,
                jobsHistoryRetentionDays: jobsHistoryRetentionDays,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> appPort = const Value.absent(),
                Value<String> bindHost = const Value.absent(),
                Value<bool> enableBackgroundMode = const Value.absent(),
                Value<bool> startWithOs = const Value.absent(),
                Value<bool> allowLanAccess = const Value.absent(),
                Value<bool> autoStartServer = const Value.absent(),
                Value<bool> jobsStartPaused = const Value.absent(),
                Value<int> jobsMaxRetryAttempts = const Value.absent(),
                Value<int> jobsRetryDelaySeconds = const Value.absent(),
                Value<int> jobsHistoryRetentionDays = const Value.absent(),
                required DateTime updatedAt,
              }) => SettingsTableCompanion.insert(
                id: id,
                appPort: appPort,
                bindHost: bindHost,
                enableBackgroundMode: enableBackgroundMode,
                startWithOs: startWithOs,
                allowLanAccess: allowLanAccess,
                autoStartServer: autoStartServer,
                jobsStartPaused: jobsStartPaused,
                jobsMaxRetryAttempts: jobsMaxRetryAttempts,
                jobsRetryDelaySeconds: jobsRetryDelaySeconds,
                jobsHistoryRetentionDays: jobsHistoryRetentionDays,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTableTable,
      SettingsTableData,
      $$SettingsTableTableFilterComposer,
      $$SettingsTableTableOrderingComposer,
      $$SettingsTableTableAnnotationComposer,
      $$SettingsTableTableCreateCompanionBuilder,
      $$SettingsTableTableUpdateCompanionBuilder,
      (
        SettingsTableData,
        BaseReferences<_$AppDatabase, $SettingsTableTable, SettingsTableData>,
      ),
      SettingsTableData,
      PrefetchHooks Function()
    >;
typedef $$PrintersTableTableCreateCompanionBuilder =
    PrintersTableCompanion Function({
      required String id,
      Value<String> uniqueKey,
      required String name,
      Value<String?> description,
      Value<String> connectionType,
      Value<String?> address,
      Value<String?> tcpHost,
      Value<int?> tcpPort,
      Value<int?> tcpConnectTimeoutMs,
      Value<int?> tcpWriteTimeoutMs,
      Value<int?> tcpReadTimeoutMs,
      Value<bool> tcpAutoReconnect,
      Value<int?> tcpReconnectDelayMs,
      Value<String?> tcpEncoding,
      Value<String?> tcpCodePage,
      Value<String?> tcpLineEnding,
      Value<bool> tcpKeepAlive,
      Value<bool> tcpNoDelay,
      Value<int?> tcpLingerSeconds,
      Value<String?> systemPrinterName,
      Value<String?> systemPaperSize,
      Value<int> systemDefaultCopies,
      Value<bool> systemColorEnabled,
      Value<String?> systemDuplexMode,
      Value<String?> systemOrientation,
      Value<int?> systemJobTimeoutMs,
      Value<String?> systemNotes,
      Value<String?> systemDriverName,
      Value<String?> systemQueueName,
      Value<String?> systemSpoolFormat,
      Value<bool> systemUseRawSpool,
      Value<String?> usbVendorId,
      Value<String?> usbProductId,
      Value<String?> usbSerialNumber,
      Value<int?> usbInterfaceNumber,
      Value<int?> usbOutEndpoint,
      Value<int?> usbInEndpoint,
      Value<int?> usbTimeoutMs,
      Value<String?> usbEncoding,
      Value<String?> usbCodePage,
      Value<String?> usbCharacterTable,
      Value<bool> usbAutoCutEnabled,
      Value<String?> usbCutMode,
      Value<bool> usbCashDrawerEnabled,
      Value<int?> usbDrawerPin,
      Value<bool> usbStatusMonitoringEnabled,
      Value<String?> usbManufacturer,
      Value<String?> usbProductName,
      Value<int?> usbAlternateSetting,
      Value<int?> usbPacketDelayMs,
      Value<String> rawGraphicsMode,
      Value<bool> isEnabled,
      Value<String?> lastStatus,
      Value<String?> lastStatusKey,
      Value<String?> lastStatusMessage,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$PrintersTableTableUpdateCompanionBuilder =
    PrintersTableCompanion Function({
      Value<String> id,
      Value<String> uniqueKey,
      Value<String> name,
      Value<String?> description,
      Value<String> connectionType,
      Value<String?> address,
      Value<String?> tcpHost,
      Value<int?> tcpPort,
      Value<int?> tcpConnectTimeoutMs,
      Value<int?> tcpWriteTimeoutMs,
      Value<int?> tcpReadTimeoutMs,
      Value<bool> tcpAutoReconnect,
      Value<int?> tcpReconnectDelayMs,
      Value<String?> tcpEncoding,
      Value<String?> tcpCodePage,
      Value<String?> tcpLineEnding,
      Value<bool> tcpKeepAlive,
      Value<bool> tcpNoDelay,
      Value<int?> tcpLingerSeconds,
      Value<String?> systemPrinterName,
      Value<String?> systemPaperSize,
      Value<int> systemDefaultCopies,
      Value<bool> systemColorEnabled,
      Value<String?> systemDuplexMode,
      Value<String?> systemOrientation,
      Value<int?> systemJobTimeoutMs,
      Value<String?> systemNotes,
      Value<String?> systemDriverName,
      Value<String?> systemQueueName,
      Value<String?> systemSpoolFormat,
      Value<bool> systemUseRawSpool,
      Value<String?> usbVendorId,
      Value<String?> usbProductId,
      Value<String?> usbSerialNumber,
      Value<int?> usbInterfaceNumber,
      Value<int?> usbOutEndpoint,
      Value<int?> usbInEndpoint,
      Value<int?> usbTimeoutMs,
      Value<String?> usbEncoding,
      Value<String?> usbCodePage,
      Value<String?> usbCharacterTable,
      Value<bool> usbAutoCutEnabled,
      Value<String?> usbCutMode,
      Value<bool> usbCashDrawerEnabled,
      Value<int?> usbDrawerPin,
      Value<bool> usbStatusMonitoringEnabled,
      Value<String?> usbManufacturer,
      Value<String?> usbProductName,
      Value<int?> usbAlternateSetting,
      Value<int?> usbPacketDelayMs,
      Value<String> rawGraphicsMode,
      Value<bool> isEnabled,
      Value<String?> lastStatus,
      Value<String?> lastStatusKey,
      Value<String?> lastStatusMessage,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$PrintersTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $PrintersTableTable, PrintersTableData> {
  $$PrintersTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$AppPrintersTableTable, List<AppPrintersTableData>>
  _appPrintersTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.appPrintersTable,
    aliasName: $_aliasNameGenerator(
      db.printersTable.id,
      db.appPrintersTable.printerId,
    ),
  );

  $$AppPrintersTableTableProcessedTableManager get appPrintersTableRefs {
    final manager = $$AppPrintersTableTableTableManager(
      $_db,
      $_db.appPrintersTable,
    ).filter((f) => f.printerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _appPrintersTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PrintersTableTableFilterComposer
    extends Composer<_$AppDatabase, $PrintersTableTable> {
  $$PrintersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uniqueKey => $composableBuilder(
    column: $table.uniqueKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get connectionType => $composableBuilder(
    column: $table.connectionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tcpHost => $composableBuilder(
    column: $table.tcpHost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tcpPort => $composableBuilder(
    column: $table.tcpPort,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tcpConnectTimeoutMs => $composableBuilder(
    column: $table.tcpConnectTimeoutMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tcpWriteTimeoutMs => $composableBuilder(
    column: $table.tcpWriteTimeoutMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tcpReadTimeoutMs => $composableBuilder(
    column: $table.tcpReadTimeoutMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get tcpAutoReconnect => $composableBuilder(
    column: $table.tcpAutoReconnect,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tcpReconnectDelayMs => $composableBuilder(
    column: $table.tcpReconnectDelayMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tcpEncoding => $composableBuilder(
    column: $table.tcpEncoding,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tcpCodePage => $composableBuilder(
    column: $table.tcpCodePage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tcpLineEnding => $composableBuilder(
    column: $table.tcpLineEnding,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get tcpKeepAlive => $composableBuilder(
    column: $table.tcpKeepAlive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get tcpNoDelay => $composableBuilder(
    column: $table.tcpNoDelay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tcpLingerSeconds => $composableBuilder(
    column: $table.tcpLingerSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get systemPrinterName => $composableBuilder(
    column: $table.systemPrinterName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get systemPaperSize => $composableBuilder(
    column: $table.systemPaperSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get systemDefaultCopies => $composableBuilder(
    column: $table.systemDefaultCopies,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get systemColorEnabled => $composableBuilder(
    column: $table.systemColorEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get systemDuplexMode => $composableBuilder(
    column: $table.systemDuplexMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get systemOrientation => $composableBuilder(
    column: $table.systemOrientation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get systemJobTimeoutMs => $composableBuilder(
    column: $table.systemJobTimeoutMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get systemNotes => $composableBuilder(
    column: $table.systemNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get systemDriverName => $composableBuilder(
    column: $table.systemDriverName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get systemQueueName => $composableBuilder(
    column: $table.systemQueueName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get systemSpoolFormat => $composableBuilder(
    column: $table.systemSpoolFormat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get systemUseRawSpool => $composableBuilder(
    column: $table.systemUseRawSpool,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usbVendorId => $composableBuilder(
    column: $table.usbVendorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usbProductId => $composableBuilder(
    column: $table.usbProductId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usbSerialNumber => $composableBuilder(
    column: $table.usbSerialNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usbInterfaceNumber => $composableBuilder(
    column: $table.usbInterfaceNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usbOutEndpoint => $composableBuilder(
    column: $table.usbOutEndpoint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usbInEndpoint => $composableBuilder(
    column: $table.usbInEndpoint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usbTimeoutMs => $composableBuilder(
    column: $table.usbTimeoutMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usbEncoding => $composableBuilder(
    column: $table.usbEncoding,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usbCodePage => $composableBuilder(
    column: $table.usbCodePage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usbCharacterTable => $composableBuilder(
    column: $table.usbCharacterTable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get usbAutoCutEnabled => $composableBuilder(
    column: $table.usbAutoCutEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usbCutMode => $composableBuilder(
    column: $table.usbCutMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get usbCashDrawerEnabled => $composableBuilder(
    column: $table.usbCashDrawerEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usbDrawerPin => $composableBuilder(
    column: $table.usbDrawerPin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get usbStatusMonitoringEnabled => $composableBuilder(
    column: $table.usbStatusMonitoringEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usbManufacturer => $composableBuilder(
    column: $table.usbManufacturer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usbProductName => $composableBuilder(
    column: $table.usbProductName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usbAlternateSetting => $composableBuilder(
    column: $table.usbAlternateSetting,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usbPacketDelayMs => $composableBuilder(
    column: $table.usbPacketDelayMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawGraphicsMode => $composableBuilder(
    column: $table.rawGraphicsMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastStatus => $composableBuilder(
    column: $table.lastStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastStatusKey => $composableBuilder(
    column: $table.lastStatusKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastStatusMessage => $composableBuilder(
    column: $table.lastStatusMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> appPrintersTableRefs(
    Expression<bool> Function($$AppPrintersTableTableFilterComposer f) f,
  ) {
    final $$AppPrintersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.appPrintersTable,
      getReferencedColumn: (t) => t.printerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppPrintersTableTableFilterComposer(
            $db: $db,
            $table: $db.appPrintersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PrintersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PrintersTableTable> {
  $$PrintersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uniqueKey => $composableBuilder(
    column: $table.uniqueKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get connectionType => $composableBuilder(
    column: $table.connectionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tcpHost => $composableBuilder(
    column: $table.tcpHost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tcpPort => $composableBuilder(
    column: $table.tcpPort,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tcpConnectTimeoutMs => $composableBuilder(
    column: $table.tcpConnectTimeoutMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tcpWriteTimeoutMs => $composableBuilder(
    column: $table.tcpWriteTimeoutMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tcpReadTimeoutMs => $composableBuilder(
    column: $table.tcpReadTimeoutMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get tcpAutoReconnect => $composableBuilder(
    column: $table.tcpAutoReconnect,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tcpReconnectDelayMs => $composableBuilder(
    column: $table.tcpReconnectDelayMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tcpEncoding => $composableBuilder(
    column: $table.tcpEncoding,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tcpCodePage => $composableBuilder(
    column: $table.tcpCodePage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tcpLineEnding => $composableBuilder(
    column: $table.tcpLineEnding,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get tcpKeepAlive => $composableBuilder(
    column: $table.tcpKeepAlive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get tcpNoDelay => $composableBuilder(
    column: $table.tcpNoDelay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tcpLingerSeconds => $composableBuilder(
    column: $table.tcpLingerSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get systemPrinterName => $composableBuilder(
    column: $table.systemPrinterName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get systemPaperSize => $composableBuilder(
    column: $table.systemPaperSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get systemDefaultCopies => $composableBuilder(
    column: $table.systemDefaultCopies,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get systemColorEnabled => $composableBuilder(
    column: $table.systemColorEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get systemDuplexMode => $composableBuilder(
    column: $table.systemDuplexMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get systemOrientation => $composableBuilder(
    column: $table.systemOrientation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get systemJobTimeoutMs => $composableBuilder(
    column: $table.systemJobTimeoutMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get systemNotes => $composableBuilder(
    column: $table.systemNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get systemDriverName => $composableBuilder(
    column: $table.systemDriverName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get systemQueueName => $composableBuilder(
    column: $table.systemQueueName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get systemSpoolFormat => $composableBuilder(
    column: $table.systemSpoolFormat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get systemUseRawSpool => $composableBuilder(
    column: $table.systemUseRawSpool,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usbVendorId => $composableBuilder(
    column: $table.usbVendorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usbProductId => $composableBuilder(
    column: $table.usbProductId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usbSerialNumber => $composableBuilder(
    column: $table.usbSerialNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usbInterfaceNumber => $composableBuilder(
    column: $table.usbInterfaceNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usbOutEndpoint => $composableBuilder(
    column: $table.usbOutEndpoint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usbInEndpoint => $composableBuilder(
    column: $table.usbInEndpoint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usbTimeoutMs => $composableBuilder(
    column: $table.usbTimeoutMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usbEncoding => $composableBuilder(
    column: $table.usbEncoding,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usbCodePage => $composableBuilder(
    column: $table.usbCodePage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usbCharacterTable => $composableBuilder(
    column: $table.usbCharacterTable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get usbAutoCutEnabled => $composableBuilder(
    column: $table.usbAutoCutEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usbCutMode => $composableBuilder(
    column: $table.usbCutMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get usbCashDrawerEnabled => $composableBuilder(
    column: $table.usbCashDrawerEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usbDrawerPin => $composableBuilder(
    column: $table.usbDrawerPin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get usbStatusMonitoringEnabled => $composableBuilder(
    column: $table.usbStatusMonitoringEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usbManufacturer => $composableBuilder(
    column: $table.usbManufacturer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usbProductName => $composableBuilder(
    column: $table.usbProductName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usbAlternateSetting => $composableBuilder(
    column: $table.usbAlternateSetting,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usbPacketDelayMs => $composableBuilder(
    column: $table.usbPacketDelayMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawGraphicsMode => $composableBuilder(
    column: $table.rawGraphicsMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastStatus => $composableBuilder(
    column: $table.lastStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastStatusKey => $composableBuilder(
    column: $table.lastStatusKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastStatusMessage => $composableBuilder(
    column: $table.lastStatusMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PrintersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrintersTableTable> {
  $$PrintersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uniqueKey =>
      $composableBuilder(column: $table.uniqueKey, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get connectionType => $composableBuilder(
    column: $table.connectionType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get tcpHost =>
      $composableBuilder(column: $table.tcpHost, builder: (column) => column);

  GeneratedColumn<int> get tcpPort =>
      $composableBuilder(column: $table.tcpPort, builder: (column) => column);

  GeneratedColumn<int> get tcpConnectTimeoutMs => $composableBuilder(
    column: $table.tcpConnectTimeoutMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get tcpWriteTimeoutMs => $composableBuilder(
    column: $table.tcpWriteTimeoutMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get tcpReadTimeoutMs => $composableBuilder(
    column: $table.tcpReadTimeoutMs,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get tcpAutoReconnect => $composableBuilder(
    column: $table.tcpAutoReconnect,
    builder: (column) => column,
  );

  GeneratedColumn<int> get tcpReconnectDelayMs => $composableBuilder(
    column: $table.tcpReconnectDelayMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tcpEncoding => $composableBuilder(
    column: $table.tcpEncoding,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tcpCodePage => $composableBuilder(
    column: $table.tcpCodePage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tcpLineEnding => $composableBuilder(
    column: $table.tcpLineEnding,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get tcpKeepAlive => $composableBuilder(
    column: $table.tcpKeepAlive,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get tcpNoDelay => $composableBuilder(
    column: $table.tcpNoDelay,
    builder: (column) => column,
  );

  GeneratedColumn<int> get tcpLingerSeconds => $composableBuilder(
    column: $table.tcpLingerSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get systemPrinterName => $composableBuilder(
    column: $table.systemPrinterName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get systemPaperSize => $composableBuilder(
    column: $table.systemPaperSize,
    builder: (column) => column,
  );

  GeneratedColumn<int> get systemDefaultCopies => $composableBuilder(
    column: $table.systemDefaultCopies,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get systemColorEnabled => $composableBuilder(
    column: $table.systemColorEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get systemDuplexMode => $composableBuilder(
    column: $table.systemDuplexMode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get systemOrientation => $composableBuilder(
    column: $table.systemOrientation,
    builder: (column) => column,
  );

  GeneratedColumn<int> get systemJobTimeoutMs => $composableBuilder(
    column: $table.systemJobTimeoutMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get systemNotes => $composableBuilder(
    column: $table.systemNotes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get systemDriverName => $composableBuilder(
    column: $table.systemDriverName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get systemQueueName => $composableBuilder(
    column: $table.systemQueueName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get systemSpoolFormat => $composableBuilder(
    column: $table.systemSpoolFormat,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get systemUseRawSpool => $composableBuilder(
    column: $table.systemUseRawSpool,
    builder: (column) => column,
  );

  GeneratedColumn<String> get usbVendorId => $composableBuilder(
    column: $table.usbVendorId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get usbProductId => $composableBuilder(
    column: $table.usbProductId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get usbSerialNumber => $composableBuilder(
    column: $table.usbSerialNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get usbInterfaceNumber => $composableBuilder(
    column: $table.usbInterfaceNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get usbOutEndpoint => $composableBuilder(
    column: $table.usbOutEndpoint,
    builder: (column) => column,
  );

  GeneratedColumn<int> get usbInEndpoint => $composableBuilder(
    column: $table.usbInEndpoint,
    builder: (column) => column,
  );

  GeneratedColumn<int> get usbTimeoutMs => $composableBuilder(
    column: $table.usbTimeoutMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get usbEncoding => $composableBuilder(
    column: $table.usbEncoding,
    builder: (column) => column,
  );

  GeneratedColumn<String> get usbCodePage => $composableBuilder(
    column: $table.usbCodePage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get usbCharacterTable => $composableBuilder(
    column: $table.usbCharacterTable,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get usbAutoCutEnabled => $composableBuilder(
    column: $table.usbAutoCutEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get usbCutMode => $composableBuilder(
    column: $table.usbCutMode,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get usbCashDrawerEnabled => $composableBuilder(
    column: $table.usbCashDrawerEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get usbDrawerPin => $composableBuilder(
    column: $table.usbDrawerPin,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get usbStatusMonitoringEnabled => $composableBuilder(
    column: $table.usbStatusMonitoringEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get usbManufacturer => $composableBuilder(
    column: $table.usbManufacturer,
    builder: (column) => column,
  );

  GeneratedColumn<String> get usbProductName => $composableBuilder(
    column: $table.usbProductName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get usbAlternateSetting => $composableBuilder(
    column: $table.usbAlternateSetting,
    builder: (column) => column,
  );

  GeneratedColumn<int> get usbPacketDelayMs => $composableBuilder(
    column: $table.usbPacketDelayMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rawGraphicsMode => $composableBuilder(
    column: $table.rawGraphicsMode,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<String> get lastStatus => $composableBuilder(
    column: $table.lastStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastStatusKey => $composableBuilder(
    column: $table.lastStatusKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastStatusMessage => $composableBuilder(
    column: $table.lastStatusMessage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> appPrintersTableRefs<T extends Object>(
    Expression<T> Function($$AppPrintersTableTableAnnotationComposer a) f,
  ) {
    final $$AppPrintersTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.appPrintersTable,
      getReferencedColumn: (t) => t.printerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppPrintersTableTableAnnotationComposer(
            $db: $db,
            $table: $db.appPrintersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PrintersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PrintersTableTable,
          PrintersTableData,
          $$PrintersTableTableFilterComposer,
          $$PrintersTableTableOrderingComposer,
          $$PrintersTableTableAnnotationComposer,
          $$PrintersTableTableCreateCompanionBuilder,
          $$PrintersTableTableUpdateCompanionBuilder,
          (PrintersTableData, $$PrintersTableTableReferences),
          PrintersTableData,
          PrefetchHooks Function({bool appPrintersTableRefs})
        > {
  $$PrintersTableTableTableManager(_$AppDatabase db, $PrintersTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrintersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrintersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrintersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> uniqueKey = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> connectionType = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> tcpHost = const Value.absent(),
                Value<int?> tcpPort = const Value.absent(),
                Value<int?> tcpConnectTimeoutMs = const Value.absent(),
                Value<int?> tcpWriteTimeoutMs = const Value.absent(),
                Value<int?> tcpReadTimeoutMs = const Value.absent(),
                Value<bool> tcpAutoReconnect = const Value.absent(),
                Value<int?> tcpReconnectDelayMs = const Value.absent(),
                Value<String?> tcpEncoding = const Value.absent(),
                Value<String?> tcpCodePage = const Value.absent(),
                Value<String?> tcpLineEnding = const Value.absent(),
                Value<bool> tcpKeepAlive = const Value.absent(),
                Value<bool> tcpNoDelay = const Value.absent(),
                Value<int?> tcpLingerSeconds = const Value.absent(),
                Value<String?> systemPrinterName = const Value.absent(),
                Value<String?> systemPaperSize = const Value.absent(),
                Value<int> systemDefaultCopies = const Value.absent(),
                Value<bool> systemColorEnabled = const Value.absent(),
                Value<String?> systemDuplexMode = const Value.absent(),
                Value<String?> systemOrientation = const Value.absent(),
                Value<int?> systemJobTimeoutMs = const Value.absent(),
                Value<String?> systemNotes = const Value.absent(),
                Value<String?> systemDriverName = const Value.absent(),
                Value<String?> systemQueueName = const Value.absent(),
                Value<String?> systemSpoolFormat = const Value.absent(),
                Value<bool> systemUseRawSpool = const Value.absent(),
                Value<String?> usbVendorId = const Value.absent(),
                Value<String?> usbProductId = const Value.absent(),
                Value<String?> usbSerialNumber = const Value.absent(),
                Value<int?> usbInterfaceNumber = const Value.absent(),
                Value<int?> usbOutEndpoint = const Value.absent(),
                Value<int?> usbInEndpoint = const Value.absent(),
                Value<int?> usbTimeoutMs = const Value.absent(),
                Value<String?> usbEncoding = const Value.absent(),
                Value<String?> usbCodePage = const Value.absent(),
                Value<String?> usbCharacterTable = const Value.absent(),
                Value<bool> usbAutoCutEnabled = const Value.absent(),
                Value<String?> usbCutMode = const Value.absent(),
                Value<bool> usbCashDrawerEnabled = const Value.absent(),
                Value<int?> usbDrawerPin = const Value.absent(),
                Value<bool> usbStatusMonitoringEnabled = const Value.absent(),
                Value<String?> usbManufacturer = const Value.absent(),
                Value<String?> usbProductName = const Value.absent(),
                Value<int?> usbAlternateSetting = const Value.absent(),
                Value<int?> usbPacketDelayMs = const Value.absent(),
                Value<String> rawGraphicsMode = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<String?> lastStatus = const Value.absent(),
                Value<String?> lastStatusKey = const Value.absent(),
                Value<String?> lastStatusMessage = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PrintersTableCompanion(
                id: id,
                uniqueKey: uniqueKey,
                name: name,
                description: description,
                connectionType: connectionType,
                address: address,
                tcpHost: tcpHost,
                tcpPort: tcpPort,
                tcpConnectTimeoutMs: tcpConnectTimeoutMs,
                tcpWriteTimeoutMs: tcpWriteTimeoutMs,
                tcpReadTimeoutMs: tcpReadTimeoutMs,
                tcpAutoReconnect: tcpAutoReconnect,
                tcpReconnectDelayMs: tcpReconnectDelayMs,
                tcpEncoding: tcpEncoding,
                tcpCodePage: tcpCodePage,
                tcpLineEnding: tcpLineEnding,
                tcpKeepAlive: tcpKeepAlive,
                tcpNoDelay: tcpNoDelay,
                tcpLingerSeconds: tcpLingerSeconds,
                systemPrinterName: systemPrinterName,
                systemPaperSize: systemPaperSize,
                systemDefaultCopies: systemDefaultCopies,
                systemColorEnabled: systemColorEnabled,
                systemDuplexMode: systemDuplexMode,
                systemOrientation: systemOrientation,
                systemJobTimeoutMs: systemJobTimeoutMs,
                systemNotes: systemNotes,
                systemDriverName: systemDriverName,
                systemQueueName: systemQueueName,
                systemSpoolFormat: systemSpoolFormat,
                systemUseRawSpool: systemUseRawSpool,
                usbVendorId: usbVendorId,
                usbProductId: usbProductId,
                usbSerialNumber: usbSerialNumber,
                usbInterfaceNumber: usbInterfaceNumber,
                usbOutEndpoint: usbOutEndpoint,
                usbInEndpoint: usbInEndpoint,
                usbTimeoutMs: usbTimeoutMs,
                usbEncoding: usbEncoding,
                usbCodePage: usbCodePage,
                usbCharacterTable: usbCharacterTable,
                usbAutoCutEnabled: usbAutoCutEnabled,
                usbCutMode: usbCutMode,
                usbCashDrawerEnabled: usbCashDrawerEnabled,
                usbDrawerPin: usbDrawerPin,
                usbStatusMonitoringEnabled: usbStatusMonitoringEnabled,
                usbManufacturer: usbManufacturer,
                usbProductName: usbProductName,
                usbAlternateSetting: usbAlternateSetting,
                usbPacketDelayMs: usbPacketDelayMs,
                rawGraphicsMode: rawGraphicsMode,
                isEnabled: isEnabled,
                lastStatus: lastStatus,
                lastStatusKey: lastStatusKey,
                lastStatusMessage: lastStatusMessage,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String> uniqueKey = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String> connectionType = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> tcpHost = const Value.absent(),
                Value<int?> tcpPort = const Value.absent(),
                Value<int?> tcpConnectTimeoutMs = const Value.absent(),
                Value<int?> tcpWriteTimeoutMs = const Value.absent(),
                Value<int?> tcpReadTimeoutMs = const Value.absent(),
                Value<bool> tcpAutoReconnect = const Value.absent(),
                Value<int?> tcpReconnectDelayMs = const Value.absent(),
                Value<String?> tcpEncoding = const Value.absent(),
                Value<String?> tcpCodePage = const Value.absent(),
                Value<String?> tcpLineEnding = const Value.absent(),
                Value<bool> tcpKeepAlive = const Value.absent(),
                Value<bool> tcpNoDelay = const Value.absent(),
                Value<int?> tcpLingerSeconds = const Value.absent(),
                Value<String?> systemPrinterName = const Value.absent(),
                Value<String?> systemPaperSize = const Value.absent(),
                Value<int> systemDefaultCopies = const Value.absent(),
                Value<bool> systemColorEnabled = const Value.absent(),
                Value<String?> systemDuplexMode = const Value.absent(),
                Value<String?> systemOrientation = const Value.absent(),
                Value<int?> systemJobTimeoutMs = const Value.absent(),
                Value<String?> systemNotes = const Value.absent(),
                Value<String?> systemDriverName = const Value.absent(),
                Value<String?> systemQueueName = const Value.absent(),
                Value<String?> systemSpoolFormat = const Value.absent(),
                Value<bool> systemUseRawSpool = const Value.absent(),
                Value<String?> usbVendorId = const Value.absent(),
                Value<String?> usbProductId = const Value.absent(),
                Value<String?> usbSerialNumber = const Value.absent(),
                Value<int?> usbInterfaceNumber = const Value.absent(),
                Value<int?> usbOutEndpoint = const Value.absent(),
                Value<int?> usbInEndpoint = const Value.absent(),
                Value<int?> usbTimeoutMs = const Value.absent(),
                Value<String?> usbEncoding = const Value.absent(),
                Value<String?> usbCodePage = const Value.absent(),
                Value<String?> usbCharacterTable = const Value.absent(),
                Value<bool> usbAutoCutEnabled = const Value.absent(),
                Value<String?> usbCutMode = const Value.absent(),
                Value<bool> usbCashDrawerEnabled = const Value.absent(),
                Value<int?> usbDrawerPin = const Value.absent(),
                Value<bool> usbStatusMonitoringEnabled = const Value.absent(),
                Value<String?> usbManufacturer = const Value.absent(),
                Value<String?> usbProductName = const Value.absent(),
                Value<int?> usbAlternateSetting = const Value.absent(),
                Value<int?> usbPacketDelayMs = const Value.absent(),
                Value<String> rawGraphicsMode = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<String?> lastStatus = const Value.absent(),
                Value<String?> lastStatusKey = const Value.absent(),
                Value<String?> lastStatusMessage = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => PrintersTableCompanion.insert(
                id: id,
                uniqueKey: uniqueKey,
                name: name,
                description: description,
                connectionType: connectionType,
                address: address,
                tcpHost: tcpHost,
                tcpPort: tcpPort,
                tcpConnectTimeoutMs: tcpConnectTimeoutMs,
                tcpWriteTimeoutMs: tcpWriteTimeoutMs,
                tcpReadTimeoutMs: tcpReadTimeoutMs,
                tcpAutoReconnect: tcpAutoReconnect,
                tcpReconnectDelayMs: tcpReconnectDelayMs,
                tcpEncoding: tcpEncoding,
                tcpCodePage: tcpCodePage,
                tcpLineEnding: tcpLineEnding,
                tcpKeepAlive: tcpKeepAlive,
                tcpNoDelay: tcpNoDelay,
                tcpLingerSeconds: tcpLingerSeconds,
                systemPrinterName: systemPrinterName,
                systemPaperSize: systemPaperSize,
                systemDefaultCopies: systemDefaultCopies,
                systemColorEnabled: systemColorEnabled,
                systemDuplexMode: systemDuplexMode,
                systemOrientation: systemOrientation,
                systemJobTimeoutMs: systemJobTimeoutMs,
                systemNotes: systemNotes,
                systemDriverName: systemDriverName,
                systemQueueName: systemQueueName,
                systemSpoolFormat: systemSpoolFormat,
                systemUseRawSpool: systemUseRawSpool,
                usbVendorId: usbVendorId,
                usbProductId: usbProductId,
                usbSerialNumber: usbSerialNumber,
                usbInterfaceNumber: usbInterfaceNumber,
                usbOutEndpoint: usbOutEndpoint,
                usbInEndpoint: usbInEndpoint,
                usbTimeoutMs: usbTimeoutMs,
                usbEncoding: usbEncoding,
                usbCodePage: usbCodePage,
                usbCharacterTable: usbCharacterTable,
                usbAutoCutEnabled: usbAutoCutEnabled,
                usbCutMode: usbCutMode,
                usbCashDrawerEnabled: usbCashDrawerEnabled,
                usbDrawerPin: usbDrawerPin,
                usbStatusMonitoringEnabled: usbStatusMonitoringEnabled,
                usbManufacturer: usbManufacturer,
                usbProductName: usbProductName,
                usbAlternateSetting: usbAlternateSetting,
                usbPacketDelayMs: usbPacketDelayMs,
                rawGraphicsMode: rawGraphicsMode,
                isEnabled: isEnabled,
                lastStatus: lastStatus,
                lastStatusKey: lastStatusKey,
                lastStatusMessage: lastStatusMessage,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PrintersTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({appPrintersTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (appPrintersTableRefs) db.appPrintersTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (appPrintersTableRefs)
                    await $_getPrefetchedData<
                      PrintersTableData,
                      $PrintersTableTable,
                      AppPrintersTableData
                    >(
                      currentTable: table,
                      referencedTable: $$PrintersTableTableReferences
                          ._appPrintersTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$PrintersTableTableReferences(
                            db,
                            table,
                            p0,
                          ).appPrintersTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.printerId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PrintersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PrintersTableTable,
      PrintersTableData,
      $$PrintersTableTableFilterComposer,
      $$PrintersTableTableOrderingComposer,
      $$PrintersTableTableAnnotationComposer,
      $$PrintersTableTableCreateCompanionBuilder,
      $$PrintersTableTableUpdateCompanionBuilder,
      (PrintersTableData, $$PrintersTableTableReferences),
      PrintersTableData,
      PrefetchHooks Function({bool appPrintersTableRefs})
    >;
typedef $$AppsTableTableCreateCompanionBuilder =
    AppsTableCompanion Function({
      required String id,
      required String name,
      Value<bool> isEnabled,
      Value<String?> description,
      required String apiKey,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$AppsTableTableUpdateCompanionBuilder =
    AppsTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<bool> isEnabled,
      Value<String?> description,
      Value<String> apiKey,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$AppsTableTableReferences
    extends BaseReferences<_$AppDatabase, $AppsTableTable, AppsTableData> {
  $$AppsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AppPrintersTableTable, List<AppPrintersTableData>>
  _appPrintersTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.appPrintersTable,
    aliasName: $_aliasNameGenerator(db.appsTable.id, db.appPrintersTable.appId),
  );

  $$AppPrintersTableTableProcessedTableManager get appPrintersTableRefs {
    final manager = $$AppPrintersTableTableTableManager(
      $_db,
      $_db.appPrintersTable,
    ).filter((f) => f.appId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _appPrintersTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AppsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AppsTableTable> {
  $$AppsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get apiKey => $composableBuilder(
    column: $table.apiKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> appPrintersTableRefs(
    Expression<bool> Function($$AppPrintersTableTableFilterComposer f) f,
  ) {
    final $$AppPrintersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.appPrintersTable,
      getReferencedColumn: (t) => t.appId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppPrintersTableTableFilterComposer(
            $db: $db,
            $table: $db.appPrintersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AppsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AppsTableTable> {
  $$AppsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get apiKey => $composableBuilder(
    column: $table.apiKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppsTableTable> {
  $$AppsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get apiKey =>
      $composableBuilder(column: $table.apiKey, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> appPrintersTableRefs<T extends Object>(
    Expression<T> Function($$AppPrintersTableTableAnnotationComposer a) f,
  ) {
    final $$AppPrintersTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.appPrintersTable,
      getReferencedColumn: (t) => t.appId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppPrintersTableTableAnnotationComposer(
            $db: $db,
            $table: $db.appPrintersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AppsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppsTableTable,
          AppsTableData,
          $$AppsTableTableFilterComposer,
          $$AppsTableTableOrderingComposer,
          $$AppsTableTableAnnotationComposer,
          $$AppsTableTableCreateCompanionBuilder,
          $$AppsTableTableUpdateCompanionBuilder,
          (AppsTableData, $$AppsTableTableReferences),
          AppsTableData,
          PrefetchHooks Function({bool appPrintersTableRefs})
        > {
  $$AppsTableTableTableManager(_$AppDatabase db, $AppsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> apiKey = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppsTableCompanion(
                id: id,
                name: name,
                isEnabled: isEnabled,
                description: description,
                apiKey: apiKey,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<bool> isEnabled = const Value.absent(),
                Value<String?> description = const Value.absent(),
                required String apiKey,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => AppsTableCompanion.insert(
                id: id,
                name: name,
                isEnabled: isEnabled,
                description: description,
                apiKey: apiKey,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AppsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({appPrintersTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (appPrintersTableRefs) db.appPrintersTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (appPrintersTableRefs)
                    await $_getPrefetchedData<
                      AppsTableData,
                      $AppsTableTable,
                      AppPrintersTableData
                    >(
                      currentTable: table,
                      referencedTable: $$AppsTableTableReferences
                          ._appPrintersTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$AppsTableTableReferences(
                            db,
                            table,
                            p0,
                          ).appPrintersTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.appId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AppsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppsTableTable,
      AppsTableData,
      $$AppsTableTableFilterComposer,
      $$AppsTableTableOrderingComposer,
      $$AppsTableTableAnnotationComposer,
      $$AppsTableTableCreateCompanionBuilder,
      $$AppsTableTableUpdateCompanionBuilder,
      (AppsTableData, $$AppsTableTableReferences),
      AppsTableData,
      PrefetchHooks Function({bool appPrintersTableRefs})
    >;
typedef $$AppPrintersTableTableCreateCompanionBuilder =
    AppPrintersTableCompanion Function({
      required String appId,
      required String printerId,
      Value<int> rowid,
    });
typedef $$AppPrintersTableTableUpdateCompanionBuilder =
    AppPrintersTableCompanion Function({
      Value<String> appId,
      Value<String> printerId,
      Value<int> rowid,
    });

final class $$AppPrintersTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $AppPrintersTableTable,
          AppPrintersTableData
        > {
  $$AppPrintersTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AppsTableTable _appIdTable(_$AppDatabase db) =>
      db.appsTable.createAlias(
        $_aliasNameGenerator(db.appPrintersTable.appId, db.appsTable.id),
      );

  $$AppsTableTableProcessedTableManager get appId {
    final $_column = $_itemColumn<String>('app_id')!;

    final manager = $$AppsTableTableTableManager(
      $_db,
      $_db.appsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_appIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PrintersTableTable _printerIdTable(_$AppDatabase db) =>
      db.printersTable.createAlias(
        $_aliasNameGenerator(
          db.appPrintersTable.printerId,
          db.printersTable.id,
        ),
      );

  $$PrintersTableTableProcessedTableManager get printerId {
    final $_column = $_itemColumn<String>('printer_id')!;

    final manager = $$PrintersTableTableTableManager(
      $_db,
      $_db.printersTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_printerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AppPrintersTableTableFilterComposer
    extends Composer<_$AppDatabase, $AppPrintersTableTable> {
  $$AppPrintersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$AppsTableTableFilterComposer get appId {
    final $$AppsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.appId,
      referencedTable: $db.appsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppsTableTableFilterComposer(
            $db: $db,
            $table: $db.appsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PrintersTableTableFilterComposer get printerId {
    final $$PrintersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.printerId,
      referencedTable: $db.printersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrintersTableTableFilterComposer(
            $db: $db,
            $table: $db.printersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppPrintersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AppPrintersTableTable> {
  $$AppPrintersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$AppsTableTableOrderingComposer get appId {
    final $$AppsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.appId,
      referencedTable: $db.appsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppsTableTableOrderingComposer(
            $db: $db,
            $table: $db.appsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PrintersTableTableOrderingComposer get printerId {
    final $$PrintersTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.printerId,
      referencedTable: $db.printersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrintersTableTableOrderingComposer(
            $db: $db,
            $table: $db.printersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppPrintersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppPrintersTableTable> {
  $$AppPrintersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$AppsTableTableAnnotationComposer get appId {
    final $$AppsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.appId,
      referencedTable: $db.appsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.appsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PrintersTableTableAnnotationComposer get printerId {
    final $$PrintersTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.printerId,
      referencedTable: $db.printersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrintersTableTableAnnotationComposer(
            $db: $db,
            $table: $db.printersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppPrintersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppPrintersTableTable,
          AppPrintersTableData,
          $$AppPrintersTableTableFilterComposer,
          $$AppPrintersTableTableOrderingComposer,
          $$AppPrintersTableTableAnnotationComposer,
          $$AppPrintersTableTableCreateCompanionBuilder,
          $$AppPrintersTableTableUpdateCompanionBuilder,
          (AppPrintersTableData, $$AppPrintersTableTableReferences),
          AppPrintersTableData,
          PrefetchHooks Function({bool appId, bool printerId})
        > {
  $$AppPrintersTableTableTableManager(
    _$AppDatabase db,
    $AppPrintersTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppPrintersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppPrintersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppPrintersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> appId = const Value.absent(),
                Value<String> printerId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppPrintersTableCompanion(
                appId: appId,
                printerId: printerId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String appId,
                required String printerId,
                Value<int> rowid = const Value.absent(),
              }) => AppPrintersTableCompanion.insert(
                appId: appId,
                printerId: printerId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AppPrintersTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({appId = false, printerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (appId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.appId,
                                referencedTable:
                                    $$AppPrintersTableTableReferences
                                        ._appIdTable(db),
                                referencedColumn:
                                    $$AppPrintersTableTableReferences
                                        ._appIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (printerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.printerId,
                                referencedTable:
                                    $$AppPrintersTableTableReferences
                                        ._printerIdTable(db),
                                referencedColumn:
                                    $$AppPrintersTableTableReferences
                                        ._printerIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AppPrintersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppPrintersTableTable,
      AppPrintersTableData,
      $$AppPrintersTableTableFilterComposer,
      $$AppPrintersTableTableOrderingComposer,
      $$AppPrintersTableTableAnnotationComposer,
      $$AppPrintersTableTableCreateCompanionBuilder,
      $$AppPrintersTableTableUpdateCompanionBuilder,
      (AppPrintersTableData, $$AppPrintersTableTableReferences),
      AppPrintersTableData,
      PrefetchHooks Function({bool appId, bool printerId})
    >;
typedef $$PrintJobsTableTableCreateCompanionBuilder =
    PrintJobsTableCompanion Function({
      required String id,
      Value<String?> printerId,
      Value<String?> appId,
      required String title,
      Value<String> status,
      Value<String?> contentType,
      Value<int> copies,
      Value<String?> payloadSourceType,
      Value<String?> payloadSummary,
      Value<String?> artifactPath,
      Value<String?> artifactMimeType,
      Value<int?> artifactSize,
      Value<DateTime?> artifactCreatedAt,
      Value<String?> artifactChecksum,
      Value<String?> optionsJson,
      Value<String?> metaJson,
      Value<String?> referenceType,
      Value<String?> referenceId,
      Value<String?> source,
      Value<String?> idempotencyKey,
      Value<String?> failureCategory,
      Value<String?> failureMessage,
      Value<int> retryCount,
      Value<DateTime?> lastRetryAt,
      Value<DateTime?> nextRetryAt,
      Value<DateTime?> queuedAt,
      Value<DateTime?> startedAt,
      Value<DateTime?> completedAt,
      Value<DateTime?> canceledAt,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$PrintJobsTableTableUpdateCompanionBuilder =
    PrintJobsTableCompanion Function({
      Value<String> id,
      Value<String?> printerId,
      Value<String?> appId,
      Value<String> title,
      Value<String> status,
      Value<String?> contentType,
      Value<int> copies,
      Value<String?> payloadSourceType,
      Value<String?> payloadSummary,
      Value<String?> artifactPath,
      Value<String?> artifactMimeType,
      Value<int?> artifactSize,
      Value<DateTime?> artifactCreatedAt,
      Value<String?> artifactChecksum,
      Value<String?> optionsJson,
      Value<String?> metaJson,
      Value<String?> referenceType,
      Value<String?> referenceId,
      Value<String?> source,
      Value<String?> idempotencyKey,
      Value<String?> failureCategory,
      Value<String?> failureMessage,
      Value<int> retryCount,
      Value<DateTime?> lastRetryAt,
      Value<DateTime?> nextRetryAt,
      Value<DateTime?> queuedAt,
      Value<DateTime?> startedAt,
      Value<DateTime?> completedAt,
      Value<DateTime?> canceledAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$PrintJobsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PrintJobsTableTable> {
  $$PrintJobsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get printerId => $composableBuilder(
    column: $table.printerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get appId => $composableBuilder(
    column: $table.appId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get copies => $composableBuilder(
    column: $table.copies,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadSourceType => $composableBuilder(
    column: $table.payloadSourceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadSummary => $composableBuilder(
    column: $table.payloadSummary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artifactPath => $composableBuilder(
    column: $table.artifactPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artifactMimeType => $composableBuilder(
    column: $table.artifactMimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get artifactSize => $composableBuilder(
    column: $table.artifactSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get artifactCreatedAt => $composableBuilder(
    column: $table.artifactCreatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artifactChecksum => $composableBuilder(
    column: $table.artifactChecksum,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get optionsJson => $composableBuilder(
    column: $table.optionsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metaJson => $composableBuilder(
    column: $table.metaJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceType => $composableBuilder(
    column: $table.referenceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get failureCategory => $composableBuilder(
    column: $table.failureCategory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get failureMessage => $composableBuilder(
    column: $table.failureMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastRetryAt => $composableBuilder(
    column: $table.lastRetryAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextRetryAt => $composableBuilder(
    column: $table.nextRetryAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get queuedAt => $composableBuilder(
    column: $table.queuedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get canceledAt => $composableBuilder(
    column: $table.canceledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PrintJobsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PrintJobsTableTable> {
  $$PrintJobsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get printerId => $composableBuilder(
    column: $table.printerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get appId => $composableBuilder(
    column: $table.appId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get copies => $composableBuilder(
    column: $table.copies,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadSourceType => $composableBuilder(
    column: $table.payloadSourceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadSummary => $composableBuilder(
    column: $table.payloadSummary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artifactPath => $composableBuilder(
    column: $table.artifactPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artifactMimeType => $composableBuilder(
    column: $table.artifactMimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get artifactSize => $composableBuilder(
    column: $table.artifactSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get artifactCreatedAt => $composableBuilder(
    column: $table.artifactCreatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artifactChecksum => $composableBuilder(
    column: $table.artifactChecksum,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get optionsJson => $composableBuilder(
    column: $table.optionsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metaJson => $composableBuilder(
    column: $table.metaJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceType => $composableBuilder(
    column: $table.referenceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get failureCategory => $composableBuilder(
    column: $table.failureCategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get failureMessage => $composableBuilder(
    column: $table.failureMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastRetryAt => $composableBuilder(
    column: $table.lastRetryAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextRetryAt => $composableBuilder(
    column: $table.nextRetryAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get queuedAt => $composableBuilder(
    column: $table.queuedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get canceledAt => $composableBuilder(
    column: $table.canceledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PrintJobsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrintJobsTableTable> {
  $$PrintJobsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get printerId =>
      $composableBuilder(column: $table.printerId, builder: (column) => column);

  GeneratedColumn<String> get appId =>
      $composableBuilder(column: $table.appId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get copies =>
      $composableBuilder(column: $table.copies, builder: (column) => column);

  GeneratedColumn<String> get payloadSourceType => $composableBuilder(
    column: $table.payloadSourceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payloadSummary => $composableBuilder(
    column: $table.payloadSummary,
    builder: (column) => column,
  );

  GeneratedColumn<String> get artifactPath => $composableBuilder(
    column: $table.artifactPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get artifactMimeType => $composableBuilder(
    column: $table.artifactMimeType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get artifactSize => $composableBuilder(
    column: $table.artifactSize,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get artifactCreatedAt => $composableBuilder(
    column: $table.artifactCreatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get artifactChecksum => $composableBuilder(
    column: $table.artifactChecksum,
    builder: (column) => column,
  );

  GeneratedColumn<String> get optionsJson => $composableBuilder(
    column: $table.optionsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metaJson =>
      $composableBuilder(column: $table.metaJson, builder: (column) => column);

  GeneratedColumn<String> get referenceType => $composableBuilder(
    column: $table.referenceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get failureCategory => $composableBuilder(
    column: $table.failureCategory,
    builder: (column) => column,
  );

  GeneratedColumn<String> get failureMessage => $composableBuilder(
    column: $table.failureMessage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastRetryAt => $composableBuilder(
    column: $table.lastRetryAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextRetryAt => $composableBuilder(
    column: $table.nextRetryAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get queuedAt =>
      $composableBuilder(column: $table.queuedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get canceledAt => $composableBuilder(
    column: $table.canceledAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PrintJobsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PrintJobsTableTable,
          PrintJobsTableData,
          $$PrintJobsTableTableFilterComposer,
          $$PrintJobsTableTableOrderingComposer,
          $$PrintJobsTableTableAnnotationComposer,
          $$PrintJobsTableTableCreateCompanionBuilder,
          $$PrintJobsTableTableUpdateCompanionBuilder,
          (
            PrintJobsTableData,
            BaseReferences<
              _$AppDatabase,
              $PrintJobsTableTable,
              PrintJobsTableData
            >,
          ),
          PrintJobsTableData,
          PrefetchHooks Function()
        > {
  $$PrintJobsTableTableTableManager(
    _$AppDatabase db,
    $PrintJobsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrintJobsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrintJobsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrintJobsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> printerId = const Value.absent(),
                Value<String?> appId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> contentType = const Value.absent(),
                Value<int> copies = const Value.absent(),
                Value<String?> payloadSourceType = const Value.absent(),
                Value<String?> payloadSummary = const Value.absent(),
                Value<String?> artifactPath = const Value.absent(),
                Value<String?> artifactMimeType = const Value.absent(),
                Value<int?> artifactSize = const Value.absent(),
                Value<DateTime?> artifactCreatedAt = const Value.absent(),
                Value<String?> artifactChecksum = const Value.absent(),
                Value<String?> optionsJson = const Value.absent(),
                Value<String?> metaJson = const Value.absent(),
                Value<String?> referenceType = const Value.absent(),
                Value<String?> referenceId = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<String?> idempotencyKey = const Value.absent(),
                Value<String?> failureCategory = const Value.absent(),
                Value<String?> failureMessage = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<DateTime?> lastRetryAt = const Value.absent(),
                Value<DateTime?> nextRetryAt = const Value.absent(),
                Value<DateTime?> queuedAt = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime?> canceledAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PrintJobsTableCompanion(
                id: id,
                printerId: printerId,
                appId: appId,
                title: title,
                status: status,
                contentType: contentType,
                copies: copies,
                payloadSourceType: payloadSourceType,
                payloadSummary: payloadSummary,
                artifactPath: artifactPath,
                artifactMimeType: artifactMimeType,
                artifactSize: artifactSize,
                artifactCreatedAt: artifactCreatedAt,
                artifactChecksum: artifactChecksum,
                optionsJson: optionsJson,
                metaJson: metaJson,
                referenceType: referenceType,
                referenceId: referenceId,
                source: source,
                idempotencyKey: idempotencyKey,
                failureCategory: failureCategory,
                failureMessage: failureMessage,
                retryCount: retryCount,
                lastRetryAt: lastRetryAt,
                nextRetryAt: nextRetryAt,
                queuedAt: queuedAt,
                startedAt: startedAt,
                completedAt: completedAt,
                canceledAt: canceledAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> printerId = const Value.absent(),
                Value<String?> appId = const Value.absent(),
                required String title,
                Value<String> status = const Value.absent(),
                Value<String?> contentType = const Value.absent(),
                Value<int> copies = const Value.absent(),
                Value<String?> payloadSourceType = const Value.absent(),
                Value<String?> payloadSummary = const Value.absent(),
                Value<String?> artifactPath = const Value.absent(),
                Value<String?> artifactMimeType = const Value.absent(),
                Value<int?> artifactSize = const Value.absent(),
                Value<DateTime?> artifactCreatedAt = const Value.absent(),
                Value<String?> artifactChecksum = const Value.absent(),
                Value<String?> optionsJson = const Value.absent(),
                Value<String?> metaJson = const Value.absent(),
                Value<String?> referenceType = const Value.absent(),
                Value<String?> referenceId = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<String?> idempotencyKey = const Value.absent(),
                Value<String?> failureCategory = const Value.absent(),
                Value<String?> failureMessage = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<DateTime?> lastRetryAt = const Value.absent(),
                Value<DateTime?> nextRetryAt = const Value.absent(),
                Value<DateTime?> queuedAt = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime?> canceledAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => PrintJobsTableCompanion.insert(
                id: id,
                printerId: printerId,
                appId: appId,
                title: title,
                status: status,
                contentType: contentType,
                copies: copies,
                payloadSourceType: payloadSourceType,
                payloadSummary: payloadSummary,
                artifactPath: artifactPath,
                artifactMimeType: artifactMimeType,
                artifactSize: artifactSize,
                artifactCreatedAt: artifactCreatedAt,
                artifactChecksum: artifactChecksum,
                optionsJson: optionsJson,
                metaJson: metaJson,
                referenceType: referenceType,
                referenceId: referenceId,
                source: source,
                idempotencyKey: idempotencyKey,
                failureCategory: failureCategory,
                failureMessage: failureMessage,
                retryCount: retryCount,
                lastRetryAt: lastRetryAt,
                nextRetryAt: nextRetryAt,
                queuedAt: queuedAt,
                startedAt: startedAt,
                completedAt: completedAt,
                canceledAt: canceledAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PrintJobsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PrintJobsTableTable,
      PrintJobsTableData,
      $$PrintJobsTableTableFilterComposer,
      $$PrintJobsTableTableOrderingComposer,
      $$PrintJobsTableTableAnnotationComposer,
      $$PrintJobsTableTableCreateCompanionBuilder,
      $$PrintJobsTableTableUpdateCompanionBuilder,
      (
        PrintJobsTableData,
        BaseReferences<_$AppDatabase, $PrintJobsTableTable, PrintJobsTableData>,
      ),
      PrintJobsTableData,
      PrefetchHooks Function()
    >;
typedef $$LogsTableTableCreateCompanionBuilder =
    LogsTableCompanion Function({
      required String id,
      required String level,
      required String eventType,
      required String title,
      required String message,
      Value<String?> metadata,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$LogsTableTableUpdateCompanionBuilder =
    LogsTableCompanion Function({
      Value<String> id,
      Value<String> level,
      Value<String> eventType,
      Value<String> title,
      Value<String> message,
      Value<String?> metadata,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$LogsTableTableFilterComposer
    extends Composer<_$AppDatabase, $LogsTableTable> {
  $$LogsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LogsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $LogsTableTable> {
  $$LogsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LogsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $LogsTableTable> {
  $$LogsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$LogsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LogsTableTable,
          LogsTableData,
          $$LogsTableTableFilterComposer,
          $$LogsTableTableOrderingComposer,
          $$LogsTableTableAnnotationComposer,
          $$LogsTableTableCreateCompanionBuilder,
          $$LogsTableTableUpdateCompanionBuilder,
          (
            LogsTableData,
            BaseReferences<_$AppDatabase, $LogsTableTable, LogsTableData>,
          ),
          LogsTableData,
          PrefetchHooks Function()
        > {
  $$LogsTableTableTableManager(_$AppDatabase db, $LogsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LogsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LogsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LogsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> level = const Value.absent(),
                Value<String> eventType = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<String?> metadata = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LogsTableCompanion(
                id: id,
                level: level,
                eventType: eventType,
                title: title,
                message: message,
                metadata: metadata,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String level,
                required String eventType,
                required String title,
                required String message,
                Value<String?> metadata = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => LogsTableCompanion.insert(
                id: id,
                level: level,
                eventType: eventType,
                title: title,
                message: message,
                metadata: metadata,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LogsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LogsTableTable,
      LogsTableData,
      $$LogsTableTableFilterComposer,
      $$LogsTableTableOrderingComposer,
      $$LogsTableTableAnnotationComposer,
      $$LogsTableTableCreateCompanionBuilder,
      $$LogsTableTableUpdateCompanionBuilder,
      (
        LogsTableData,
        BaseReferences<_$AppDatabase, $LogsTableTable, LogsTableData>,
      ),
      LogsTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SettingsTableTableTableManager get settingsTable =>
      $$SettingsTableTableTableManager(_db, _db.settingsTable);
  $$PrintersTableTableTableManager get printersTable =>
      $$PrintersTableTableTableManager(_db, _db.printersTable);
  $$AppsTableTableTableManager get appsTable =>
      $$AppsTableTableTableManager(_db, _db.appsTable);
  $$AppPrintersTableTableTableManager get appPrintersTable =>
      $$AppPrintersTableTableTableManager(_db, _db.appPrintersTable);
  $$PrintJobsTableTableTableManager get printJobsTable =>
      $$PrintJobsTableTableTableManager(_db, _db.printJobsTable);
  $$LogsTableTableTableManager get logsTable =>
      $$LogsTableTableTableManager(_db, _db.logsTable);
}

mixin _$PrintersDaoMixin on DatabaseAccessor<AppDatabase> {
  $PrintersTableTable get printersTable => attachedDatabase.printersTable;
  PrintersDaoManager get managers => PrintersDaoManager(this);
}

class PrintersDaoManager {
  final _$PrintersDaoMixin _db;
  PrintersDaoManager(this._db);
  $$PrintersTableTableTableManager get printersTable =>
      $$PrintersTableTableTableManager(_db.attachedDatabase, _db.printersTable);
}

mixin _$AppsDaoMixin on DatabaseAccessor<AppDatabase> {
  $AppsTableTable get appsTable => attachedDatabase.appsTable;
  $PrintersTableTable get printersTable => attachedDatabase.printersTable;
  $AppPrintersTableTable get appPrintersTable =>
      attachedDatabase.appPrintersTable;
  AppsDaoManager get managers => AppsDaoManager(this);
}

class AppsDaoManager {
  final _$AppsDaoMixin _db;
  AppsDaoManager(this._db);
  $$AppsTableTableTableManager get appsTable =>
      $$AppsTableTableTableManager(_db.attachedDatabase, _db.appsTable);
  $$PrintersTableTableTableManager get printersTable =>
      $$PrintersTableTableTableManager(_db.attachedDatabase, _db.printersTable);
  $$AppPrintersTableTableTableManager get appPrintersTable =>
      $$AppPrintersTableTableTableManager(
        _db.attachedDatabase,
        _db.appPrintersTable,
      );
}

mixin _$PrintJobsDaoMixin on DatabaseAccessor<AppDatabase> {
  $PrintJobsTableTable get printJobsTable => attachedDatabase.printJobsTable;
  PrintJobsDaoManager get managers => PrintJobsDaoManager(this);
}

class PrintJobsDaoManager {
  final _$PrintJobsDaoMixin _db;
  PrintJobsDaoManager(this._db);
  $$PrintJobsTableTableTableManager get printJobsTable =>
      $$PrintJobsTableTableTableManager(
        _db.attachedDatabase,
        _db.printJobsTable,
      );
}

mixin _$LogsDaoMixin on DatabaseAccessor<AppDatabase> {
  $LogsTableTable get logsTable => attachedDatabase.logsTable;
  LogsDaoManager get managers => LogsDaoManager(this);
}

class LogsDaoManager {
  final _$LogsDaoMixin _db;
  LogsDaoManager(this._db);
  $$LogsTableTableTableManager get logsTable =>
      $$LogsTableTableTableManager(_db.attachedDatabase, _db.logsTable);
}
