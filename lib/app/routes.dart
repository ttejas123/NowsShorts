// import 'package:bl_inshort/features/discover/presentation/discover_page.dart';
// import 'package:bl_inshort/features/feed/presentation/feed_page.dart';
// import 'package:flutter/material.dart';
import 'package:bl_inshort/features/notifications/presentation/notifications_page.dart';
import 'package:bl_inshort/features/webview/presentation/webview_page.dart';
import 'package:go_router/go_router.dart';
import 'package:bl_inshort/features/shell/home_shell_page.dart';


/// Named routes for clarity
// enum AppRoute {
//   feed,
//   discover,
// }

// GoRouter buildRouter() {
//   return GoRouter(
//     initialLocation: '/discover',
//     routes: [
//       GoRoute(
//         path: '/feed',
//         name: AppRoute.feed.name,
//         pageBuilder: (context, state) => const NoTransitionPage(
//           child: FeedPage(),
//         ),
//       ),
//       GoRoute(
//         path: '/discover',
//         name: AppRoute.discover.name,
//         pageBuilder: (context, state) => const NoTransitionPage(
//           child: DiscoverPage(),
//         ),
//       ),
//     ],
//   );
// }


// import 'package:shortnews/features/shell/home_shell_page.dart';

GoRouter buildRouter() {
  const String marketingHtml = '''
   <!doctype html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1" />
<title>Limited Offer — ShortNews</title>
<style>
  /* Mobile-first, simple & clean */
  :root{
    --bg:#f7f9fc;
    --card:#ffffff;
    --muted:#6b7280;
    --accent:#0b72ff;
    --accent-2:#0047b3;
    --radius:14px;
  }
  html,body{height:100%;margin:0;background:var(--bg);font-family:system-ui,-apple-system,Segoe UI,Roboto,"Helvetica Neue",Arial;color:#07122a}
  a{color:inherit;text-decoration:none}
  .wrap{max-width:420px;margin:0 auto;padding:18px}
  .card{background:var(--card);border-radius:var(--radius);box-shadow:0 8px 20px rgba(12,20,30,0.06);overflow:hidden;border:1px solid #eceff3}
  .hero{display:flex;flex-direction:column;gap:12px;padding:16px}
  .label{display:inline-block;background:#fff;padding:6px 10px;border-radius:999px;font-weight:700;color:var(--accent);font-size:12px;border:1px solid rgba(11,114,255,0.08)}
  .title{font-size:20px;line-height:1.08;margin-top:6px;font-weight:800;color:#07122a}
  .subtitle{color:var(--muted);font-size:14px;margin-top:6px}
  .preview{width:100%;height:190px;border-radius:12px;overflow:hidden;background:#eef3ff;display:block;border:1px solid #eef5ff}
  .preview img{width:100%;height:100%;object-fit:cover;display:block}

  .cta-row{display:flex;gap:10px;margin-top:12px}
  .btn-primary{flex:1;background:linear-gradient(90deg,var(--accent),var(--accent-2));color:#fff;padding:12px;border-radius:10px;border:0;font-weight:800;text-align:center}
  .btn-outline{flex:1;border-radius:10px;border:1px solid #e6eefc;padding:11px;text-align:center;color:#07122a;background:transparent}

  .features{display:flex;gap:10px;margin:12px 0;align-items:flex-start}
  .feature-img{width:78px;height:78px;border-radius:10px;flex-shrink:0;object-fit:cover;box-shadow:0 8px 18px rgba(2,6,23,0.06)}
  .feature-text{font-size:14px;color:#07122a;font-weight:700}
  .feature-sub{font-size:13px;color:var(--muted);margin-top:6px}

  .small{font-size:13px;color:var(--muted);margin-top:10px}
  .footer-card{margin-top:14px;padding:12px;display:flex;gap:12px;align-items:center}
  .badge{background:#ffefef;color:#9b1b1b;padding:6px 10px;border-radius:999px;font-weight:700;font-size:12px;border:1px solid rgba(255,0,0,0.06)}

  /* responsive adjustments although layout is mobile-first */
  @media (min-width:420px){
    .wrap{margin-left:auto;margin-right:auto}
  }
</style>
</head>
<body>
  <div class="wrap" role="main">
    <div class="card" role="region" aria-label="Limited offer">
      <div class="hero">
        <span class="label" aria-hidden="true">LAUNCH OFFER</span>
        <div class="title">ShortNews Pro — 50% OFF for early users</div>
        <div class="subtitle">Ad-free reading, priority alerts and interactive charts. Limited seats — act now.</div>

        <a class="preview" href="shortnews://campaign/preview" aria-label="Preview demo">
          <img src="https://images.unsplash.com/photo-1522202176988-66273c2fd55f?q=80&w=1080&auto=format&fit=crop&ixlib=rb-4.0.3&s=3b7f3dd6c8c8b4f6047b9f" alt="Preview image">
        </a>

        <div class="cta-row" role="group" aria-label="Actions">
          <a class="btn-primary" href="shortnews://campaign/claim" role="button" aria-label="Claim offer">CLAIM OFFER</a>
          <a class="btn-outline" href="shortnews://campaign/preview" role="button" aria-label="Preview demo">PREVIEW</a>
        </div>

        <div class="features" aria-hidden="true">
          <img class="feature-img" src="https://images.unsplash.com/photo-1542222028-0ef12f3b3a12?q=80&w=800&auto=format&fit=crop&ixlib=rb-4.0.3&s=1a2b3c" alt="Charts">
          <div>
            <div class="feature-text">Interactive charts</div>
            <div class="feature-sub">Pinch & explore market graphs</div>
          </div>
        </div>

        <div class="small">Secure checkout • 7-day refund • Instant access after claim. Offer valid for first 5,000 sign-ups.</div>
      </div>
    </div>

    <div class="card footer-card" aria-hidden="true">
      <img src="https://images.unsplash.com/photo-1518770660439-4636190af475?q=80&w=800&auto=format&fit=crop&ixlib=rb-4.0.3&s=2b3c4d" alt="Premium" style="width:64px;height:64px;border-radius:10px;object-fit:cover">
      <div style="flex:1">
        <div style="font-weight:800;color:#07122a">Why go Pro?</div>
        <div style="color:var(--muted);font-size:13px;margin-top:6px">Curated insights, priority newsletters, and an ad-free reading experience made for power users.</div>
      </div>
      <div style="text-align:right">
        <div style="font-weight:900;color:#07122a">50% OFF</div>
        <a class="btn-primary" href="shortnews://campaign/claim" style="display:inline-block;padding:8px 10px;font-size:13px;margin-top:8px">Activate</a>
      </div>
    </div>
  </div>
</body>
</html>

  ''';
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: HomeShellPage(),
        ),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsPage(),
      ),
      GoRoute(
        path: '/webview/analytic',
        builder: (context, state) => const AdvancedWebView(
          initialHtml: marketingHtml,
          title: 'Campaign',
          injectCSS: 'body { background: #fff; color: #111 } img { max-width:100% }',
          injectJS: "console.log('campaign loaded')",
          enableJavaScript: true,
          showAppBar: true,
        ),
      ),
      // later: add story/detail routes here
      // GoRoute(
      //   path: '/story/:id',
      //   builder: (context, state) => StoryPage(id: state.pathParameters['id']!),
      // ),
    ],
  );
}
