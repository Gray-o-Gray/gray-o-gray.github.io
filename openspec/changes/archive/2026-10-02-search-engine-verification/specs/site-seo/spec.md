# site-seo 变更（delta）

## ADDED Requirements

### Requirement: 站长验证与收录
站点域名 makiblog.cn SHALL 完成 Google Search Console 与 Bing Webmaster 的网域级验证（DNS TXT 记录方式），并在两平台 SHALL 提交 `/sitemap.xml`。

#### Scenario: 域名验证通过
- WHEN 在 GSC/Bing 触发验证
- THEN DNS TXT 记录匹配，验证状态为已验证

#### Scenario: sitemap 提交
- WHEN 站长平台提交 sitemap
- THEN 平台开始处理并逐步收录站点页面
