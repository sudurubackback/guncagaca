
class StoreIp {
  final int ownerId;
  final int storeId;
  final String ip;
  final String port;

  StoreIp({
    required this.ownerId,
    required this.storeId,
    required this.port,
    required this.ip,
  });

  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'storeId': storeId,
      'ip': ip,
      'port': port,
    };
  }

  factory StoreIp.fromMap(Map<String, dynamic> map) {
    return StoreIp(
      ownerId: map['ownerId'],
      storeId: map['storeId'],
      ip: map['ip'],
      port: map['port'],
    );
  }
}