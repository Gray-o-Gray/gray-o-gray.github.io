---
title: 收到 Google Search Console 提醒后，我挖出了博客的两个隐患
date: 2026-10-07 15:48:25
categories:
  - 技术
tags:
  - 博客
  - Hexo
  - SEO
  - 踩坑记录
---
今天收到一封 Google Search Console 的邮件：「网页已编入索引的原因」一节提示，站点地图中的部分网页因 `noindex` 被排除。排查下来发现这不是问题的全部——顺着这条线索，我还挖出了一个更隐蔽的隐患：一篇文章的发布日期和 URL 正在悄悄漂移。这篇文章记录两个问题的定位过程和修复方案。

## 隐患一：sitemap 里的页面自带 noindex

### 现象

Search Console 报告：`sitemap.xml` 中提交的 7 个标签页（如 `/tags/Hexo/`）都被 `<meta name="robots" content="noindex">` 排除，"提交收录"和"页面拒绝收录"自相矛盾。

### 定位

检查主题源码，Icarus 在 `head.jsx` 里有一行明确的策略：

```jsx
const noIndex = helper.is_archive() || helper.is_category() || helper.is_tag();
```

也就是说，Icarus 刻意不让归档、分类、标签页被收录——这些页面内容与文章列表高度重复，noindex 是避免重复内容稀释权重的常见做法，本身没问题。

问题出在 `hexo-generator-sitemap` 的默认配置上：它默认把标签页也写进 sitemap，于是产生了矛盾。

### 修复

在 `_config.yml` 的 sitemap 配置中加两行：

```yaml
sitemap:
  path: sitemap.xml
  tags: false
  categories: false
```

重新生成后，sitemap 从 14 个 URL 变成 7 个，只剩文章页、首页和 about 页，与主题的 noindex 策略保持一致。这类提醒本身不影响正常文章的收录，属于配置不一致问题，但顺手处理掉可以让 Search Console 的报告更干净。

## 隐患二：会"漂移"的文章日期（真正的问题）

在核对页面时发现，最早的 `Hello World` 文章，发布时间显示成了 10 月 2 日。深入排查后发现，这不只是显示问题。

### 定位

对比几篇文章的源文件，发现了关键差异：

```yaml
# 其他文章都有
date: 2024-12-01 22:07:51

# hello-world.md 只有
title: Hello World
```

`hello-world.md` 是 Hexo 初始化时的示例文章，front matter 里缺少 `date` 字段。Hexo 的回退逻辑是：没有声明日期时，**用文件的修改时间（mtime）作为文章日期**。

在本地构建时，文件时间戳被保留，日期显示正常。但博客是通过 GitHub Actions 构建部署的，而 `actions/checkout` **不保留文件时间戳**——构建机上所有文件的 mtime 都等于拉取代码那一刻。于是：

```
文章日期 = 最近一次构建日期
```

上一次构建是 10 月 2 日，所以页面显示 10 月 2 日。

### 更严重的后果

Hexo 的文章永久链接由日期决定（`/:year/:month/:day/:title/`），所以这不只是日期显示错误——验证后发现：

- 旧地址 `https://www.makiblog.cn/2024/10/08/hello-world/` → **404**
- 文章实际地址已经漂移到了 `/2026/10/07/hello-world/`

也就是说，这篇文章的 URL **每次构建都会变**，外部链接失效，还会不断给搜索引擎制造 404。

### 修复

在 front matter 补上原始日期：

```yaml
---
title: Hello World
date: 2024-10-08 23:29:42
---
```

部署后验证：旧地址恢复 200，漂移地址消失，日期永久固定。

## 复盘与启示

这两个问题有同一个模式：**本地一切正常，CI 构建环境却不同**。

1. **sitemap 问题**是配置层面的不一致：插件默认收录标签页，主题却 noindex 它们。两套默认行为各自合理，叠加起来就矛盾了。
2. **日期漂移**是环境差异：本地保留了文件 mtime，CI 的 checkout 重新生成。依赖文件时间戳而不是显式声明的数据，在任何构建流水线里都是隐患。

以后写文章记两条：front matter 必须带 `date` 字段（`hexo new` 默认会生成，手写时别省略）；sitemap 提交的页面集合要和页面的 robots 策略对齐。
