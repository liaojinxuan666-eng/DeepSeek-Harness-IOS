import SwiftUI
import WebKit
import Foundation

struct WebView: UIViewRepresentable {
    let url: URL
    @Binding var status: String

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: config)

        // 1. 启动时检查 Alpine 资源
        checkAlpineResource()

        // 2. 把结果显示在 WebView 上
        let html = """
        <html>
        <body style="background:#111;color:#fff;display:flex;justify-content:center;align-items:center;height:100vh;margin:0;font-family:sans-serif;text-align:center;padding:20px;">
        <h1>\(status)</h1>
        </body>
        </html>
        """
        webView.loadHTMLString(html, baseURL: nil)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    // 检查 CI 里打包进 App 的 Alpine 资源
    private func checkAlpineResource() {
        if let bundleURL = Bundle.main.url(forResource: "alpine-minirootfs", withExtension: "tar.gz", subdirectory: "Resources") {
            status = "✅ 找到 Alpine 资源包！\n文件名: \(bundleURL.lastPathComponent)"
        } else {
            status = "❌ 找不到 Alpine 资源包\n(检查 CI 是否下载和打包成功)"
        }
    }
}

struct ContentView: View {
    @State private var status = "正在检查 Alpine 环境..."

    var body: some View {
        WebView(url: URL(string: "http://127.0.0.1:3080")!, status: $status)
            .ignoresSafeArea()
    }
}