# Navigation & UX Patterns

## 🧭 Navigation Philosophy

Kyron's navigation system is designed for **speed, clarity, and consistency**. We follow Bluesky's proven patterns while adapting them for the unique needs of a user-owned social platform.

### Core Principles

1. **5-Tab Bottom Shell**: Always visible, always accessible
2. **Platform-Native Transitions**: iOS slide, Android predictive-back
3. **Bottom Sheets Over Dialogs**: Every modal is a bottom sheet
4. **No Nested Navigation**: Flat hierarchy, direct access
5. **Consistent Patterns**: Same interactions work the same way everywhere

---

## 📱 Main Navigation

### 5-Tab Bottom Shell

Kyron uses a **5-tab bottom navigation bar** that is:
- **Always visible** (never hidden)
- **Translucent** (blends with content)
- **1px top hairline** separator
- **Icon-only** (labels hidden)
- **Active/inactive icon pairing**

**Tabs:**
1. **Home** - Main feed
2. **Activity** - Your activity and notifications summary
3. **News** - News feed (from Omnia implementation)
4. **Notifications** - Detailed notifications
5. **Profile** - Your profile

### Icon Pairing

From the Omnia implementation, we use **Iconsax** with bold/linear pairing:

| Tab | Active Icon | Inactive Icon |
|-----|-------------|---------------|
| Home | `Iconsax.home` (bold) | `Iconsax.home_copy` (linear) |
| Activity | `Iconsax.activity` (bold) | `Iconsax.activity_copy` (linear) |
| News | `Iconsax.news` (bold) | `Iconsax.news_copy` (linear) |
| Notifications | `Iconsax.notification` (bold) | `Iconsax.notification_copy` (linear) |
| Profile | `Iconsax.profile` (bold) | `Iconsax.profile_copy` (linear) |

### Flutter Implementation

```dart
// Bottom navigation bar
class MainNavigation extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  
  const MainNavigation({
    required this.currentIndex,
    required this.onTap,
  });
  
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  // Tab configuration
  final List<BottomNavigationBarItem> _tabs = [
    BottomNavigationBarItem(
      icon: Icon(Iconsax.home_copy),
      activeIcon: Icon(Iconsax.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Iconsax.activity_copy),
      activeIcon: Icon(Iconsax.activity),
      label: 'Activity',
    ),
    BottomNavigationBarItem(
      icon: Icon(Iconsax.news_copy),
      activeIcon: Icon(Iconsax.news),
      label: 'News',
    ),
    BottomNavigationBarItem(
      icon: Icon(Iconsax.notification_copy),
      activeIcon: Icon(Iconsax.notification),
      label: 'Notifications',
    ),
    BottomNavigationBarItem(
      icon: Icon(Iconsax.profile_copy),
      activeIcon: Icon(Iconsax.profile),
      label: 'Profile',
    ),
  ];
  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      items: _tabs,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      selectedItemColor: KyronTheme.accent,
      unselectedItemColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[400]
          : Colors.grey[600],
      selectedFontSize: 0, // Hide labels
      unselectedFontSize: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      // 1px top hairline
      elevation: 0,
    );
  }
}

// Usage in main container
class MainContainer extends StatefulWidget {
  @override
  _MainContainerState createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  int _currentIndex = 0;
  
  final List<Widget> _pages = [
    HomeScreen(),
    ActivityScreen(),
    NewsScreen(),
    NotificationsScreen(),
    ProfileScreen(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: MainNavigation(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
```

---

## 🔄 Navigation Transitions

### Platform-Native Transitions

**iOS:**
- **Push**: Horizontal slide from right
- **Pop**: Horizontal slide to right
- **Parallax**: Outgoing screen parallax effect
- **Duration**: 260ms (normal)

**Android:**
- **Push**: Predictive back with slide
- **Pop**: Slide to right
- **Duration**: 260ms (normal)

**Web:**
- **Push**: Browser-native navigation
- **Pop**: Browser-native back
- **Fallback**: Slide transition

### Flutter Implementation

```dart
// Custom page transition builder
class KyronPageTransitionsBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Platform-specific transitions
    if (Platform.isIOS) {
      return _buildIosTransition(route, context, animation, secondaryAnimation, child);
    } else if (Platform.isAndroid) {
      return _buildAndroidTransition(route, context, animation, secondaryAnimation, child);
    }
    return _buildDefaultTransition(route, context, animation, secondaryAnimation, child);
  }
  
  Widget _buildIosTransition<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      )),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0.0, 0.0),
          end: Offset(-0.3, 0.0), // Parallax effect
        ).animate(CurvedAnimation(
          parent: secondaryAnimation,
          curve: Curves.easeOut,
        )),
        child: child,
      ),
    );
  }
  
  Widget _buildAndroidTransition<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      )),
      child: child,
    );
  }
  
  Widget _buildDefaultTransition<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }
}

// Usage in MaterialApp
MaterialApp(
  theme: ThemeData(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: KyronPageTransitionsBuilder(),
        TargetPlatform.android: KyronPageTransitionsBuilder(),
      },
    ),
  ),
)
```

---

## 📦 Sheet System

### Bottom Sheets Over Dialogs

**Every confirmation, picker, form, and menu is a bottom sheet.**

**Characteristics:**
- **Full-width** on mobile
- **20px top corner radius**
- **Grab handle** at top
- **Slide up from bottom** animation (260ms)
- **Slide down** animation (180ms)
- **No centered dialogs** on mobile

### Sheet Types

#### 1. Modal Sheet

For confirmations, forms, and complex inputs.

```dart
// Show modal bottom sheet
void showKyronSheet(BuildContext context, Widget child) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(RadiusTokens.radius20),
      ),
    ),
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Grab handle
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.only(top: SpacingTokens.space8, bottom: SpacingTokens.space8),
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor,
              borderRadius: BorderRadius.circular(RadiusTokens.radius2),
            ),
          ),
          // Content
          child,
        ],
      );
    },
  );
}
```

#### 2. Confirmation Sheet

For simple confirm/cancel dialogs.

```dart
// Show confirmation sheet
Future<bool> showKyronConfirm(BuildContext context, {
  required String title,
  required String message,
  String confirmText = 'Confirm',
  String cancelText = 'Cancel',
}) async {
  return await showModalBottomSheet<bool>(
    context: context,
    backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(RadiusTokens.radius20),
      ),
    ),
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Grab handle
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.only(top: SpacingTokens.space8, bottom: SpacingTokens.space8),
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor,
              borderRadius: BorderRadius.circular(RadiusTokens.radius2),
            ),
          ),
          // Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SpacingTokens.space16),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          // Message
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SpacingTokens.space16,
              vertical: SpacingTokens.space8,
            ),
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          // Buttons
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SpacingTokens.space16,
              vertical: SpacingTokens.space16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: KyronButton(
                    text: cancelText,
                    onPressed: () => Navigator.pop(context, false),
                    variant: ButtonVariant.solidSecondary,
                  ),
                ),
                SizedBox(width: SpacingTokens.space12),
                Expanded(
                  child: KyronButton(
                    text: confirmText,
                    onPressed: () => Navigator.pop(context, true),
                    variant: ButtonVariant.solidPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  ) ?? false;
}
```

#### 3. Menu Sheet

For action menus and overflow.

```dart
// Show menu sheet
void showKyronMenu(BuildContext context, List<MenuItem> items) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(RadiusTokens.radius20),
      ),
    ),
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Grab handle
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.only(top: SpacingTokens.space8, bottom: SpacingTokens.space8),
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor,
              borderRadius: BorderRadius.circular(RadiusTokens.radius2),
            ),
          ),
          // Menu items
          ...items.map((item) => ListTile(
            leading: item.icon,
            title: Text(item.title),
            subtitle: item.subtitle != null ? Text(item.subtitle!) : null,
            onTap: () {
              Navigator.pop(context);
              item.onTap?.call();
            },
          )).toList(),
        ],
      );
    },
  );
}

class MenuItem {
  final Widget? icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  
  MenuItem({
    this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
  });
}
```

---

## 🎯 Thread Navigation

### Thread Anatomy

Kyron uses **Threads-style reply anatomy** for nested conversations:

**Geometry:**
- **Indent**: 30px (one avatar radius + gutter)
- **Thickness**: 2px (1px too thin, reads as hairline)
- **Corner**: 12px (half the indent, quarter-circle turns)
- **Max Indent**: 4 levels (prevents running off screen)

**Three Separate Concerns:**
1. **Layout**: Which rows exist and in what order (`buildThreadLayout`)
2. **Geometry**: Where the lines go (`ThreadConnectorPlan.forRow`)
3. **Painting**: How to draw the plan (`ThreadConnectorPainter`)

### Flutter Implementation

```dart
// Thread geometry configuration
class ThreadGeometry {
  static const double indent = 30.0;
  static const double thickness = 2.0;
  static const double corner = 12.0;
  static const int maxIndent = 4;
}

// Thread connector painter
class ThreadConnectorPainter extends CustomPainter {
  final ThreadConnectorPlan plan;
  final Color color;
  
  ThreadConnectorPainter({required this.plan, required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = ThreadGeometry.thickness
      ..style = PaintingStyle.stroke;
    
    // Paint rail
    canvas.drawLine(
      Offset(plan.railX, 0),
      Offset(plan.railX, size.height),
      paint,
    );
    
    // Paint elbow if needed
    if (plan.hasElbow) {
      final path = Path()
        ..moveTo(plan.railX, plan.elbowY)
        ..lineTo(plan.railX + ThreadGeometry.corner, plan.elbowY)
        ..arcToPoint(
          Offset(plan.railX + ThreadGeometry.corner, plan.elbowY + ThreadGeometry.corner),
          radius: Radius.circular(ThreadGeometry.corner),
        );
      canvas.drawPath(path, paint);
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Thread connector plan
class ThreadConnectorPlan {
  final double railX;
  final double elbowY;
  final bool hasElbow;
  
  ThreadConnectorPlan({
    required this.railX,
    required this.elbowY,
    required this.hasElbow,
  });
  
  static ThreadConnectorPlan forRow({
    required int depth,
    required bool hasLaterSibling,
    required bool isLastInThread,
    required double rowHeight,
  }) {
    final indent = depth * ThreadGeometry.indent;
    final railX = indent - ThreadGeometry.thickness / 2;
    final hasElbow = !isLastInThread;
    final elbowY = hasLaterSibling ? rowHeight / 2 : rowHeight;
    
    return ThreadConnectorPlan(
      railX: railX,
      elbowY: elbowY,
      hasElbow: hasElbow,
    );
  }
}
```

---

## 📱 Feed Navigation

### Feed Interaction Patterns

#### 1. Post Tap

- **Single tap**: Open post detail
- **Double tap**: Like post (with haptic feedback)
- **Long press**: Show post menu
- **Swipe right**: Navigate back

#### 2. Feed Scroll

- **Pull down**: Refresh feed
- **Reach top**: Show "New posts" banner
- **Reach bottom**: Load more posts
- **Fast scroll**: Show scroll-to-top button

#### 3. Post Detail

- **Swipe up**: Dismiss detail, return to feed
- **Tap outside**: Dismiss detail
- **Swipe right on reply**: Navigate to reply thread

### Flutter Implementation

```dart
// Post card with gesture support
class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onTap;
  final VoidCallback onDoubleTap;
  final VoidCallback onLongPress;
  
  const PostCard({
    required this.post,
    required this.onTap,
    required this.onDoubleTap,
    required this.onLongPress,
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      child: _buildPostContent(context),
    );
  }
  
  Widget _buildPostContent(BuildContext context) {
    // Post content implementation
    return Container(
      padding: EdgeInsets.all(SpacingTokens.space12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          // Content
          // Actions
        ],
      ),
    );
  }
}

// Feed with pull-to-refresh
class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final RefreshController _refreshController = RefreshController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) => PostCard(
            post: posts[index],
            onTap: () => _openPostDetail(posts[index]),
            onDoubleTap: () => _likePost(posts[index]),
            onLongPress: () => _showPostMenu(posts[index]),
          ),
        ),
      ),
      floatingActionButton: ScrollToTopButton(),
    );
  }
  
  Future<void> _onRefresh() async {
    // Load new posts
    await _loadNewPosts();
    _refreshController.refreshCompleted();
  }
  
  void _openPostDetail(Post post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostDetailScreen(post: post),
      ),
    );
  }
  
  void _likePost(Post post) {
    Haptics.light();
    // Optimistic update
    setState(() {
      post.isLiked = !post.isLiked;
      post.likeCount += post.isLiked ? 1 : -1;
    });
    // Send to server
    _api.likePost(post.id);
  }
  
  void _showPostMenu(Post post) {
    showKyronMenu(context, [
      MenuItem(
        icon: Icon(Iconsax.share),
        title: 'Share',
        onTap: () => _sharePost(post),
      ),
      MenuItem(
        icon: Icon(Iconsax.bookmark),
        title: 'Save',
        onTap: () => _savePost(post),
      ),
      MenuItem(
        icon: Icon(Iconsax.more),
        title: 'More options',
        onTap: () => _showMoreOptions(post),
      ),
    ]);
  }
}
```

---

## 🎨 UX Patterns

### 1. Scroll to Top

**Behavior:**
- Button appears when user scrolls down > 1.5 screens
- **AND** is moving upward (not while reading downward)
- Button disappears when user scrolls up or reaches top

**Implementation:**

```dart
class ScrollToTop extends StatefulWidget {
  final Widget child;
  
  const ScrollToTop({required this.child});
  
  @override
  _ScrollToTopState createState() => _ScrollToTopState();
}

class _ScrollToTopState extends State<ScrollToTop> {
  bool _showButton = false;
  double _lastScrollPosition = 0;
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification) {
              final currentPosition = notification.metrics.pixels;
              final isScrollingUp = currentPosition < _lastScrollPosition;
              
              setState(() {
                _showButton = currentPosition > MediaQuery.of(context).size.height * 1.5
                    && isScrollingUp;
                _lastScrollPosition = currentPosition;
              });
            }
            return false;
          },
          child: widget.child,
        ),
        if (_showButton)
          Positioned(
            bottom: SpacingTokens.space16,
            right: SpacingTokens.space16,
            child: FloatingActionButton(
              onPressed: _scrollToTop,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
              ),
              child: Icon(Iconsax.arrow_up),
            ),
          ),
      ],
    );
  }
  
  void _scrollToTop() {
    Scrollable.of(context)?.position.jumpTo(0);
    Haptics.light();
  }
}
```

### 2. Sticky Day Headers

**Behavior:**
- Day headers pin to top of their section
- Next day header displaces the previous one
- Uses `SliverPersistentHeader` with `SliverMainAxisGroup`

**Implementation:**

```dart
class ActivityFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Group by day
        ..._groupByDay(activities).entries.map((entry) {
          return SliverMainAxisGroup(
            slivers: [
              // Day header
              SliverPersistentHeader(
                pinned: true,
                delegate: _DayHeaderDelegate(
                  day: entry.key,
                  height: 48,
                ),
              ),
              // Activities for this day
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => ActivityItem(activity: entry.value[index]),
                  childCount: entry.value.length,
                ),
              ),
            ],
          );
        }).toList(),
      ],
    );
  }
  
  Map<DateTime, List<Activity>> _groupByDay(List<Activity> activities) {
    // Group activities by day
    // ...
  }
}

class _DayHeaderDelegate extends SliverPersistentHeaderDelegate {
  final DateTime day;
  final double height;
  
  _DayHeaderDelegate({required this.day, required this.height});
  
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: height,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Text(
          _formatDay(day),
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }
  
  @override
  double get maxExtent => height;
  
  @override
  double get minExtent => height;
  
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
```

### 3. Link Preview

**Behavior:**
- Only first link in a post gets a card
- Only when post has no picture
- Shows host (can't be dressed up by page)
- No skeleton - wait for metadata or show nothing

**Implementation:**

```dart
class LinkPreviewCard extends StatelessWidget {
  final String url;
  
  const LinkPreviewCard({required this.url});
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LinkPreviewData>(
      future: _fetchLinkPreview(url),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildPreviewCard(context, snapshot.data!);
        }
        return SizedBox.shrink(); // No skeleton
      },
    );
  }
  
  Widget _buildPreviewCard(BuildContext context, LinkPreviewData data) {
    return Container(
      margin: EdgeInsets.only(top: SpacingTokens.space8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(RadiusTokens.radius12),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image (if available)
          if (data.imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(RadiusTokens.radius12),
              ),
              child: Image.network(data.imageUrl!, fit: BoxFit.cover),
            ),
          // Content
          Padding(
            padding: EdgeInsets.all(SpacingTokens.space12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Host (most important - can't be faked)
                Text(
                  data.host,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                  ),
                ),
                // Title
                if (data.title != null)
                  Text(
                    data.title!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                // Description
                if (data.description != null)
                  Text(
                    data.description!,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Future<LinkPreviewData> _fetchLinkPreview(String url) async {
    // Parse HTML head for meta tags
    // Return LinkPreviewData with title, description, image, host
    // ...
  }
}

class LinkPreviewData {
  final String host;
  final String? title;
  final String? description;
  final String? imageUrl;
  
  LinkPreviewData({
    required this.host,
    this.title,
    this.description,
    this.imageUrl,
  });
}
```

---

## 📊 Navigation Guidelines

### Do's ✅

1. **Use bottom sheets** for all modals on mobile
2. **Use platform-native transitions** (iOS slide, Android predictive-back)
3. **Fire haptics on touch-down** for all interactive elements
4. **Use pill-shaped buttons** for all primary actions
5. **Use hairline borders** for separation (not shadows)
6. **Respect safe areas** on all platforms
7. **Use consistent gestures** across the app

### Don'ts ❌

1. **Don't use centered dialogs** on mobile (use bottom sheets)
2. **Don't use nested navigation** (keep hierarchy flat)
3. **Don't use Material ink ripples** (use scale+opacity)
4. **Don't hide the bottom navigation** (always visible)
5. **Don't use inconsistent gestures** for the same action
6. **Don't animate every interaction** (be intentional)

---

## 🔗 References

- [Bluesky Navigation Patterns](https://github.com/bluesky-social/social-app/tree/main/src/components)
- [Flutter Navigation](https://docs.flutter.dev/ui/navigation)
- [Material Design Navigation](https://m3.material.io/components/navigation-drawer/overview)
- [iOS Human Interface Guidelines - Navigation](https://developer.apple.com/design/human-interface-guidelines/patterns/navigation/)
- [Android Navigation Patterns](https://developer.android.com/design/ui/navigation)

---

*"Navigation should be invisible. Users should find what they need without thinking about how."*

**Navigation & UX Patterns Documentation** — Version 1.0 — Kyron Design System
