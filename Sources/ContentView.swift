import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.allowsBackForwardNavigationGestures = false
        webView.scrollView.bounces = false
        
        // ===== 测试代码：加载本地 HTML =====
        let html = """
        <html><body style="background:#111;color:#fff;display:flex;justify-content:center;align-items:center;height:100vh;margin:0;font-family:sans-serif;">
        <h1>WebView 壳子正常运行！</h1>
        </body></html>
        """
        webView.loadHTMLString(html, baseURL: nil)
        // ===== 测试代码结束 =====
        
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

struct ContentView: View {
    var body: some View {
        WebView(url: URL(string: "http://127.0.0.1:3080")!)
            .ignoresSafeArea()
    }
}