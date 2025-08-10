import 'package:flutter/material.dart';

/// Demo pin task ở dưới màn hình: nền be dưới + chip "Đóng",
/// panel xanh trên và bị khoét bằng 3 đường cong nối nhau (90° tangents).
class PinTaskTripleNotchDemo extends StatelessWidget {
  const PinTaskTripleNotchDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    // ===== Layout params (tinh chỉnh tuỳ UI thật) =====
    const double panelRadius = 22;            // bo 4 góc panel xanh
    final double greenHeight = h * 0.25;      // cao panel xanh ≈ 1/4 màn
    final double beigeHeight = greenHeight*0.7;
    const double beigeWidth  = 140;
    const double beigeRadius = 18;
    const double insetRight  = 5;             // theo yêu cầu
    const double insetTop    = 10;

    // ===== Notch params (3 curve) =====
    // P0 (top), P1, P2 (giữa), P3 (right) – xem sơ đồ đã duyệt
    const double notchTopX      = 160; // từ mép phải lùi vào trên đỉnh
    const double p1DxFromRight  = 120; // P1.x = w - p1DxFromRight
    const double p1Y            = 24;
    const double p2DxFromRight  = 70;  // P2.x = w - p2DxFromRight
    const double p2Y            = 44;
    const double notchRightY    = 72;  // P3.y

    // độ “gắt” của 3 cua (nhỏ hơn = gắt hơn, vuông hơn)
    const double r1 = 24; // tại P1
    const double r2 = 28; // tại P2
    const double r3 = 20; // tại P3

    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: greenHeight,
              width: double.infinity,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // ===== NỀN BE DƯỚI + CHIP "Đóng" =====
                  Positioned(
                    right: insetRight,
                    top: insetTop,
                    child: Container(
                      width: beigeWidth,
                      height: beigeHeight,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEED6),
                        borderRadius: BorderRadius.circular(beigeRadius),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: insetRight + 12,
                    top: insetTop + 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEED6),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.close, size: 18, color: Colors.black87),
                          SizedBox(width: 6),
                          Text('Đóng', style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),

                  // ===== PANEL XANH TRÊN — CLIPPATH 3 CURVE 90° =====
                  Positioned.fill(
                    child: ClipPath(
                      clipper: _TripleNotch90Clipper(
                        panelRadius: panelRadius,
                        notchTopX: notchTopX,
                        p1DxFromRight: p1DxFromRight, p1Y: p1Y,
                        p2DxFromRight: p2DxFromRight, p2Y: p2Y,
                        notchRightY: notchRightY,
                        r1: r1, r2: r2, r3: r3,
                        straightRatio: 2.5 / 3.0, // đi thẳng ~2.5/3 trước khi rẽ
                        edgeGuard: 8.0,           // lề an toàn mép phải
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF45B36B), Color(0xFF178A49)],
                          ),
                        ),
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: const [
                              Icon(Icons.expand_less, color: Colors.white, size: 20),
                              SizedBox(width: 6),
                              Text('Nhiệm vụ bạn cần hoàn thành:',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                              Spacer(),
                              SizedBox(width: 120), // chừa vùng notch
                            ]),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE9F8EA),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: const Text('Thanh toán thẻ tín dụng',
                                  style: TextStyle(fontWeight: FontWeight.w600)),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Clipper: 3 đoạn cubic Bezier nối liên tục, tiếp tuyến **trục X/Y (90°)** tại P0, P1, P2, P3.
/// Clipper: 3 đoạn cubic + đoạn thẳng từ P2→Q trước khi rẽ xuống P3.
/// Giữ tiếp tuyến 90° ở P0/P1/P2/P3 và có edgeGuard chống tràn mép phải.
class _TripleNotch90Clipper extends CustomClipper<Path> {
  final double panelRadius;
  final double notchTopX;
  final double p1DxFromRight, p1Y;
  final double p2DxFromRight, p2Y;
  final double notchRightY;
  final double r1, r2, r3;

  /// Tỉ lệ đoạn thẳng P2→Q (0..1), ví dụ 2.5/3 = 0.8333
  final double straightRatio;

  /// Lề an toàn cách mép phải để không tràn ra ngoài
  final double edgeGuard;

  _TripleNotch90Clipper({
    required this.panelRadius,
    required this.notchTopX,
    required this.p1DxFromRight,
    required this.p1Y,
    required this.p2DxFromRight,
    required this.p2Y,
    required this.notchRightY,
    required this.r1,
    required this.r2,
    required this.r3,
    this.straightRatio = 2.5 / 3.0,
    this.edgeGuard = 8.0,
  });

  @override
  Path getClip(Size s) {
    final w = s.width, h = s.height, r = panelRadius;

    final P0 = Offset((w - notchTopX) < r ? r : (w - notchTopX), 0);
    final P1 = Offset(w - p1DxFromRight, p1Y);
    final P2 = Offset(w - p2DxFromRight, p2Y);
    final P3 = Offset(w, (notchRightY < r) ? r : notchRightY);

    // P0→P1 (90°)
    final C1_0 = Offset(P0.dx + r1, P0.dy);
    final C2_0 = Offset(P1.dx, P1.dy - r1);

    // P1→P2 (90°)
    final C1_1 = Offset(P1.dx, P1.dy + r1);
    final C2_1 = Offset(P2.dx - r2, P2.dy);

    // P2→Q: đi thẳng, có edge guard
    final maxInsideX = w - edgeGuard;
    final dxToRight = (maxInsideX - P2.dx).clamp(0, w);
    final needForTurn = (r2 + edgeGuard);
    final maxStraight = (dxToRight - needForTurn).clamp(0, dxToRight);
    final straightLen = (dxToRight * straightRatio).clamp(0, maxStraight);
    final Q = Offset(P2.dx + straightLen, P2.dy);

    // Q→P3 (90°)
    final C1_2 = Offset((Q.dx + r2).clamp(0, maxInsideX), Q.dy);
    final C2_2 = Offset(P3.dx, (P3.dy - r3).clamp(0, h));

    final p = Path()
      ..moveTo(r, 0)
      ..lineTo(P0.dx, 0)
      ..cubicTo(C1_0.dx, C1_0.dy, C2_0.dx, C2_0.dy, P1.dx, P1.dy)
      ..cubicTo(C1_1.dx, C1_1.dy, C2_1.dx, C2_1.dy, P2.dx, P2.dy)
      ..lineTo(Q.dx, Q.dy) // đoạn thẳng trước khi rẽ
      ..cubicTo(C1_2.dx, C1_2.dy, C2_2.dx, C2_2.dy, P3.dx, P3.dy)
      ..lineTo(w, h - r)
      ..quadraticBezierTo(w, h, w - r, h)
      ..lineTo(r, h)
      ..quadraticBezierTo(0, h, 0, h - r)
      ..lineTo(0, r)
      ..quadraticBezierTo(0, 0, r, 0)
      ..close();

    return p;
  }

  @override
  bool shouldReclip(_TripleNotch90Clipper old) =>
      old.panelRadius != panelRadius ||
          old.notchTopX != notchTopX ||
          old.p1DxFromRight != p1DxFromRight || old.p1Y != p1Y ||
          old.p2DxFromRight != p2DxFromRight || old.p2Y != p2Y ||
          old.notchRightY != notchRightY ||
          old.r1 != r1 || old.r2 != r2 || old.r3 != r3 ||
          old.straightRatio != straightRatio ||
          old.edgeGuard != edgeGuard;
}

