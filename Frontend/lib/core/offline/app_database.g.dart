// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $OutboxTransactionsTable extends OutboxTransactions
    with TableInfo<$OutboxTransactionsTable, OutboxTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OutboxTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _clientTxnIdMeta =
      const VerificationMeta('clientTxnId');
  @override
  late final GeneratedColumn<String> clientTxnId = GeneratedColumn<String>(
      'client_txn_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _deviceSeqMeta =
      const VerificationMeta('deviceSeq');
  @override
  late final GeneratedColumn<int> deviceSeq = GeneratedColumn<int>(
      'device_seq', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _txnTypeMeta =
      const VerificationMeta('txnType');
  @override
  late final GeneratedColumn<String> txnType = GeneratedColumn<String>(
      'txn_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadMeta =
      const VerificationMeta('payload');
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
      'payload', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _scannedAtMeta =
      const VerificationMeta('scannedAt');
  @override
  late final GeneratedColumn<DateTime> scannedAt = GeneratedColumn<DateTime>(
      'scanned_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _userCodeMeta =
      const VerificationMeta('userCode');
  @override
  late final GeneratedColumn<String> userCode = GeneratedColumn<String>(
      'user_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<OutboxStatus, String> status =
      GeneratedColumn<String>('status', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('pending'))
          .withConverter<OutboxStatus>(
              $OutboxTransactionsTable.$converterstatus);
  static const VerificationMeta _attemptsMeta =
      const VerificationMeta('attempts');
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
      'attempts', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _nextAttemptAtMeta =
      const VerificationMeta('nextAttemptAt');
  @override
  late final GeneratedColumn<DateTime> nextAttemptAt =
      GeneratedColumn<DateTime>('next_attempt_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _lastErrorMeta =
      const VerificationMeta('lastError');
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
      'last_error', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastErrorCodeMeta =
      const VerificationMeta('lastErrorCode');
  @override
  late final GeneratedColumn<String> lastErrorCode = GeneratedColumn<String>(
      'last_error_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _serverResultMeta =
      const VerificationMeta('serverResult');
  @override
  late final GeneratedColumn<String> serverResult = GeneratedColumn<String>(
      'server_result', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        clientTxnId,
        deviceSeq,
        txnType,
        payload,
        scannedAt,
        userCode,
        status,
        attempts,
        nextAttemptAt,
        lastError,
        lastErrorCode,
        serverResult,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'outbox_transactions';
  @override
  VerificationContext validateIntegrity(Insertable<OutboxTransaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('client_txn_id')) {
      context.handle(
          _clientTxnIdMeta,
          clientTxnId.isAcceptableOrUnknown(
              data['client_txn_id']!, _clientTxnIdMeta));
    } else if (isInserting) {
      context.missing(_clientTxnIdMeta);
    }
    if (data.containsKey('device_seq')) {
      context.handle(_deviceSeqMeta,
          deviceSeq.isAcceptableOrUnknown(data['device_seq']!, _deviceSeqMeta));
    } else if (isInserting) {
      context.missing(_deviceSeqMeta);
    }
    if (data.containsKey('txn_type')) {
      context.handle(_txnTypeMeta,
          txnType.isAcceptableOrUnknown(data['txn_type']!, _txnTypeMeta));
    } else if (isInserting) {
      context.missing(_txnTypeMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('scanned_at')) {
      context.handle(_scannedAtMeta,
          scannedAt.isAcceptableOrUnknown(data['scanned_at']!, _scannedAtMeta));
    } else if (isInserting) {
      context.missing(_scannedAtMeta);
    }
    if (data.containsKey('user_code')) {
      context.handle(_userCodeMeta,
          userCode.isAcceptableOrUnknown(data['user_code']!, _userCodeMeta));
    }
    if (data.containsKey('attempts')) {
      context.handle(_attemptsMeta,
          attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta));
    }
    if (data.containsKey('next_attempt_at')) {
      context.handle(
          _nextAttemptAtMeta,
          nextAttemptAt.isAcceptableOrUnknown(
              data['next_attempt_at']!, _nextAttemptAtMeta));
    }
    if (data.containsKey('last_error')) {
      context.handle(_lastErrorMeta,
          lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta));
    }
    if (data.containsKey('last_error_code')) {
      context.handle(
          _lastErrorCodeMeta,
          lastErrorCode.isAcceptableOrUnknown(
              data['last_error_code']!, _lastErrorCodeMeta));
    }
    if (data.containsKey('server_result')) {
      context.handle(
          _serverResultMeta,
          serverResult.isAcceptableOrUnknown(
              data['server_result']!, _serverResultMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OutboxTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OutboxTransaction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      clientTxnId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}client_txn_id'])!,
      deviceSeq: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}device_seq'])!,
      txnType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}txn_type'])!,
      payload: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload'])!,
      scannedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}scanned_at'])!,
      userCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_code']),
      status: $OutboxTransactionsTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!),
      attempts: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}attempts'])!,
      nextAttemptAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}next_attempt_at']),
      lastError: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_error']),
      lastErrorCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_error_code']),
      serverResult: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}server_result']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $OutboxTransactionsTable createAlias(String alias) {
    return $OutboxTransactionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<OutboxStatus, String, String> $converterstatus =
      const EnumNameConverter<OutboxStatus>(OutboxStatus.values);
}

class OutboxTransaction extends DataClass
    implements Insertable<OutboxTransaction> {
  final int id;

  /// Minted on this device before the first send and never regenerated. The
  /// server's unique index on (device_id, client_txn_id) turns a second
  /// delivery into "already stored" instead of a second pallet — which is what
  /// makes it safe to re-send a batch whose acknowledgement was lost.
  final String clientTxnId;

  /// Monotonic per device. The server replays in this order and never in
  /// arrival order, so a putaway can never be applied before the pallet close
  /// it depends on.
  final int deviceSeq;

  /// One of the types the server's HANDLERS registry knows — PACK_SCAN_WHEEL,
  /// PALLET_CLOSE, PUTAWAY, PICK_SCAN and so on.
  final String txnType;

  /// The request body the online call would have sent, as JSON.
  final String payload;

  /// When it happened on the floor — not when it was sent. SSR §11.3 keeps both
  /// clocks, and this is the one that orders the shift.
  final DateTime scannedAt;

  /// Badge of the operator, captured at scan time. Guns are shared across a
  /// shift, so the person who did the work is not necessarily the session the
  /// batch travels under.
  final String? userCode;
  final OutboxStatus status;
  final int attempts;
  final DateTime? nextAttemptAt;
  final String? lastError;
  final String? lastErrorCode;

  /// The server's answer once it arrives, as JSON — the pallet number actually
  /// issued, the location confirmed. Null while queued, because offline the
  /// device genuinely does not know yet.
  final String? serverResult;
  final DateTime createdAt;
  final DateTime updatedAt;
  const OutboxTransaction(
      {required this.id,
      required this.clientTxnId,
      required this.deviceSeq,
      required this.txnType,
      required this.payload,
      required this.scannedAt,
      this.userCode,
      required this.status,
      required this.attempts,
      this.nextAttemptAt,
      this.lastError,
      this.lastErrorCode,
      this.serverResult,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['client_txn_id'] = Variable<String>(clientTxnId);
    map['device_seq'] = Variable<int>(deviceSeq);
    map['txn_type'] = Variable<String>(txnType);
    map['payload'] = Variable<String>(payload);
    map['scanned_at'] = Variable<DateTime>(scannedAt);
    if (!nullToAbsent || userCode != null) {
      map['user_code'] = Variable<String>(userCode);
    }
    {
      map['status'] = Variable<String>(
          $OutboxTransactionsTable.$converterstatus.toSql(status));
    }
    map['attempts'] = Variable<int>(attempts);
    if (!nullToAbsent || nextAttemptAt != null) {
      map['next_attempt_at'] = Variable<DateTime>(nextAttemptAt);
    }
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    if (!nullToAbsent || lastErrorCode != null) {
      map['last_error_code'] = Variable<String>(lastErrorCode);
    }
    if (!nullToAbsent || serverResult != null) {
      map['server_result'] = Variable<String>(serverResult);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  OutboxTransactionsCompanion toCompanion(bool nullToAbsent) {
    return OutboxTransactionsCompanion(
      id: Value(id),
      clientTxnId: Value(clientTxnId),
      deviceSeq: Value(deviceSeq),
      txnType: Value(txnType),
      payload: Value(payload),
      scannedAt: Value(scannedAt),
      userCode: userCode == null && nullToAbsent
          ? const Value.absent()
          : Value(userCode),
      status: Value(status),
      attempts: Value(attempts),
      nextAttemptAt: nextAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(nextAttemptAt),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      lastErrorCode: lastErrorCode == null && nullToAbsent
          ? const Value.absent()
          : Value(lastErrorCode),
      serverResult: serverResult == null && nullToAbsent
          ? const Value.absent()
          : Value(serverResult),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory OutboxTransaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OutboxTransaction(
      id: serializer.fromJson<int>(json['id']),
      clientTxnId: serializer.fromJson<String>(json['clientTxnId']),
      deviceSeq: serializer.fromJson<int>(json['deviceSeq']),
      txnType: serializer.fromJson<String>(json['txnType']),
      payload: serializer.fromJson<String>(json['payload']),
      scannedAt: serializer.fromJson<DateTime>(json['scannedAt']),
      userCode: serializer.fromJson<String?>(json['userCode']),
      status: $OutboxTransactionsTable.$converterstatus
          .fromJson(serializer.fromJson<String>(json['status'])),
      attempts: serializer.fromJson<int>(json['attempts']),
      nextAttemptAt: serializer.fromJson<DateTime?>(json['nextAttemptAt']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      lastErrorCode: serializer.fromJson<String?>(json['lastErrorCode']),
      serverResult: serializer.fromJson<String?>(json['serverResult']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientTxnId': serializer.toJson<String>(clientTxnId),
      'deviceSeq': serializer.toJson<int>(deviceSeq),
      'txnType': serializer.toJson<String>(txnType),
      'payload': serializer.toJson<String>(payload),
      'scannedAt': serializer.toJson<DateTime>(scannedAt),
      'userCode': serializer.toJson<String?>(userCode),
      'status': serializer.toJson<String>(
          $OutboxTransactionsTable.$converterstatus.toJson(status)),
      'attempts': serializer.toJson<int>(attempts),
      'nextAttemptAt': serializer.toJson<DateTime?>(nextAttemptAt),
      'lastError': serializer.toJson<String?>(lastError),
      'lastErrorCode': serializer.toJson<String?>(lastErrorCode),
      'serverResult': serializer.toJson<String?>(serverResult),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  OutboxTransaction copyWith(
          {int? id,
          String? clientTxnId,
          int? deviceSeq,
          String? txnType,
          String? payload,
          DateTime? scannedAt,
          Value<String?> userCode = const Value.absent(),
          OutboxStatus? status,
          int? attempts,
          Value<DateTime?> nextAttemptAt = const Value.absent(),
          Value<String?> lastError = const Value.absent(),
          Value<String?> lastErrorCode = const Value.absent(),
          Value<String?> serverResult = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      OutboxTransaction(
        id: id ?? this.id,
        clientTxnId: clientTxnId ?? this.clientTxnId,
        deviceSeq: deviceSeq ?? this.deviceSeq,
        txnType: txnType ?? this.txnType,
        payload: payload ?? this.payload,
        scannedAt: scannedAt ?? this.scannedAt,
        userCode: userCode.present ? userCode.value : this.userCode,
        status: status ?? this.status,
        attempts: attempts ?? this.attempts,
        nextAttemptAt:
            nextAttemptAt.present ? nextAttemptAt.value : this.nextAttemptAt,
        lastError: lastError.present ? lastError.value : this.lastError,
        lastErrorCode:
            lastErrorCode.present ? lastErrorCode.value : this.lastErrorCode,
        serverResult:
            serverResult.present ? serverResult.value : this.serverResult,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  OutboxTransaction copyWithCompanion(OutboxTransactionsCompanion data) {
    return OutboxTransaction(
      id: data.id.present ? data.id.value : this.id,
      clientTxnId:
          data.clientTxnId.present ? data.clientTxnId.value : this.clientTxnId,
      deviceSeq: data.deviceSeq.present ? data.deviceSeq.value : this.deviceSeq,
      txnType: data.txnType.present ? data.txnType.value : this.txnType,
      payload: data.payload.present ? data.payload.value : this.payload,
      scannedAt: data.scannedAt.present ? data.scannedAt.value : this.scannedAt,
      userCode: data.userCode.present ? data.userCode.value : this.userCode,
      status: data.status.present ? data.status.value : this.status,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      nextAttemptAt: data.nextAttemptAt.present
          ? data.nextAttemptAt.value
          : this.nextAttemptAt,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      lastErrorCode: data.lastErrorCode.present
          ? data.lastErrorCode.value
          : this.lastErrorCode,
      serverResult: data.serverResult.present
          ? data.serverResult.value
          : this.serverResult,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OutboxTransaction(')
          ..write('id: $id, ')
          ..write('clientTxnId: $clientTxnId, ')
          ..write('deviceSeq: $deviceSeq, ')
          ..write('txnType: $txnType, ')
          ..write('payload: $payload, ')
          ..write('scannedAt: $scannedAt, ')
          ..write('userCode: $userCode, ')
          ..write('status: $status, ')
          ..write('attempts: $attempts, ')
          ..write('nextAttemptAt: $nextAttemptAt, ')
          ..write('lastError: $lastError, ')
          ..write('lastErrorCode: $lastErrorCode, ')
          ..write('serverResult: $serverResult, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      clientTxnId,
      deviceSeq,
      txnType,
      payload,
      scannedAt,
      userCode,
      status,
      attempts,
      nextAttemptAt,
      lastError,
      lastErrorCode,
      serverResult,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OutboxTransaction &&
          other.id == this.id &&
          other.clientTxnId == this.clientTxnId &&
          other.deviceSeq == this.deviceSeq &&
          other.txnType == this.txnType &&
          other.payload == this.payload &&
          other.scannedAt == this.scannedAt &&
          other.userCode == this.userCode &&
          other.status == this.status &&
          other.attempts == this.attempts &&
          other.nextAttemptAt == this.nextAttemptAt &&
          other.lastError == this.lastError &&
          other.lastErrorCode == this.lastErrorCode &&
          other.serverResult == this.serverResult &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class OutboxTransactionsCompanion extends UpdateCompanion<OutboxTransaction> {
  final Value<int> id;
  final Value<String> clientTxnId;
  final Value<int> deviceSeq;
  final Value<String> txnType;
  final Value<String> payload;
  final Value<DateTime> scannedAt;
  final Value<String?> userCode;
  final Value<OutboxStatus> status;
  final Value<int> attempts;
  final Value<DateTime?> nextAttemptAt;
  final Value<String?> lastError;
  final Value<String?> lastErrorCode;
  final Value<String?> serverResult;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const OutboxTransactionsCompanion({
    this.id = const Value.absent(),
    this.clientTxnId = const Value.absent(),
    this.deviceSeq = const Value.absent(),
    this.txnType = const Value.absent(),
    this.payload = const Value.absent(),
    this.scannedAt = const Value.absent(),
    this.userCode = const Value.absent(),
    this.status = const Value.absent(),
    this.attempts = const Value.absent(),
    this.nextAttemptAt = const Value.absent(),
    this.lastError = const Value.absent(),
    this.lastErrorCode = const Value.absent(),
    this.serverResult = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  OutboxTransactionsCompanion.insert({
    this.id = const Value.absent(),
    required String clientTxnId,
    required int deviceSeq,
    required String txnType,
    required String payload,
    required DateTime scannedAt,
    this.userCode = const Value.absent(),
    this.status = const Value.absent(),
    this.attempts = const Value.absent(),
    this.nextAttemptAt = const Value.absent(),
    this.lastError = const Value.absent(),
    this.lastErrorCode = const Value.absent(),
    this.serverResult = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : clientTxnId = Value(clientTxnId),
        deviceSeq = Value(deviceSeq),
        txnType = Value(txnType),
        payload = Value(payload),
        scannedAt = Value(scannedAt);
  static Insertable<OutboxTransaction> custom({
    Expression<int>? id,
    Expression<String>? clientTxnId,
    Expression<int>? deviceSeq,
    Expression<String>? txnType,
    Expression<String>? payload,
    Expression<DateTime>? scannedAt,
    Expression<String>? userCode,
    Expression<String>? status,
    Expression<int>? attempts,
    Expression<DateTime>? nextAttemptAt,
    Expression<String>? lastError,
    Expression<String>? lastErrorCode,
    Expression<String>? serverResult,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientTxnId != null) 'client_txn_id': clientTxnId,
      if (deviceSeq != null) 'device_seq': deviceSeq,
      if (txnType != null) 'txn_type': txnType,
      if (payload != null) 'payload': payload,
      if (scannedAt != null) 'scanned_at': scannedAt,
      if (userCode != null) 'user_code': userCode,
      if (status != null) 'status': status,
      if (attempts != null) 'attempts': attempts,
      if (nextAttemptAt != null) 'next_attempt_at': nextAttemptAt,
      if (lastError != null) 'last_error': lastError,
      if (lastErrorCode != null) 'last_error_code': lastErrorCode,
      if (serverResult != null) 'server_result': serverResult,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  OutboxTransactionsCompanion copyWith(
      {Value<int>? id,
      Value<String>? clientTxnId,
      Value<int>? deviceSeq,
      Value<String>? txnType,
      Value<String>? payload,
      Value<DateTime>? scannedAt,
      Value<String?>? userCode,
      Value<OutboxStatus>? status,
      Value<int>? attempts,
      Value<DateTime?>? nextAttemptAt,
      Value<String?>? lastError,
      Value<String?>? lastErrorCode,
      Value<String?>? serverResult,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return OutboxTransactionsCompanion(
      id: id ?? this.id,
      clientTxnId: clientTxnId ?? this.clientTxnId,
      deviceSeq: deviceSeq ?? this.deviceSeq,
      txnType: txnType ?? this.txnType,
      payload: payload ?? this.payload,
      scannedAt: scannedAt ?? this.scannedAt,
      userCode: userCode ?? this.userCode,
      status: status ?? this.status,
      attempts: attempts ?? this.attempts,
      nextAttemptAt: nextAttemptAt ?? this.nextAttemptAt,
      lastError: lastError ?? this.lastError,
      lastErrorCode: lastErrorCode ?? this.lastErrorCode,
      serverResult: serverResult ?? this.serverResult,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientTxnId.present) {
      map['client_txn_id'] = Variable<String>(clientTxnId.value);
    }
    if (deviceSeq.present) {
      map['device_seq'] = Variable<int>(deviceSeq.value);
    }
    if (txnType.present) {
      map['txn_type'] = Variable<String>(txnType.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (scannedAt.present) {
      map['scanned_at'] = Variable<DateTime>(scannedAt.value);
    }
    if (userCode.present) {
      map['user_code'] = Variable<String>(userCode.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
          $OutboxTransactionsTable.$converterstatus.toSql(status.value));
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (nextAttemptAt.present) {
      map['next_attempt_at'] = Variable<DateTime>(nextAttemptAt.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (lastErrorCode.present) {
      map['last_error_code'] = Variable<String>(lastErrorCode.value);
    }
    if (serverResult.present) {
      map['server_result'] = Variable<String>(serverResult.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OutboxTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('clientTxnId: $clientTxnId, ')
          ..write('deviceSeq: $deviceSeq, ')
          ..write('txnType: $txnType, ')
          ..write('payload: $payload, ')
          ..write('scannedAt: $scannedAt, ')
          ..write('userCode: $userCode, ')
          ..write('status: $status, ')
          ..write('attempts: $attempts, ')
          ..write('nextAttemptAt: $nextAttemptAt, ')
          ..write('lastError: $lastError, ')
          ..write('lastErrorCode: $lastErrorCode, ')
          ..write('serverResult: $serverResult, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CachedItemsTable extends CachedItems
    with TableInfo<$CachedItemsTable, CachedItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _itemCodeMeta =
      const VerificationMeta('itemCode');
  @override
  late final GeneratedColumn<String> itemCode = GeneratedColumn<String>(
      'item_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _stdPalletQtyMeta =
      const VerificationMeta('stdPalletQty');
  @override
  late final GeneratedColumn<int> stdPalletQty = GeneratedColumn<int>(
      'std_pallet_qty', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(96));
  static const VerificationMeta _wheelsPerLayerMeta =
      const VerificationMeta('wheelsPerLayer');
  @override
  late final GeneratedColumn<int> wheelsPerLayer = GeneratedColumn<int>(
      'wheels_per_layer', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _stdBoxQtyMeta =
      const VerificationMeta('stdBoxQty');
  @override
  late final GeneratedColumn<int> stdBoxQty = GeneratedColumn<int>(
      'std_box_qty', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _channelMeta =
      const VerificationMeta('channel');
  @override
  late final GeneratedColumn<String> channel = GeneratedColumn<String>(
      'channel', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [itemCode, description, stdPalletQty, wheelsPerLayer, stdBoxQty, channel];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_items';
  @override
  VerificationContext validateIntegrity(Insertable<CachedItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item_code')) {
      context.handle(_itemCodeMeta,
          itemCode.isAcceptableOrUnknown(data['item_code']!, _itemCodeMeta));
    } else if (isInserting) {
      context.missing(_itemCodeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('std_pallet_qty')) {
      context.handle(
          _stdPalletQtyMeta,
          stdPalletQty.isAcceptableOrUnknown(
              data['std_pallet_qty']!, _stdPalletQtyMeta));
    }
    if (data.containsKey('wheels_per_layer')) {
      context.handle(
          _wheelsPerLayerMeta,
          wheelsPerLayer.isAcceptableOrUnknown(
              data['wheels_per_layer']!, _wheelsPerLayerMeta));
    }
    if (data.containsKey('std_box_qty')) {
      context.handle(
          _stdBoxQtyMeta,
          stdBoxQty.isAcceptableOrUnknown(
              data['std_box_qty']!, _stdBoxQtyMeta));
    }
    if (data.containsKey('channel')) {
      context.handle(_channelMeta,
          channel.isAcceptableOrUnknown(data['channel']!, _channelMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {itemCode};
  @override
  CachedItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedItem(
      itemCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_code'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      stdPalletQty: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}std_pallet_qty'])!,
      wheelsPerLayer: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}wheels_per_layer']),
      stdBoxQty: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}std_box_qty']),
      channel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}channel']),
    );
  }

  @override
  $CachedItemsTable createAlias(String alias) {
    return $CachedItemsTable(attachedDatabase, alias);
  }
}

class CachedItem extends DataClass implements Insertable<CachedItem> {
  final String itemCode;
  final String? description;
  final int stdPalletQty;
  final int? wheelsPerLayer;
  final int? stdBoxQty;
  final String? channel;
  const CachedItem(
      {required this.itemCode,
      this.description,
      required this.stdPalletQty,
      this.wheelsPerLayer,
      this.stdBoxQty,
      this.channel});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['item_code'] = Variable<String>(itemCode);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['std_pallet_qty'] = Variable<int>(stdPalletQty);
    if (!nullToAbsent || wheelsPerLayer != null) {
      map['wheels_per_layer'] = Variable<int>(wheelsPerLayer);
    }
    if (!nullToAbsent || stdBoxQty != null) {
      map['std_box_qty'] = Variable<int>(stdBoxQty);
    }
    if (!nullToAbsent || channel != null) {
      map['channel'] = Variable<String>(channel);
    }
    return map;
  }

  CachedItemsCompanion toCompanion(bool nullToAbsent) {
    return CachedItemsCompanion(
      itemCode: Value(itemCode),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      stdPalletQty: Value(stdPalletQty),
      wheelsPerLayer: wheelsPerLayer == null && nullToAbsent
          ? const Value.absent()
          : Value(wheelsPerLayer),
      stdBoxQty: stdBoxQty == null && nullToAbsent
          ? const Value.absent()
          : Value(stdBoxQty),
      channel: channel == null && nullToAbsent
          ? const Value.absent()
          : Value(channel),
    );
  }

  factory CachedItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedItem(
      itemCode: serializer.fromJson<String>(json['itemCode']),
      description: serializer.fromJson<String?>(json['description']),
      stdPalletQty: serializer.fromJson<int>(json['stdPalletQty']),
      wheelsPerLayer: serializer.fromJson<int?>(json['wheelsPerLayer']),
      stdBoxQty: serializer.fromJson<int?>(json['stdBoxQty']),
      channel: serializer.fromJson<String?>(json['channel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'itemCode': serializer.toJson<String>(itemCode),
      'description': serializer.toJson<String?>(description),
      'stdPalletQty': serializer.toJson<int>(stdPalletQty),
      'wheelsPerLayer': serializer.toJson<int?>(wheelsPerLayer),
      'stdBoxQty': serializer.toJson<int?>(stdBoxQty),
      'channel': serializer.toJson<String?>(channel),
    };
  }

  CachedItem copyWith(
          {String? itemCode,
          Value<String?> description = const Value.absent(),
          int? stdPalletQty,
          Value<int?> wheelsPerLayer = const Value.absent(),
          Value<int?> stdBoxQty = const Value.absent(),
          Value<String?> channel = const Value.absent()}) =>
      CachedItem(
        itemCode: itemCode ?? this.itemCode,
        description: description.present ? description.value : this.description,
        stdPalletQty: stdPalletQty ?? this.stdPalletQty,
        wheelsPerLayer:
            wheelsPerLayer.present ? wheelsPerLayer.value : this.wheelsPerLayer,
        stdBoxQty: stdBoxQty.present ? stdBoxQty.value : this.stdBoxQty,
        channel: channel.present ? channel.value : this.channel,
      );
  CachedItem copyWithCompanion(CachedItemsCompanion data) {
    return CachedItem(
      itemCode: data.itemCode.present ? data.itemCode.value : this.itemCode,
      description:
          data.description.present ? data.description.value : this.description,
      stdPalletQty: data.stdPalletQty.present
          ? data.stdPalletQty.value
          : this.stdPalletQty,
      wheelsPerLayer: data.wheelsPerLayer.present
          ? data.wheelsPerLayer.value
          : this.wheelsPerLayer,
      stdBoxQty: data.stdBoxQty.present ? data.stdBoxQty.value : this.stdBoxQty,
      channel: data.channel.present ? data.channel.value : this.channel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedItem(')
          ..write('itemCode: $itemCode, ')
          ..write('description: $description, ')
          ..write('stdPalletQty: $stdPalletQty, ')
          ..write('wheelsPerLayer: $wheelsPerLayer, ')
          ..write('stdBoxQty: $stdBoxQty, ')
          ..write('channel: $channel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      itemCode, description, stdPalletQty, wheelsPerLayer, stdBoxQty, channel);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedItem &&
          other.itemCode == this.itemCode &&
          other.description == this.description &&
          other.stdPalletQty == this.stdPalletQty &&
          other.wheelsPerLayer == this.wheelsPerLayer &&
          other.stdBoxQty == this.stdBoxQty &&
          other.channel == this.channel);
}

class CachedItemsCompanion extends UpdateCompanion<CachedItem> {
  final Value<String> itemCode;
  final Value<String?> description;
  final Value<int> stdPalletQty;
  final Value<int?> wheelsPerLayer;
  final Value<int?> stdBoxQty;
  final Value<String?> channel;
  final Value<int> rowid;
  const CachedItemsCompanion({
    this.itemCode = const Value.absent(),
    this.description = const Value.absent(),
    this.stdPalletQty = const Value.absent(),
    this.wheelsPerLayer = const Value.absent(),
    this.stdBoxQty = const Value.absent(),
    this.channel = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedItemsCompanion.insert({
    required String itemCode,
    this.description = const Value.absent(),
    this.stdPalletQty = const Value.absent(),
    this.wheelsPerLayer = const Value.absent(),
    this.stdBoxQty = const Value.absent(),
    this.channel = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : itemCode = Value(itemCode);
  static Insertable<CachedItem> custom({
    Expression<String>? itemCode,
    Expression<String>? description,
    Expression<int>? stdPalletQty,
    Expression<int>? wheelsPerLayer,
    Expression<int>? stdBoxQty,
    Expression<String>? channel,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (itemCode != null) 'item_code': itemCode,
      if (description != null) 'description': description,
      if (stdPalletQty != null) 'std_pallet_qty': stdPalletQty,
      if (wheelsPerLayer != null) 'wheels_per_layer': wheelsPerLayer,
      if (stdBoxQty != null) 'std_box_qty': stdBoxQty,
      if (channel != null) 'channel': channel,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedItemsCompanion copyWith(
      {Value<String>? itemCode,
      Value<String?>? description,
      Value<int>? stdPalletQty,
      Value<int?>? wheelsPerLayer,
      Value<int?>? stdBoxQty,
      Value<String?>? channel,
      Value<int>? rowid}) {
    return CachedItemsCompanion(
      itemCode: itemCode ?? this.itemCode,
      description: description ?? this.description,
      stdPalletQty: stdPalletQty ?? this.stdPalletQty,
      wheelsPerLayer: wheelsPerLayer ?? this.wheelsPerLayer,
      stdBoxQty: stdBoxQty ?? this.stdBoxQty,
      channel: channel ?? this.channel,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (itemCode.present) {
      map['item_code'] = Variable<String>(itemCode.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (stdPalletQty.present) {
      map['std_pallet_qty'] = Variable<int>(stdPalletQty.value);
    }
    if (wheelsPerLayer.present) {
      map['wheels_per_layer'] = Variable<int>(wheelsPerLayer.value);
    }
    if (stdBoxQty.present) {
      map['std_box_qty'] = Variable<int>(stdBoxQty.value);
    }
    if (channel.present) {
      map['channel'] = Variable<String>(channel.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedItemsCompanion(')
          ..write('itemCode: $itemCode, ')
          ..write('description: $description, ')
          ..write('stdPalletQty: $stdPalletQty, ')
          ..write('wheelsPerLayer: $wheelsPerLayer, ')
          ..write('stdBoxQty: $stdBoxQty, ')
          ..write('channel: $channel, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedLocationsTable extends CachedLocations
    with TableInfo<$CachedLocationsTable, CachedLocation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedLocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _locationCodeMeta =
      const VerificationMeta('locationCode');
  @override
  late final GeneratedColumn<String> locationCode = GeneratedColumn<String>(
      'location_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _zoneMeta = const VerificationMeta('zone');
  @override
  late final GeneratedColumn<String> zone = GeneratedColumn<String>(
      'zone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _locationTypeMeta =
      const VerificationMeta('locationType');
  @override
  late final GeneratedColumn<String> locationType = GeneratedColumn<String>(
      'location_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _capacityMeta =
      const VerificationMeta('capacity');
  @override
  late final GeneratedColumn<int> capacity = GeneratedColumn<int>(
      'capacity', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [locationCode, zone, locationType, capacity];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_locations';
  @override
  VerificationContext validateIntegrity(Insertable<CachedLocation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('location_code')) {
      context.handle(
          _locationCodeMeta,
          locationCode.isAcceptableOrUnknown(
              data['location_code']!, _locationCodeMeta));
    } else if (isInserting) {
      context.missing(_locationCodeMeta);
    }
    if (data.containsKey('zone')) {
      context.handle(
          _zoneMeta, zone.isAcceptableOrUnknown(data['zone']!, _zoneMeta));
    }
    if (data.containsKey('location_type')) {
      context.handle(
          _locationTypeMeta,
          locationType.isAcceptableOrUnknown(
              data['location_type']!, _locationTypeMeta));
    }
    if (data.containsKey('capacity')) {
      context.handle(_capacityMeta,
          capacity.isAcceptableOrUnknown(data['capacity']!, _capacityMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {locationCode};
  @override
  CachedLocation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedLocation(
      locationCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location_code'])!,
      zone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}zone']),
      locationType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location_type']),
      capacity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}capacity']),
    );
  }

  @override
  $CachedLocationsTable createAlias(String alias) {
    return $CachedLocationsTable(attachedDatabase, alias);
  }
}

class CachedLocation extends DataClass implements Insertable<CachedLocation> {
  final String locationCode;
  final String? zone;
  final String? locationType;
  final int? capacity;
  const CachedLocation(
      {required this.locationCode,
      this.zone,
      this.locationType,
      this.capacity});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['location_code'] = Variable<String>(locationCode);
    if (!nullToAbsent || zone != null) {
      map['zone'] = Variable<String>(zone);
    }
    if (!nullToAbsent || locationType != null) {
      map['location_type'] = Variable<String>(locationType);
    }
    if (!nullToAbsent || capacity != null) {
      map['capacity'] = Variable<int>(capacity);
    }
    return map;
  }

  CachedLocationsCompanion toCompanion(bool nullToAbsent) {
    return CachedLocationsCompanion(
      locationCode: Value(locationCode),
      zone: zone == null && nullToAbsent ? const Value.absent() : Value(zone),
      locationType: locationType == null && nullToAbsent
          ? const Value.absent()
          : Value(locationType),
      capacity: capacity == null && nullToAbsent
          ? const Value.absent()
          : Value(capacity),
    );
  }

  factory CachedLocation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedLocation(
      locationCode: serializer.fromJson<String>(json['locationCode']),
      zone: serializer.fromJson<String?>(json['zone']),
      locationType: serializer.fromJson<String?>(json['locationType']),
      capacity: serializer.fromJson<int?>(json['capacity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'locationCode': serializer.toJson<String>(locationCode),
      'zone': serializer.toJson<String?>(zone),
      'locationType': serializer.toJson<String?>(locationType),
      'capacity': serializer.toJson<int?>(capacity),
    };
  }

  CachedLocation copyWith(
          {String? locationCode,
          Value<String?> zone = const Value.absent(),
          Value<String?> locationType = const Value.absent(),
          Value<int?> capacity = const Value.absent()}) =>
      CachedLocation(
        locationCode: locationCode ?? this.locationCode,
        zone: zone.present ? zone.value : this.zone,
        locationType:
            locationType.present ? locationType.value : this.locationType,
        capacity: capacity.present ? capacity.value : this.capacity,
      );
  CachedLocation copyWithCompanion(CachedLocationsCompanion data) {
    return CachedLocation(
      locationCode: data.locationCode.present
          ? data.locationCode.value
          : this.locationCode,
      zone: data.zone.present ? data.zone.value : this.zone,
      locationType: data.locationType.present
          ? data.locationType.value
          : this.locationType,
      capacity: data.capacity.present ? data.capacity.value : this.capacity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedLocation(')
          ..write('locationCode: $locationCode, ')
          ..write('zone: $zone, ')
          ..write('locationType: $locationType, ')
          ..write('capacity: $capacity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(locationCode, zone, locationType, capacity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedLocation &&
          other.locationCode == this.locationCode &&
          other.zone == this.zone &&
          other.locationType == this.locationType &&
          other.capacity == this.capacity);
}

class CachedLocationsCompanion extends UpdateCompanion<CachedLocation> {
  final Value<String> locationCode;
  final Value<String?> zone;
  final Value<String?> locationType;
  final Value<int?> capacity;
  final Value<int> rowid;
  const CachedLocationsCompanion({
    this.locationCode = const Value.absent(),
    this.zone = const Value.absent(),
    this.locationType = const Value.absent(),
    this.capacity = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedLocationsCompanion.insert({
    required String locationCode,
    this.zone = const Value.absent(),
    this.locationType = const Value.absent(),
    this.capacity = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : locationCode = Value(locationCode);
  static Insertable<CachedLocation> custom({
    Expression<String>? locationCode,
    Expression<String>? zone,
    Expression<String>? locationType,
    Expression<int>? capacity,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (locationCode != null) 'location_code': locationCode,
      if (zone != null) 'zone': zone,
      if (locationType != null) 'location_type': locationType,
      if (capacity != null) 'capacity': capacity,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedLocationsCompanion copyWith(
      {Value<String>? locationCode,
      Value<String?>? zone,
      Value<String?>? locationType,
      Value<int?>? capacity,
      Value<int>? rowid}) {
    return CachedLocationsCompanion(
      locationCode: locationCode ?? this.locationCode,
      zone: zone ?? this.zone,
      locationType: locationType ?? this.locationType,
      capacity: capacity ?? this.capacity,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (locationCode.present) {
      map['location_code'] = Variable<String>(locationCode.value);
    }
    if (zone.present) {
      map['zone'] = Variable<String>(zone.value);
    }
    if (locationType.present) {
      map['location_type'] = Variable<String>(locationType.value);
    }
    if (capacity.present) {
      map['capacity'] = Variable<int>(capacity.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedLocationsCompanion(')
          ..write('locationCode: $locationCode, ')
          ..write('zone: $zone, ')
          ..write('locationType: $locationType, ')
          ..write('capacity: $capacity, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedPalletsTable extends CachedPallets
    with TableInfo<$CachedPalletsTable, CachedPallet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedPalletsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _palletNumberMeta =
      const VerificationMeta('palletNumber');
  @override
  late final GeneratedColumn<String> palletNumber = GeneratedColumn<String>(
      'pallet_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _itemCodeMeta =
      const VerificationMeta('itemCode');
  @override
  late final GeneratedColumn<String> itemCode = GeneratedColumn<String>(
      'item_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _typeSeriesMeta =
      const VerificationMeta('typeSeries');
  @override
  late final GeneratedColumn<String> typeSeries = GeneratedColumn<String>(
      'type_series', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _packedQtyMeta =
      const VerificationMeta('packedQty');
  @override
  late final GeneratedColumn<int> packedQty = GeneratedColumn<int>(
      'packed_qty', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _locationCodeMeta =
      const VerificationMeta('locationCode');
  @override
  late final GeneratedColumn<String> locationCode = GeneratedColumn<String>(
      'location_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isHoldMeta = const VerificationMeta('isHold');
  @override
  late final GeneratedColumn<bool> isHold = GeneratedColumn<bool>(
      'is_hold', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_hold" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _syncedAtMeta =
      const VerificationMeta('syncedAt');
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
      'synced_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        palletNumber,
        itemCode,
        typeSeries,
        status,
        packedQty,
        locationCode,
        isHold,
        syncedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_pallets';
  @override
  VerificationContext validateIntegrity(Insertable<CachedPallet> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pallet_number')) {
      context.handle(
          _palletNumberMeta,
          palletNumber.isAcceptableOrUnknown(
              data['pallet_number']!, _palletNumberMeta));
    } else if (isInserting) {
      context.missing(_palletNumberMeta);
    }
    if (data.containsKey('item_code')) {
      context.handle(_itemCodeMeta,
          itemCode.isAcceptableOrUnknown(data['item_code']!, _itemCodeMeta));
    }
    if (data.containsKey('type_series')) {
      context.handle(
          _typeSeriesMeta,
          typeSeries.isAcceptableOrUnknown(
              data['type_series']!, _typeSeriesMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('packed_qty')) {
      context.handle(_packedQtyMeta,
          packedQty.isAcceptableOrUnknown(data['packed_qty']!, _packedQtyMeta));
    }
    if (data.containsKey('location_code')) {
      context.handle(
          _locationCodeMeta,
          locationCode.isAcceptableOrUnknown(
              data['location_code']!, _locationCodeMeta));
    }
    if (data.containsKey('is_hold')) {
      context.handle(_isHoldMeta,
          isHold.isAcceptableOrUnknown(data['is_hold']!, _isHoldMeta));
    }
    if (data.containsKey('synced_at')) {
      context.handle(_syncedAtMeta,
          syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {palletNumber};
  @override
  CachedPallet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedPallet(
      palletNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pallet_number'])!,
      itemCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_code']),
      typeSeries: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type_series']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status']),
      packedQty: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}packed_qty'])!,
      locationCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location_code']),
      isHold: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_hold'])!,
      syncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}synced_at'])!,
    );
  }

  @override
  $CachedPalletsTable createAlias(String alias) {
    return $CachedPalletsTable(attachedDatabase, alias);
  }
}

class CachedPallet extends DataClass implements Insertable<CachedPallet> {
  final String palletNumber;
  final String? itemCode;
  final String? typeSeries;
  final String? status;
  final int packedQty;
  final String? locationCode;
  final bool isHold;
  final DateTime syncedAt;
  const CachedPallet(
      {required this.palletNumber,
      this.itemCode,
      this.typeSeries,
      this.status,
      required this.packedQty,
      this.locationCode,
      required this.isHold,
      required this.syncedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pallet_number'] = Variable<String>(palletNumber);
    if (!nullToAbsent || itemCode != null) {
      map['item_code'] = Variable<String>(itemCode);
    }
    if (!nullToAbsent || typeSeries != null) {
      map['type_series'] = Variable<String>(typeSeries);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    map['packed_qty'] = Variable<int>(packedQty);
    if (!nullToAbsent || locationCode != null) {
      map['location_code'] = Variable<String>(locationCode);
    }
    map['is_hold'] = Variable<bool>(isHold);
    map['synced_at'] = Variable<DateTime>(syncedAt);
    return map;
  }

  CachedPalletsCompanion toCompanion(bool nullToAbsent) {
    return CachedPalletsCompanion(
      palletNumber: Value(palletNumber),
      itemCode: itemCode == null && nullToAbsent
          ? const Value.absent()
          : Value(itemCode),
      typeSeries: typeSeries == null && nullToAbsent
          ? const Value.absent()
          : Value(typeSeries),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      packedQty: Value(packedQty),
      locationCode: locationCode == null && nullToAbsent
          ? const Value.absent()
          : Value(locationCode),
      isHold: Value(isHold),
      syncedAt: Value(syncedAt),
    );
  }

  factory CachedPallet.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedPallet(
      palletNumber: serializer.fromJson<String>(json['palletNumber']),
      itemCode: serializer.fromJson<String?>(json['itemCode']),
      typeSeries: serializer.fromJson<String?>(json['typeSeries']),
      status: serializer.fromJson<String?>(json['status']),
      packedQty: serializer.fromJson<int>(json['packedQty']),
      locationCode: serializer.fromJson<String?>(json['locationCode']),
      isHold: serializer.fromJson<bool>(json['isHold']),
      syncedAt: serializer.fromJson<DateTime>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'palletNumber': serializer.toJson<String>(palletNumber),
      'itemCode': serializer.toJson<String?>(itemCode),
      'typeSeries': serializer.toJson<String?>(typeSeries),
      'status': serializer.toJson<String?>(status),
      'packedQty': serializer.toJson<int>(packedQty),
      'locationCode': serializer.toJson<String?>(locationCode),
      'isHold': serializer.toJson<bool>(isHold),
      'syncedAt': serializer.toJson<DateTime>(syncedAt),
    };
  }

  CachedPallet copyWith(
          {String? palletNumber,
          Value<String?> itemCode = const Value.absent(),
          Value<String?> typeSeries = const Value.absent(),
          Value<String?> status = const Value.absent(),
          int? packedQty,
          Value<String?> locationCode = const Value.absent(),
          bool? isHold,
          DateTime? syncedAt}) =>
      CachedPallet(
        palletNumber: palletNumber ?? this.palletNumber,
        itemCode: itemCode.present ? itemCode.value : this.itemCode,
        typeSeries: typeSeries.present ? typeSeries.value : this.typeSeries,
        status: status.present ? status.value : this.status,
        packedQty: packedQty ?? this.packedQty,
        locationCode:
            locationCode.present ? locationCode.value : this.locationCode,
        isHold: isHold ?? this.isHold,
        syncedAt: syncedAt ?? this.syncedAt,
      );
  CachedPallet copyWithCompanion(CachedPalletsCompanion data) {
    return CachedPallet(
      palletNumber: data.palletNumber.present
          ? data.palletNumber.value
          : this.palletNumber,
      itemCode: data.itemCode.present ? data.itemCode.value : this.itemCode,
      typeSeries:
          data.typeSeries.present ? data.typeSeries.value : this.typeSeries,
      status: data.status.present ? data.status.value : this.status,
      packedQty: data.packedQty.present ? data.packedQty.value : this.packedQty,
      locationCode: data.locationCode.present
          ? data.locationCode.value
          : this.locationCode,
      isHold: data.isHold.present ? data.isHold.value : this.isHold,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedPallet(')
          ..write('palletNumber: $palletNumber, ')
          ..write('itemCode: $itemCode, ')
          ..write('typeSeries: $typeSeries, ')
          ..write('status: $status, ')
          ..write('packedQty: $packedQty, ')
          ..write('locationCode: $locationCode, ')
          ..write('isHold: $isHold, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(palletNumber, itemCode, typeSeries, status,
      packedQty, locationCode, isHold, syncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedPallet &&
          other.palletNumber == this.palletNumber &&
          other.itemCode == this.itemCode &&
          other.typeSeries == this.typeSeries &&
          other.status == this.status &&
          other.packedQty == this.packedQty &&
          other.locationCode == this.locationCode &&
          other.isHold == this.isHold &&
          other.syncedAt == this.syncedAt);
}

class CachedPalletsCompanion extends UpdateCompanion<CachedPallet> {
  final Value<String> palletNumber;
  final Value<String?> itemCode;
  final Value<String?> typeSeries;
  final Value<String?> status;
  final Value<int> packedQty;
  final Value<String?> locationCode;
  final Value<bool> isHold;
  final Value<DateTime> syncedAt;
  final Value<int> rowid;
  const CachedPalletsCompanion({
    this.palletNumber = const Value.absent(),
    this.itemCode = const Value.absent(),
    this.typeSeries = const Value.absent(),
    this.status = const Value.absent(),
    this.packedQty = const Value.absent(),
    this.locationCode = const Value.absent(),
    this.isHold = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedPalletsCompanion.insert({
    required String palletNumber,
    this.itemCode = const Value.absent(),
    this.typeSeries = const Value.absent(),
    this.status = const Value.absent(),
    this.packedQty = const Value.absent(),
    this.locationCode = const Value.absent(),
    this.isHold = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : palletNumber = Value(palletNumber);
  static Insertable<CachedPallet> custom({
    Expression<String>? palletNumber,
    Expression<String>? itemCode,
    Expression<String>? typeSeries,
    Expression<String>? status,
    Expression<int>? packedQty,
    Expression<String>? locationCode,
    Expression<bool>? isHold,
    Expression<DateTime>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (palletNumber != null) 'pallet_number': palletNumber,
      if (itemCode != null) 'item_code': itemCode,
      if (typeSeries != null) 'type_series': typeSeries,
      if (status != null) 'status': status,
      if (packedQty != null) 'packed_qty': packedQty,
      if (locationCode != null) 'location_code': locationCode,
      if (isHold != null) 'is_hold': isHold,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedPalletsCompanion copyWith(
      {Value<String>? palletNumber,
      Value<String?>? itemCode,
      Value<String?>? typeSeries,
      Value<String?>? status,
      Value<int>? packedQty,
      Value<String?>? locationCode,
      Value<bool>? isHold,
      Value<DateTime>? syncedAt,
      Value<int>? rowid}) {
    return CachedPalletsCompanion(
      palletNumber: palletNumber ?? this.palletNumber,
      itemCode: itemCode ?? this.itemCode,
      typeSeries: typeSeries ?? this.typeSeries,
      status: status ?? this.status,
      packedQty: packedQty ?? this.packedQty,
      locationCode: locationCode ?? this.locationCode,
      isHold: isHold ?? this.isHold,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (palletNumber.present) {
      map['pallet_number'] = Variable<String>(palletNumber.value);
    }
    if (itemCode.present) {
      map['item_code'] = Variable<String>(itemCode.value);
    }
    if (typeSeries.present) {
      map['type_series'] = Variable<String>(typeSeries.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (packedQty.present) {
      map['packed_qty'] = Variable<int>(packedQty.value);
    }
    if (locationCode.present) {
      map['location_code'] = Variable<String>(locationCode.value);
    }
    if (isHold.present) {
      map['is_hold'] = Variable<bool>(isHold.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedPalletsCompanion(')
          ..write('palletNumber: $palletNumber, ')
          ..write('itemCode: $itemCode, ')
          ..write('typeSeries: $typeSeries, ')
          ..write('status: $status, ')
          ..write('packedQty: $packedQty, ')
          ..write('locationCode: $locationCode, ')
          ..write('isHold: $isHold, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NumberBlocksTable extends NumberBlocks
    with TableInfo<$NumberBlocksTable, NumberBlock> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NumberBlocksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _prefixMeta = const VerificationMeta('prefix');
  @override
  late final GeneratedColumn<String> prefix = GeneratedColumn<String>(
      'prefix', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _blockStartMeta =
      const VerificationMeta('blockStart');
  @override
  late final GeneratedColumn<int> blockStart = GeneratedColumn<int>(
      'block_start', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _blockEndMeta =
      const VerificationMeta('blockEnd');
  @override
  late final GeneratedColumn<int> blockEnd = GeneratedColumn<int>(
      'block_end', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nextValueMeta =
      const VerificationMeta('nextValue');
  @override
  late final GeneratedColumn<int> nextValue = GeneratedColumn<int>(
      'next_value', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _issuedAtMeta =
      const VerificationMeta('issuedAt');
  @override
  late final GeneratedColumn<DateTime> issuedAt = GeneratedColumn<DateTime>(
      'issued_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _exhaustedMeta =
      const VerificationMeta('exhausted');
  @override
  late final GeneratedColumn<bool> exhausted = GeneratedColumn<bool>(
      'exhausted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("exhausted" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, prefix, blockStart, blockEnd, nextValue, issuedAt, exhausted];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'number_blocks';
  @override
  VerificationContext validateIntegrity(Insertable<NumberBlock> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('prefix')) {
      context.handle(_prefixMeta,
          prefix.isAcceptableOrUnknown(data['prefix']!, _prefixMeta));
    } else if (isInserting) {
      context.missing(_prefixMeta);
    }
    if (data.containsKey('block_start')) {
      context.handle(
          _blockStartMeta,
          blockStart.isAcceptableOrUnknown(
              data['block_start']!, _blockStartMeta));
    } else if (isInserting) {
      context.missing(_blockStartMeta);
    }
    if (data.containsKey('block_end')) {
      context.handle(_blockEndMeta,
          blockEnd.isAcceptableOrUnknown(data['block_end']!, _blockEndMeta));
    } else if (isInserting) {
      context.missing(_blockEndMeta);
    }
    if (data.containsKey('next_value')) {
      context.handle(_nextValueMeta,
          nextValue.isAcceptableOrUnknown(data['next_value']!, _nextValueMeta));
    } else if (isInserting) {
      context.missing(_nextValueMeta);
    }
    if (data.containsKey('issued_at')) {
      context.handle(_issuedAtMeta,
          issuedAt.isAcceptableOrUnknown(data['issued_at']!, _issuedAtMeta));
    }
    if (data.containsKey('exhausted')) {
      context.handle(_exhaustedMeta,
          exhausted.isAcceptableOrUnknown(data['exhausted']!, _exhaustedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NumberBlock map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NumberBlock(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      prefix: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}prefix'])!,
      blockStart: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}block_start'])!,
      blockEnd: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}block_end'])!,
      nextValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}next_value'])!,
      issuedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}issued_at'])!,
      exhausted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}exhausted'])!,
    );
  }

  @override
  $NumberBlocksTable createAlias(String alias) {
    return $NumberBlocksTable(attachedDatabase, alias);
  }
}

class NumberBlock extends DataClass implements Insertable<NumberBlock> {
  final int id;
  final String prefix;
  final int blockStart;
  final int blockEnd;
  final int nextValue;
  final DateTime issuedAt;
  final bool exhausted;
  const NumberBlock(
      {required this.id,
      required this.prefix,
      required this.blockStart,
      required this.blockEnd,
      required this.nextValue,
      required this.issuedAt,
      required this.exhausted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['prefix'] = Variable<String>(prefix);
    map['block_start'] = Variable<int>(blockStart);
    map['block_end'] = Variable<int>(blockEnd);
    map['next_value'] = Variable<int>(nextValue);
    map['issued_at'] = Variable<DateTime>(issuedAt);
    map['exhausted'] = Variable<bool>(exhausted);
    return map;
  }

  NumberBlocksCompanion toCompanion(bool nullToAbsent) {
    return NumberBlocksCompanion(
      id: Value(id),
      prefix: Value(prefix),
      blockStart: Value(blockStart),
      blockEnd: Value(blockEnd),
      nextValue: Value(nextValue),
      issuedAt: Value(issuedAt),
      exhausted: Value(exhausted),
    );
  }

  factory NumberBlock.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NumberBlock(
      id: serializer.fromJson<int>(json['id']),
      prefix: serializer.fromJson<String>(json['prefix']),
      blockStart: serializer.fromJson<int>(json['blockStart']),
      blockEnd: serializer.fromJson<int>(json['blockEnd']),
      nextValue: serializer.fromJson<int>(json['nextValue']),
      issuedAt: serializer.fromJson<DateTime>(json['issuedAt']),
      exhausted: serializer.fromJson<bool>(json['exhausted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'prefix': serializer.toJson<String>(prefix),
      'blockStart': serializer.toJson<int>(blockStart),
      'blockEnd': serializer.toJson<int>(blockEnd),
      'nextValue': serializer.toJson<int>(nextValue),
      'issuedAt': serializer.toJson<DateTime>(issuedAt),
      'exhausted': serializer.toJson<bool>(exhausted),
    };
  }

  NumberBlock copyWith(
          {int? id,
          String? prefix,
          int? blockStart,
          int? blockEnd,
          int? nextValue,
          DateTime? issuedAt,
          bool? exhausted}) =>
      NumberBlock(
        id: id ?? this.id,
        prefix: prefix ?? this.prefix,
        blockStart: blockStart ?? this.blockStart,
        blockEnd: blockEnd ?? this.blockEnd,
        nextValue: nextValue ?? this.nextValue,
        issuedAt: issuedAt ?? this.issuedAt,
        exhausted: exhausted ?? this.exhausted,
      );
  NumberBlock copyWithCompanion(NumberBlocksCompanion data) {
    return NumberBlock(
      id: data.id.present ? data.id.value : this.id,
      prefix: data.prefix.present ? data.prefix.value : this.prefix,
      blockStart:
          data.blockStart.present ? data.blockStart.value : this.blockStart,
      blockEnd: data.blockEnd.present ? data.blockEnd.value : this.blockEnd,
      nextValue: data.nextValue.present ? data.nextValue.value : this.nextValue,
      issuedAt: data.issuedAt.present ? data.issuedAt.value : this.issuedAt,
      exhausted: data.exhausted.present ? data.exhausted.value : this.exhausted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NumberBlock(')
          ..write('id: $id, ')
          ..write('prefix: $prefix, ')
          ..write('blockStart: $blockStart, ')
          ..write('blockEnd: $blockEnd, ')
          ..write('nextValue: $nextValue, ')
          ..write('issuedAt: $issuedAt, ')
          ..write('exhausted: $exhausted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, prefix, blockStart, blockEnd, nextValue, issuedAt, exhausted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NumberBlock &&
          other.id == this.id &&
          other.prefix == this.prefix &&
          other.blockStart == this.blockStart &&
          other.blockEnd == this.blockEnd &&
          other.nextValue == this.nextValue &&
          other.issuedAt == this.issuedAt &&
          other.exhausted == this.exhausted);
}

class NumberBlocksCompanion extends UpdateCompanion<NumberBlock> {
  final Value<int> id;
  final Value<String> prefix;
  final Value<int> blockStart;
  final Value<int> blockEnd;
  final Value<int> nextValue;
  final Value<DateTime> issuedAt;
  final Value<bool> exhausted;
  const NumberBlocksCompanion({
    this.id = const Value.absent(),
    this.prefix = const Value.absent(),
    this.blockStart = const Value.absent(),
    this.blockEnd = const Value.absent(),
    this.nextValue = const Value.absent(),
    this.issuedAt = const Value.absent(),
    this.exhausted = const Value.absent(),
  });
  NumberBlocksCompanion.insert({
    this.id = const Value.absent(),
    required String prefix,
    required int blockStart,
    required int blockEnd,
    required int nextValue,
    this.issuedAt = const Value.absent(),
    this.exhausted = const Value.absent(),
  })  : prefix = Value(prefix),
        blockStart = Value(blockStart),
        blockEnd = Value(blockEnd),
        nextValue = Value(nextValue);
  static Insertable<NumberBlock> custom({
    Expression<int>? id,
    Expression<String>? prefix,
    Expression<int>? blockStart,
    Expression<int>? blockEnd,
    Expression<int>? nextValue,
    Expression<DateTime>? issuedAt,
    Expression<bool>? exhausted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (prefix != null) 'prefix': prefix,
      if (blockStart != null) 'block_start': blockStart,
      if (blockEnd != null) 'block_end': blockEnd,
      if (nextValue != null) 'next_value': nextValue,
      if (issuedAt != null) 'issued_at': issuedAt,
      if (exhausted != null) 'exhausted': exhausted,
    });
  }

  NumberBlocksCompanion copyWith(
      {Value<int>? id,
      Value<String>? prefix,
      Value<int>? blockStart,
      Value<int>? blockEnd,
      Value<int>? nextValue,
      Value<DateTime>? issuedAt,
      Value<bool>? exhausted}) {
    return NumberBlocksCompanion(
      id: id ?? this.id,
      prefix: prefix ?? this.prefix,
      blockStart: blockStart ?? this.blockStart,
      blockEnd: blockEnd ?? this.blockEnd,
      nextValue: nextValue ?? this.nextValue,
      issuedAt: issuedAt ?? this.issuedAt,
      exhausted: exhausted ?? this.exhausted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (prefix.present) {
      map['prefix'] = Variable<String>(prefix.value);
    }
    if (blockStart.present) {
      map['block_start'] = Variable<int>(blockStart.value);
    }
    if (blockEnd.present) {
      map['block_end'] = Variable<int>(blockEnd.value);
    }
    if (nextValue.present) {
      map['next_value'] = Variable<int>(nextValue.value);
    }
    if (issuedAt.present) {
      map['issued_at'] = Variable<DateTime>(issuedAt.value);
    }
    if (exhausted.present) {
      map['exhausted'] = Variable<bool>(exhausted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NumberBlocksCompanion(')
          ..write('id: $id, ')
          ..write('prefix: $prefix, ')
          ..write('blockStart: $blockStart, ')
          ..write('blockEnd: $blockEnd, ')
          ..write('nextValue: $nextValue, ')
          ..write('issuedAt: $issuedAt, ')
          ..write('exhausted: $exhausted')
          ..write(')'))
        .toString();
  }
}

class $SyncMetaTable extends SyncMeta
    with TableInfo<$SyncMetaTable, SyncMetaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncMetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_meta';
  @override
  VerificationContext validateIntegrity(Insertable<SyncMetaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SyncMetaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetaData(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $SyncMetaTable createAlias(String alias) {
    return $SyncMetaTable(attachedDatabase, alias);
  }
}

class SyncMetaData extends DataClass implements Insertable<SyncMetaData> {
  final String key;
  final String value;
  const SyncMetaData({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  SyncMetaCompanion toCompanion(bool nullToAbsent) {
    return SyncMetaCompanion(
      key: Value(key),
      value: Value(value),
    );
  }

  factory SyncMetaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetaData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  SyncMetaData copyWith({String? key, String? value}) => SyncMetaData(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  SyncMetaData copyWithCompanion(SyncMetaCompanion data) {
    return SyncMetaData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetaData(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetaData &&
          other.key == this.key &&
          other.value == this.value);
}

class SyncMetaCompanion extends UpdateCompanion<SyncMetaData> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SyncMetaCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetaCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<SyncMetaData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetaCompanion copyWith(
      {Value<String>? key, Value<String>? value, Value<int>? rowid}) {
    return SyncMetaCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetaCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $OutboxTransactionsTable outboxTransactions =
      $OutboxTransactionsTable(this);
  late final $CachedItemsTable cachedItems = $CachedItemsTable(this);
  late final $CachedLocationsTable cachedLocations =
      $CachedLocationsTable(this);
  late final $CachedPalletsTable cachedPallets = $CachedPalletsTable(this);
  late final $NumberBlocksTable numberBlocks = $NumberBlocksTable(this);
  late final $SyncMetaTable syncMeta = $SyncMetaTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        outboxTransactions,
        cachedItems,
        cachedLocations,
        cachedPallets,
        numberBlocks,
        syncMeta
      ];
}

typedef $$OutboxTransactionsTableCreateCompanionBuilder
    = OutboxTransactionsCompanion Function({
  Value<int> id,
  required String clientTxnId,
  required int deviceSeq,
  required String txnType,
  required String payload,
  required DateTime scannedAt,
  Value<String?> userCode,
  Value<OutboxStatus> status,
  Value<int> attempts,
  Value<DateTime?> nextAttemptAt,
  Value<String?> lastError,
  Value<String?> lastErrorCode,
  Value<String?> serverResult,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$OutboxTransactionsTableUpdateCompanionBuilder
    = OutboxTransactionsCompanion Function({
  Value<int> id,
  Value<String> clientTxnId,
  Value<int> deviceSeq,
  Value<String> txnType,
  Value<String> payload,
  Value<DateTime> scannedAt,
  Value<String?> userCode,
  Value<OutboxStatus> status,
  Value<int> attempts,
  Value<DateTime?> nextAttemptAt,
  Value<String?> lastError,
  Value<String?> lastErrorCode,
  Value<String?> serverResult,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$OutboxTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $OutboxTransactionsTable> {
  $$OutboxTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get clientTxnId => $composableBuilder(
      column: $table.clientTxnId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deviceSeq => $composableBuilder(
      column: $table.deviceSeq, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get txnType => $composableBuilder(
      column: $table.txnType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get scannedAt => $composableBuilder(
      column: $table.scannedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userCode => $composableBuilder(
      column: $table.userCode, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<OutboxStatus, OutboxStatus, String>
      get status => $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get attempts => $composableBuilder(
      column: $table.attempts, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get nextAttemptAt => $composableBuilder(
      column: $table.nextAttemptAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastError => $composableBuilder(
      column: $table.lastError, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastErrorCode => $composableBuilder(
      column: $table.lastErrorCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get serverResult => $composableBuilder(
      column: $table.serverResult, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$OutboxTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $OutboxTransactionsTable> {
  $$OutboxTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get clientTxnId => $composableBuilder(
      column: $table.clientTxnId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deviceSeq => $composableBuilder(
      column: $table.deviceSeq, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get txnType => $composableBuilder(
      column: $table.txnType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get scannedAt => $composableBuilder(
      column: $table.scannedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userCode => $composableBuilder(
      column: $table.userCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get attempts => $composableBuilder(
      column: $table.attempts, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get nextAttemptAt => $composableBuilder(
      column: $table.nextAttemptAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastError => $composableBuilder(
      column: $table.lastError, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastErrorCode => $composableBuilder(
      column: $table.lastErrorCode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get serverResult => $composableBuilder(
      column: $table.serverResult,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$OutboxTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OutboxTransactionsTable> {
  $$OutboxTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clientTxnId => $composableBuilder(
      column: $table.clientTxnId, builder: (column) => column);

  GeneratedColumn<int> get deviceSeq =>
      $composableBuilder(column: $table.deviceSeq, builder: (column) => column);

  GeneratedColumn<String> get txnType =>
      $composableBuilder(column: $table.txnType, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get scannedAt =>
      $composableBuilder(column: $table.scannedAt, builder: (column) => column);

  GeneratedColumn<String> get userCode =>
      $composableBuilder(column: $table.userCode, builder: (column) => column);

  GeneratedColumnWithTypeConverter<OutboxStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<DateTime> get nextAttemptAt => $composableBuilder(
      column: $table.nextAttemptAt, builder: (column) => column);

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<String> get lastErrorCode => $composableBuilder(
      column: $table.lastErrorCode, builder: (column) => column);

  GeneratedColumn<String> get serverResult => $composableBuilder(
      column: $table.serverResult, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$OutboxTransactionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OutboxTransactionsTable,
    OutboxTransaction,
    $$OutboxTransactionsTableFilterComposer,
    $$OutboxTransactionsTableOrderingComposer,
    $$OutboxTransactionsTableAnnotationComposer,
    $$OutboxTransactionsTableCreateCompanionBuilder,
    $$OutboxTransactionsTableUpdateCompanionBuilder,
    (
      OutboxTransaction,
      BaseReferences<_$AppDatabase, $OutboxTransactionsTable, OutboxTransaction>
    ),
    OutboxTransaction,
    PrefetchHooks Function()> {
  $$OutboxTransactionsTableTableManager(
      _$AppDatabase db, $OutboxTransactionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OutboxTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OutboxTransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OutboxTransactionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> clientTxnId = const Value.absent(),
            Value<int> deviceSeq = const Value.absent(),
            Value<String> txnType = const Value.absent(),
            Value<String> payload = const Value.absent(),
            Value<DateTime> scannedAt = const Value.absent(),
            Value<String?> userCode = const Value.absent(),
            Value<OutboxStatus> status = const Value.absent(),
            Value<int> attempts = const Value.absent(),
            Value<DateTime?> nextAttemptAt = const Value.absent(),
            Value<String?> lastError = const Value.absent(),
            Value<String?> lastErrorCode = const Value.absent(),
            Value<String?> serverResult = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              OutboxTransactionsCompanion(
            id: id,
            clientTxnId: clientTxnId,
            deviceSeq: deviceSeq,
            txnType: txnType,
            payload: payload,
            scannedAt: scannedAt,
            userCode: userCode,
            status: status,
            attempts: attempts,
            nextAttemptAt: nextAttemptAt,
            lastError: lastError,
            lastErrorCode: lastErrorCode,
            serverResult: serverResult,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String clientTxnId,
            required int deviceSeq,
            required String txnType,
            required String payload,
            required DateTime scannedAt,
            Value<String?> userCode = const Value.absent(),
            Value<OutboxStatus> status = const Value.absent(),
            Value<int> attempts = const Value.absent(),
            Value<DateTime?> nextAttemptAt = const Value.absent(),
            Value<String?> lastError = const Value.absent(),
            Value<String?> lastErrorCode = const Value.absent(),
            Value<String?> serverResult = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              OutboxTransactionsCompanion.insert(
            id: id,
            clientTxnId: clientTxnId,
            deviceSeq: deviceSeq,
            txnType: txnType,
            payload: payload,
            scannedAt: scannedAt,
            userCode: userCode,
            status: status,
            attempts: attempts,
            nextAttemptAt: nextAttemptAt,
            lastError: lastError,
            lastErrorCode: lastErrorCode,
            serverResult: serverResult,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$OutboxTransactionsTable, OutboxTransaction>(
                        table),
                    BaseReferences<_$AppDatabase, $OutboxTransactionsTable,
                        OutboxTransaction>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OutboxTransactionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OutboxTransactionsTable,
    OutboxTransaction,
    $$OutboxTransactionsTableFilterComposer,
    $$OutboxTransactionsTableOrderingComposer,
    $$OutboxTransactionsTableAnnotationComposer,
    $$OutboxTransactionsTableCreateCompanionBuilder,
    $$OutboxTransactionsTableUpdateCompanionBuilder,
    (
      OutboxTransaction,
      BaseReferences<_$AppDatabase, $OutboxTransactionsTable, OutboxTransaction>
    ),
    OutboxTransaction,
    PrefetchHooks Function()>;
typedef $$CachedItemsTableCreateCompanionBuilder = CachedItemsCompanion
    Function({
  required String itemCode,
  Value<String?> description,
  Value<int> stdPalletQty,
  Value<int?> wheelsPerLayer,
  Value<int?> stdBoxQty,
  Value<String?> channel,
  Value<int> rowid,
});
typedef $$CachedItemsTableUpdateCompanionBuilder = CachedItemsCompanion
    Function({
  Value<String> itemCode,
  Value<String?> description,
  Value<int> stdPalletQty,
  Value<int?> wheelsPerLayer,
  Value<int?> stdBoxQty,
  Value<String?> channel,
  Value<int> rowid,
});

class $$CachedItemsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedItemsTable> {
  $$CachedItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get itemCode => $composableBuilder(
      column: $table.itemCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stdPalletQty => $composableBuilder(
      column: $table.stdPalletQty, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get wheelsPerLayer => $composableBuilder(
      column: $table.wheelsPerLayer,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stdBoxQty => $composableBuilder(
      column: $table.stdBoxQty, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get channel => $composableBuilder(
      column: $table.channel, builder: (column) => ColumnFilters(column));
}

class $$CachedItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedItemsTable> {
  $$CachedItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get itemCode => $composableBuilder(
      column: $table.itemCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stdPalletQty => $composableBuilder(
      column: $table.stdPalletQty,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get wheelsPerLayer => $composableBuilder(
      column: $table.wheelsPerLayer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stdBoxQty => $composableBuilder(
      column: $table.stdBoxQty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get channel => $composableBuilder(
      column: $table.channel, builder: (column) => ColumnOrderings(column));
}

class $$CachedItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedItemsTable> {
  $$CachedItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get itemCode =>
      $composableBuilder(column: $table.itemCode, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<int> get stdPalletQty => $composableBuilder(
      column: $table.stdPalletQty, builder: (column) => column);

  GeneratedColumn<int> get wheelsPerLayer => $composableBuilder(
      column: $table.wheelsPerLayer, builder: (column) => column);

  GeneratedColumn<int> get stdBoxQty =>
      $composableBuilder(column: $table.stdBoxQty, builder: (column) => column);

  GeneratedColumn<String> get channel =>
      $composableBuilder(column: $table.channel, builder: (column) => column);
}

class $$CachedItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedItemsTable,
    CachedItem,
    $$CachedItemsTableFilterComposer,
    $$CachedItemsTableOrderingComposer,
    $$CachedItemsTableAnnotationComposer,
    $$CachedItemsTableCreateCompanionBuilder,
    $$CachedItemsTableUpdateCompanionBuilder,
    (CachedItem, BaseReferences<_$AppDatabase, $CachedItemsTable, CachedItem>),
    CachedItem,
    PrefetchHooks Function()> {
  $$CachedItemsTableTableManager(_$AppDatabase db, $CachedItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> itemCode = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int> stdPalletQty = const Value.absent(),
            Value<int?> wheelsPerLayer = const Value.absent(),
            Value<int?> stdBoxQty = const Value.absent(),
            Value<String?> channel = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedItemsCompanion(
            itemCode: itemCode,
            description: description,
            stdPalletQty: stdPalletQty,
            wheelsPerLayer: wheelsPerLayer,
            stdBoxQty: stdBoxQty,
            channel: channel,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String itemCode,
            Value<String?> description = const Value.absent(),
            Value<int> stdPalletQty = const Value.absent(),
            Value<int?> wheelsPerLayer = const Value.absent(),
            Value<int?> stdBoxQty = const Value.absent(),
            Value<String?> channel = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedItemsCompanion.insert(
            itemCode: itemCode,
            description: description,
            stdPalletQty: stdPalletQty,
            wheelsPerLayer: wheelsPerLayer,
            stdBoxQty: stdBoxQty,
            channel: channel,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$CachedItemsTable, CachedItem>(table),
                    BaseReferences<_$AppDatabase, $CachedItemsTable,
                        CachedItem>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CachedItemsTable,
    CachedItem,
    $$CachedItemsTableFilterComposer,
    $$CachedItemsTableOrderingComposer,
    $$CachedItemsTableAnnotationComposer,
    $$CachedItemsTableCreateCompanionBuilder,
    $$CachedItemsTableUpdateCompanionBuilder,
    (CachedItem, BaseReferences<_$AppDatabase, $CachedItemsTable, CachedItem>),
    CachedItem,
    PrefetchHooks Function()>;
typedef $$CachedLocationsTableCreateCompanionBuilder = CachedLocationsCompanion
    Function({
  required String locationCode,
  Value<String?> zone,
  Value<String?> locationType,
  Value<int?> capacity,
  Value<int> rowid,
});
typedef $$CachedLocationsTableUpdateCompanionBuilder = CachedLocationsCompanion
    Function({
  Value<String> locationCode,
  Value<String?> zone,
  Value<String?> locationType,
  Value<int?> capacity,
  Value<int> rowid,
});

class $$CachedLocationsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedLocationsTable> {
  $$CachedLocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get locationCode => $composableBuilder(
      column: $table.locationCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get zone => $composableBuilder(
      column: $table.zone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locationType => $composableBuilder(
      column: $table.locationType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get capacity => $composableBuilder(
      column: $table.capacity, builder: (column) => ColumnFilters(column));
}

class $$CachedLocationsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedLocationsTable> {
  $$CachedLocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get locationCode => $composableBuilder(
      column: $table.locationCode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get zone => $composableBuilder(
      column: $table.zone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locationType => $composableBuilder(
      column: $table.locationType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get capacity => $composableBuilder(
      column: $table.capacity, builder: (column) => ColumnOrderings(column));
}

class $$CachedLocationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedLocationsTable> {
  $$CachedLocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get locationCode => $composableBuilder(
      column: $table.locationCode, builder: (column) => column);

  GeneratedColumn<String> get zone =>
      $composableBuilder(column: $table.zone, builder: (column) => column);

  GeneratedColumn<String> get locationType => $composableBuilder(
      column: $table.locationType, builder: (column) => column);

  GeneratedColumn<int> get capacity =>
      $composableBuilder(column: $table.capacity, builder: (column) => column);
}

class $$CachedLocationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedLocationsTable,
    CachedLocation,
    $$CachedLocationsTableFilterComposer,
    $$CachedLocationsTableOrderingComposer,
    $$CachedLocationsTableAnnotationComposer,
    $$CachedLocationsTableCreateCompanionBuilder,
    $$CachedLocationsTableUpdateCompanionBuilder,
    (
      CachedLocation,
      BaseReferences<_$AppDatabase, $CachedLocationsTable, CachedLocation>
    ),
    CachedLocation,
    PrefetchHooks Function()> {
  $$CachedLocationsTableTableManager(
      _$AppDatabase db, $CachedLocationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedLocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedLocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedLocationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> locationCode = const Value.absent(),
            Value<String?> zone = const Value.absent(),
            Value<String?> locationType = const Value.absent(),
            Value<int?> capacity = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedLocationsCompanion(
            locationCode: locationCode,
            zone: zone,
            locationType: locationType,
            capacity: capacity,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String locationCode,
            Value<String?> zone = const Value.absent(),
            Value<String?> locationType = const Value.absent(),
            Value<int?> capacity = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedLocationsCompanion.insert(
            locationCode: locationCode,
            zone: zone,
            locationType: locationType,
            capacity: capacity,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$CachedLocationsTable, CachedLocation>(table),
                    BaseReferences<_$AppDatabase, $CachedLocationsTable,
                        CachedLocation>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedLocationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CachedLocationsTable,
    CachedLocation,
    $$CachedLocationsTableFilterComposer,
    $$CachedLocationsTableOrderingComposer,
    $$CachedLocationsTableAnnotationComposer,
    $$CachedLocationsTableCreateCompanionBuilder,
    $$CachedLocationsTableUpdateCompanionBuilder,
    (
      CachedLocation,
      BaseReferences<_$AppDatabase, $CachedLocationsTable, CachedLocation>
    ),
    CachedLocation,
    PrefetchHooks Function()>;
typedef $$CachedPalletsTableCreateCompanionBuilder = CachedPalletsCompanion
    Function({
  required String palletNumber,
  Value<String?> itemCode,
  Value<String?> typeSeries,
  Value<String?> status,
  Value<int> packedQty,
  Value<String?> locationCode,
  Value<bool> isHold,
  Value<DateTime> syncedAt,
  Value<int> rowid,
});
typedef $$CachedPalletsTableUpdateCompanionBuilder = CachedPalletsCompanion
    Function({
  Value<String> palletNumber,
  Value<String?> itemCode,
  Value<String?> typeSeries,
  Value<String?> status,
  Value<int> packedQty,
  Value<String?> locationCode,
  Value<bool> isHold,
  Value<DateTime> syncedAt,
  Value<int> rowid,
});

class $$CachedPalletsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedPalletsTable> {
  $$CachedPalletsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get palletNumber => $composableBuilder(
      column: $table.palletNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itemCode => $composableBuilder(
      column: $table.itemCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get typeSeries => $composableBuilder(
      column: $table.typeSeries, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get packedQty => $composableBuilder(
      column: $table.packedQty, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locationCode => $composableBuilder(
      column: $table.locationCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isHold => $composableBuilder(
      column: $table.isHold, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnFilters(column));
}

class $$CachedPalletsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedPalletsTable> {
  $$CachedPalletsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get palletNumber => $composableBuilder(
      column: $table.palletNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itemCode => $composableBuilder(
      column: $table.itemCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get typeSeries => $composableBuilder(
      column: $table.typeSeries, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get packedQty => $composableBuilder(
      column: $table.packedQty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locationCode => $composableBuilder(
      column: $table.locationCode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isHold => $composableBuilder(
      column: $table.isHold, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnOrderings(column));
}

class $$CachedPalletsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedPalletsTable> {
  $$CachedPalletsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get palletNumber => $composableBuilder(
      column: $table.palletNumber, builder: (column) => column);

  GeneratedColumn<String> get itemCode =>
      $composableBuilder(column: $table.itemCode, builder: (column) => column);

  GeneratedColumn<String> get typeSeries => $composableBuilder(
      column: $table.typeSeries, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get packedQty =>
      $composableBuilder(column: $table.packedQty, builder: (column) => column);

  GeneratedColumn<String> get locationCode => $composableBuilder(
      column: $table.locationCode, builder: (column) => column);

  GeneratedColumn<bool> get isHold =>
      $composableBuilder(column: $table.isHold, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$CachedPalletsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedPalletsTable,
    CachedPallet,
    $$CachedPalletsTableFilterComposer,
    $$CachedPalletsTableOrderingComposer,
    $$CachedPalletsTableAnnotationComposer,
    $$CachedPalletsTableCreateCompanionBuilder,
    $$CachedPalletsTableUpdateCompanionBuilder,
    (
      CachedPallet,
      BaseReferences<_$AppDatabase, $CachedPalletsTable, CachedPallet>
    ),
    CachedPallet,
    PrefetchHooks Function()> {
  $$CachedPalletsTableTableManager(_$AppDatabase db, $CachedPalletsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedPalletsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedPalletsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedPalletsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> palletNumber = const Value.absent(),
            Value<String?> itemCode = const Value.absent(),
            Value<String?> typeSeries = const Value.absent(),
            Value<String?> status = const Value.absent(),
            Value<int> packedQty = const Value.absent(),
            Value<String?> locationCode = const Value.absent(),
            Value<bool> isHold = const Value.absent(),
            Value<DateTime> syncedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedPalletsCompanion(
            palletNumber: palletNumber,
            itemCode: itemCode,
            typeSeries: typeSeries,
            status: status,
            packedQty: packedQty,
            locationCode: locationCode,
            isHold: isHold,
            syncedAt: syncedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String palletNumber,
            Value<String?> itemCode = const Value.absent(),
            Value<String?> typeSeries = const Value.absent(),
            Value<String?> status = const Value.absent(),
            Value<int> packedQty = const Value.absent(),
            Value<String?> locationCode = const Value.absent(),
            Value<bool> isHold = const Value.absent(),
            Value<DateTime> syncedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedPalletsCompanion.insert(
            palletNumber: palletNumber,
            itemCode: itemCode,
            typeSeries: typeSeries,
            status: status,
            packedQty: packedQty,
            locationCode: locationCode,
            isHold: isHold,
            syncedAt: syncedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$CachedPalletsTable, CachedPallet>(table),
                    BaseReferences<_$AppDatabase, $CachedPalletsTable,
                        CachedPallet>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedPalletsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CachedPalletsTable,
    CachedPallet,
    $$CachedPalletsTableFilterComposer,
    $$CachedPalletsTableOrderingComposer,
    $$CachedPalletsTableAnnotationComposer,
    $$CachedPalletsTableCreateCompanionBuilder,
    $$CachedPalletsTableUpdateCompanionBuilder,
    (
      CachedPallet,
      BaseReferences<_$AppDatabase, $CachedPalletsTable, CachedPallet>
    ),
    CachedPallet,
    PrefetchHooks Function()>;
typedef $$NumberBlocksTableCreateCompanionBuilder = NumberBlocksCompanion
    Function({
  Value<int> id,
  required String prefix,
  required int blockStart,
  required int blockEnd,
  required int nextValue,
  Value<DateTime> issuedAt,
  Value<bool> exhausted,
});
typedef $$NumberBlocksTableUpdateCompanionBuilder = NumberBlocksCompanion
    Function({
  Value<int> id,
  Value<String> prefix,
  Value<int> blockStart,
  Value<int> blockEnd,
  Value<int> nextValue,
  Value<DateTime> issuedAt,
  Value<bool> exhausted,
});

class $$NumberBlocksTableFilterComposer
    extends Composer<_$AppDatabase, $NumberBlocksTable> {
  $$NumberBlocksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get prefix => $composableBuilder(
      column: $table.prefix, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get blockStart => $composableBuilder(
      column: $table.blockStart, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get blockEnd => $composableBuilder(
      column: $table.blockEnd, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get nextValue => $composableBuilder(
      column: $table.nextValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get issuedAt => $composableBuilder(
      column: $table.issuedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get exhausted => $composableBuilder(
      column: $table.exhausted, builder: (column) => ColumnFilters(column));
}

class $$NumberBlocksTableOrderingComposer
    extends Composer<_$AppDatabase, $NumberBlocksTable> {
  $$NumberBlocksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get prefix => $composableBuilder(
      column: $table.prefix, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get blockStart => $composableBuilder(
      column: $table.blockStart, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get blockEnd => $composableBuilder(
      column: $table.blockEnd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get nextValue => $composableBuilder(
      column: $table.nextValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get issuedAt => $composableBuilder(
      column: $table.issuedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get exhausted => $composableBuilder(
      column: $table.exhausted, builder: (column) => ColumnOrderings(column));
}

class $$NumberBlocksTableAnnotationComposer
    extends Composer<_$AppDatabase, $NumberBlocksTable> {
  $$NumberBlocksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get prefix =>
      $composableBuilder(column: $table.prefix, builder: (column) => column);

  GeneratedColumn<int> get blockStart => $composableBuilder(
      column: $table.blockStart, builder: (column) => column);

  GeneratedColumn<int> get blockEnd =>
      $composableBuilder(column: $table.blockEnd, builder: (column) => column);

  GeneratedColumn<int> get nextValue =>
      $composableBuilder(column: $table.nextValue, builder: (column) => column);

  GeneratedColumn<DateTime> get issuedAt =>
      $composableBuilder(column: $table.issuedAt, builder: (column) => column);

  GeneratedColumn<bool> get exhausted =>
      $composableBuilder(column: $table.exhausted, builder: (column) => column);
}

class $$NumberBlocksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NumberBlocksTable,
    NumberBlock,
    $$NumberBlocksTableFilterComposer,
    $$NumberBlocksTableOrderingComposer,
    $$NumberBlocksTableAnnotationComposer,
    $$NumberBlocksTableCreateCompanionBuilder,
    $$NumberBlocksTableUpdateCompanionBuilder,
    (
      NumberBlock,
      BaseReferences<_$AppDatabase, $NumberBlocksTable, NumberBlock>
    ),
    NumberBlock,
    PrefetchHooks Function()> {
  $$NumberBlocksTableTableManager(_$AppDatabase db, $NumberBlocksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NumberBlocksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NumberBlocksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NumberBlocksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> prefix = const Value.absent(),
            Value<int> blockStart = const Value.absent(),
            Value<int> blockEnd = const Value.absent(),
            Value<int> nextValue = const Value.absent(),
            Value<DateTime> issuedAt = const Value.absent(),
            Value<bool> exhausted = const Value.absent(),
          }) =>
              NumberBlocksCompanion(
            id: id,
            prefix: prefix,
            blockStart: blockStart,
            blockEnd: blockEnd,
            nextValue: nextValue,
            issuedAt: issuedAt,
            exhausted: exhausted,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String prefix,
            required int blockStart,
            required int blockEnd,
            required int nextValue,
            Value<DateTime> issuedAt = const Value.absent(),
            Value<bool> exhausted = const Value.absent(),
          }) =>
              NumberBlocksCompanion.insert(
            id: id,
            prefix: prefix,
            blockStart: blockStart,
            blockEnd: blockEnd,
            nextValue: nextValue,
            issuedAt: issuedAt,
            exhausted: exhausted,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$NumberBlocksTable, NumberBlock>(table),
                    BaseReferences<_$AppDatabase, $NumberBlocksTable,
                        NumberBlock>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NumberBlocksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $NumberBlocksTable,
    NumberBlock,
    $$NumberBlocksTableFilterComposer,
    $$NumberBlocksTableOrderingComposer,
    $$NumberBlocksTableAnnotationComposer,
    $$NumberBlocksTableCreateCompanionBuilder,
    $$NumberBlocksTableUpdateCompanionBuilder,
    (
      NumberBlock,
      BaseReferences<_$AppDatabase, $NumberBlocksTable, NumberBlock>
    ),
    NumberBlock,
    PrefetchHooks Function()>;
typedef $$SyncMetaTableCreateCompanionBuilder = SyncMetaCompanion Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$SyncMetaTableUpdateCompanionBuilder = SyncMetaCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$SyncMetaTableFilterComposer
    extends Composer<_$AppDatabase, $SyncMetaTable> {
  $$SyncMetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));
}

class $$SyncMetaTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncMetaTable> {
  $$SyncMetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));
}

class $$SyncMetaTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncMetaTable> {
  $$SyncMetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$SyncMetaTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncMetaTable,
    SyncMetaData,
    $$SyncMetaTableFilterComposer,
    $$SyncMetaTableOrderingComposer,
    $$SyncMetaTableAnnotationComposer,
    $$SyncMetaTableCreateCompanionBuilder,
    $$SyncMetaTableUpdateCompanionBuilder,
    (SyncMetaData, BaseReferences<_$AppDatabase, $SyncMetaTable, SyncMetaData>),
    SyncMetaData,
    PrefetchHooks Function()> {
  $$SyncMetaTableTableManager(_$AppDatabase db, $SyncMetaTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncMetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncMetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncMetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncMetaCompanion(
            key: key,
            value: value,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncMetaCompanion.insert(
            key: key,
            value: value,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$SyncMetaTable, SyncMetaData>(table),
                    BaseReferences<_$AppDatabase, $SyncMetaTable, SyncMetaData>(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncMetaTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncMetaTable,
    SyncMetaData,
    $$SyncMetaTableFilterComposer,
    $$SyncMetaTableOrderingComposer,
    $$SyncMetaTableAnnotationComposer,
    $$SyncMetaTableCreateCompanionBuilder,
    $$SyncMetaTableUpdateCompanionBuilder,
    (SyncMetaData, BaseReferences<_$AppDatabase, $SyncMetaTable, SyncMetaData>),
    SyncMetaData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$OutboxTransactionsTableTableManager get outboxTransactions =>
      $$OutboxTransactionsTableTableManager(_db, _db.outboxTransactions);
  $$CachedItemsTableTableManager get cachedItems =>
      $$CachedItemsTableTableManager(_db, _db.cachedItems);
  $$CachedLocationsTableTableManager get cachedLocations =>
      $$CachedLocationsTableTableManager(_db, _db.cachedLocations);
  $$CachedPalletsTableTableManager get cachedPallets =>
      $$CachedPalletsTableTableManager(_db, _db.cachedPallets);
  $$NumberBlocksTableTableManager get numberBlocks =>
      $$NumberBlocksTableTableManager(_db, _db.numberBlocks);
  $$SyncMetaTableTableManager get syncMeta =>
      $$SyncMetaTableTableManager(_db, _db.syncMeta);
}
