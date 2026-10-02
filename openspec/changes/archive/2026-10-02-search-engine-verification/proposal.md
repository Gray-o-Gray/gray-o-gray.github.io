# Proposal: search-engine-verification

## Why
站点未做搜索引擎站长验证与收录提交，Google/Bing 收录状态不可控（OPTIMIZATION.md P1-10）。

## What Changes
- 通过 **DNS TXT 记录**完成 Google Search Console 与 Bing Webmaster 的域名级验证（在腾讯云 DNS 添加 TXT 记录，无需改主题代码）
- 验证通过后提交 `/sitemap.xml`
- 修改 `site-seo` spec：新增站长验证与收录要求
- 站点自身无需代码改动（DNS 验证方案）；若后续改用 meta 标签验证，再在 icarus 配置中补 tracking_id

## Capabilities
### Modified
- `site-seo`：新增「站长验证与收录」要求

## Impact
- 代码：无（DNS 验证 + 提交 sitemap 均在外部平台操作）
- 前置条件（需用户操作）：
  1. Google Search Console 添加域名资源（makiblog.cn），获取 TXT 验证记录
  2. Bing Webmaster（可直接从 GSC 导入）同样获取验证记录
  3. 在腾讯云 DNS 添加两条 TXT 记录（AI 可提供逐步指引）
