# site-seo Specification

## Purpose
站点的 SEO 与元信息基础设施：RSS、Sitemap、robots.txt、站点语言/描述、Open Graph 元数据（2026-08-26 第一轮优化落地）。

## Requirements

### Requirement: RSS 订阅
站点 SHALL 通过 `hexo-generator-feed` 提供 `/atom.xml` 订阅源。

#### Scenario: 订阅源可访问
- WHEN 请求 /atom.xml
- THEN 返回包含最新文章的 Atom 订阅源

### Requirement: 站点地图与爬虫规则
站点 SHALL 通过 `hexo-generator-sitemap` 提供 `/sitemap.xml`，并提供 `source/robots.txt`（内含 sitemap 指向）。

#### Scenario: 爬虫抓取入口
- WHEN 搜索引擎爬虫访问 /robots.txt 与 /sitemap.xml
- THEN 均正常返回且 robots.txt 指向 sitemap

### Requirement: 站点元信息
站点配置（`blog/_config.yml`）SHALL 使用 `zh-CN` 语言、`Asia/Shanghai` 时区，并填写 subtitle/description/keywords；icarus 配置（`blog/_config.icarus.yml`）SHALL 包含 og:url/image/site_name/author/description 与 twitter_card。

#### Scenario: 页面元数据生效
- WHEN 渲染任意页面
- THEN HTML head 中包含正确的 meta description 与 Open Graph 标签

### Requirement: 站长验证与收录
站点域名 makiblog.cn SHALL 完成 Google Search Console 与 Bing Webmaster 的网域级验证（DNS TXT 记录方式），并在两平台 SHALL 提交 `/sitemap.xml`。

#### Scenario: 域名验证通过
- WHEN 在 GSC/Bing 触发验证
- THEN DNS TXT 记录匹配，验证状态为已验证

#### Scenario: sitemap 提交
- WHEN 站长平台提交 sitemap
- THEN 平台开始处理并逐步收录站点页面
