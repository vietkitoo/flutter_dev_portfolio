import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_portfolio/home/bloc/home_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreenView();
  }
}

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  final PageController _pageController = PageController();

  final List<Widget> _pages = const [
    Center(child: Text('List')),
    PinTaskDemo(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Portfolio'), centerTitle: true),
          body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              context.read<HomeScreenCubit>().onPageChanged(index);
            },
            children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.selectedIndex,
            onTap: (index) {
              context.read<HomeScreenCubit>().onTapBottomNav(index);
              _pageController.jumpToPage(index);
            },
            selectedItemColor: Colors.blueAccent,
            selectedFontSize: 16,
            unselectedItemColor: Colors.black54,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view),
                label: 'Danh sách',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'About me',
              ),
            ],
          ),
        );
      },
    );
  }
}

class PinTaskDemo extends StatelessWidget {
  const PinTaskDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    // ======= Thông số mặc định (bạn có thể đổi) =======
    final double greenHeight = h * 0.25;  // panel xanh ≈ 1/4 màn
    final double beigeHeight = greenHeight * 0.72; // be thấp hơn 1 tí
    final double panelRadius = 20.r;      // bo 4 góc panel xanh
    final double beigeRadius = 18.r;      // bo nền be
    final double insetRight = 5.0;       // theo yêu cầu: phải 5.sp
    final double insetTop = 10.r;         // be cách đỉnh panel xanh một chút

    // Đường cong “một lần” từ mép trên -> mép phải
    final double notchTopX = 120.r;       // lùi từ mép phải vào trên đỉnh
    final double notchRightY = 56.r;      // đi xuống theo mép phải
    final double tension = 0.42;          // độ mềm 0.3..0.6

    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      body: Stack(
        children: [
          // ======= PIN TASK Ở DƯỚI MÀN HÌNH =======
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: greenHeight, // chiều cao tổng theo panel xanh (be thấp hơn “ẩn” bên dưới)
              width: double.infinity,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // ----- NỀN BE Ở DƯỚI + NÚT ĐÓNG -----
                  Positioned(
                    right: insetRight,
                    top: insetTop,
                    child: Container(
                      height: beigeHeight,
                      width: 160.w, // tuỳ layout thực tế
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEED6),
                        borderRadius: BorderRadius.circular(beigeRadius),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 10.r,
                            offset: Offset(0, 4.r),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: insetRight + 12.w,
                    top: insetTop + 10.h,
                    child: _CloseChip(beigeColor: const Color(0xFFFFEED6)),
                  ),

                  // ----- PANEL XANH Ở TRÊN: BỊ CẮT 1 LẦN CONG -----
                  Positioned.fill(
                    child: ClipPath(
                      clipper: _OneBendNotchClipper(
                        radius: panelRadius,
                        notchTopX: notchTopX,
                        notchRightY: notchRightY,
                        tension: tension,
                        // vị trí thẻ be để chừa đúng khoảng trống (tham số hoá nếu cần)
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF45B36B), Color(0xFF178A49)],
                          ),
                        ),
                        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // demo header
                            Row(
                              children: [
                                const Icon(Icons.expand_less, color: Colors.white, size: 20),
                                SizedBox(width: 6.w),
                                Text(
                                  'Nhiệm vụ bạn cần hoàn thành:',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white, borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Text(
                                    '03',
                                    style: TextStyle(
                                      color: const Color(0xFFFF6A00),
                                      fontWeight: FontWeight.w800,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(width: 120.w), // chừa vùng notch
                              ],
                            ),
                            SizedBox(height: 12.h),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE9F8EA),
                                borderRadius: BorderRadius.circular(18.r),
                              ),
                              child: Text(
                                'Thanh toán thẻ tín dụng',
                                style: TextStyle(
                                  color: const Color(0xFF222222),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                ),
                              ),
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

class _CloseChip extends StatelessWidget {
  const _CloseChip({required this.beigeColor});
  final Color beigeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: beigeColor,
        borderRadius: BorderRadius.circular(28.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.close, size: 18, color: Colors.black87),
          SizedBox(width: 6.w),
          Text(
            'Đóng',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}

/// Clipper cắt panel xanh bằng 1 đường cong (cubic) từ cạnh trên -> cạnh phải.
/// Không cong lên lại (đúng yêu cầu “chỉ cong 1 lần”).
class _OneBendNotchClipper extends CustomClipper<Path> {
  final double radius;      // bo 4 góc của panel xanh
  final double notchTopX;   // từ mép phải lùi vào trên đỉnh (rộng notch trên)
  final double notchRightY; // từ đỉnh đi xuống mép phải (độ sâu notch)
  final double tension;     // 0..1 – độ mềm đường cong

  _OneBendNotchClipper({
    required this.radius,
    required this.notchTopX,
    required this.notchRightY,
    required this.tension,
  });

  @override
  Path getClip(Size s) {
    final double w = s.width;
    final double h = s.height;

    final double r = radius;
    // bảo toàn biên (không xài clamp trả num → không lỗi kiểu)
    final double nx = (w - notchTopX < r) ? r : (w - notchTopX);
    final double ny = (notchRightY < r) ? r : notchRightY;
    final double t  = tension.clamp(0.0, 1.0).toDouble();

    final p = Path();

    // 1) cạnh trên từ bo trái -> trước notch
    p.moveTo(r, 0);
    p.lineTo(nx, 0);

    // 2) đường cong 1 lần từ (nx, 0) -> (w, ny)
    //    c1 kéo theo trục X; c2 kéo theo trục Y để tiếp tuyến mượt
    final Offset c1 = Offset(nx + (w - nx) * t, 0);
    final Offset c2 = Offset(w, ny * (1 - t));
    p.cubicTo(c1.dx, c1.dy, c2.dx, c2.dy, w, ny);

    // 3) cạnh phải xuống -> bo dưới-phải
    p.lineTo(w, h - r);
    p.quadraticBezierTo(w, h, w - r, h);

    // 4) đáy -> bo dưới-trái
    p.lineTo(r, h);
    p.quadraticBezierTo(0, h, 0, h - r);

    // 5) cạnh trái -> bo trái-trên -> đóng
    p.lineTo(0, r);
    p.quadraticBezierTo(0, 0, r, 0);
    p.close();

    return p;
  }

  @override
  bool shouldReclip(_OneBendNotchClipper old) =>
      old.radius != radius ||
          old.notchTopX != notchTopX ||
          old.notchRightY != notchRightY ||
          old.tension != tension;
}
