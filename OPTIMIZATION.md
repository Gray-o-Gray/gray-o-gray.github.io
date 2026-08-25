# 博客优化清单

> 检查日期：2026-08-26
> 状态说明：以下为当前博客缺失/可优化项，按优先级排列，后续逐步落实。
> ✅ = 已完成（2026-08-26 第一轮优化）

## 当前状态速览

- 文章 5 篇，正常部署（push → Actions → Pages）
- 首页 / 分类 / 标签 / 归档 / About：正常
- 主题：icarus 5.1.0，已启用 pjax、busuanzi、back_to_top、insight 搜索、gallery

---

## P0 必须修复（有功能缺失/404）

| # | 项目 | 现状 | 处理方案 |
|---|------|------|----------|
| 1 | ~~About 页面~~ | ✅ 已创建 `blog/source/about/index.md`，`/about/` 正常 | — |
| 2 | 评论系统 | 已禁用（原 disqus 无 shortname，空配置会渲染无效评论框） | 待配置：Disqus（填 shortname）或 giscus/waline |
| 3 | 分享功能 | ✅ 已禁用（sharethis 无 install_url，无效按钮已移除） | 需要时再配置 ShareThis 或其他 |

## P1 重要（SEO / 订阅 / 元信息）

| # | 项目 | 现状 | 处理方案 |
|---|------|------|----------|
| 4 | ~~RSS 订阅~~ | ✅ 已装 `hexo-generator-feed`，`/atom.xml` 正常（5 条） | — |
| 5 | ~~Sitemap~~ | ✅ 已装 `hexo-generator-sitemap`，`/sitemap.xml` 正常（14 个 URL） | — |
| 6 | ~~robots.txt~~ | ✅ 已建 `source/robots.txt`（含 sitemap 指向） | — |
| 7 | ~~站点语言~~ | ✅ `_config.yml` language 改为 `zh-CN`，timezone 改为 Asia/Shanghai | — |
| 8 | ~~站点描述~~ | ✅ subtitle/description/keywords 已填写，meta description 生效 | — |
| 9 | ~~Open Graph~~ | ✅ 已补 og:url/image/site_name/author/description、twitter_card | — |
| 10 | 搜索引擎验证 | Bing Webmaster / Google 站长验证均未配置 | 需注册：部署后在 Google Search Console / Bing Webmaster 提交站点并验证，回填 `_config.icarus.yml` 的 tracking_id |

## P2 优化（体验 / 性能 / 数据）

| # | 项目 | 现状 | 处理方案 |
|---|------|------|----------|
| 11 | 访问统计 | Google/Baidu/CNZZ 均未配置，只有 busuanzi 计数 | 需注册：接入 Google Analytics 或 umami 自建 |
| 12 | ~~图片优化~~ | ✅ logo-ai.png 已从 292KB 压缩到 96KB（1024→512px） | 文章配图后续注意压缩 |
| 13 | Email 订阅 | subscribe_email / followit widget 配置为空 | 需要订阅功能时配置 Feedburner/Follow.it |
| 14 | 数学公式 | KaTeX / MathJax 均关闭 | 如有公式需求，开启 KaTeX |
| 15 | 错误监控 | Hotjar 未配置 | 可选，暂不需要 |
| 16 | 捐赠按钮 | donates 全部为空 | 可选，按需配置爱发电/微信赞赏 |

## 内容层面

- 文章 5 篇，可规划内容方向（技术笔记/读书笔记）
- 评论系统待选型（见 P0-2）

---

## 实施备注（供后续参考）

- icarus 主题配置在 `blog/_config.icarus.yml`（不是主题目录下的 _config.yml）
- 站点配置在 `blog/_config.yml`
- 自定义样式正确位置：`themes/icarus/source/css/` 下的 `.styl` 源文件（见 README）
- 部署：push 到 master 自动构建，无需本地 hexo
