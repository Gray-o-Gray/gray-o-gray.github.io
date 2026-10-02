# site-interaction Specification

## Purpose
站点的访客互动与页面功能：About 页、评论系统、分享功能（评论与分享当前处于禁用状态，待配置）。

## Requirements

### Requirement: About 页面
站点 SHALL 提供 `/about/` 页面（`blog/source/about/index.md`）。

#### Scenario: 访问 About
- WHEN 用户访问 /about/
- THEN 正常展示关于页内容

### Requirement: 无效第三方配置禁用
未完成配置的第三方组件 SHALL 保持禁用状态，SHALL NOT 渲染无效占位（如空 shortname 的评论框、空 install_url 的分享按钮）——2026-08-26 已移除无效 disqus 与 sharethis 配置。

#### Scenario: 评论区域不渲染无效框
- WHEN 评论系统未配置 shortname
- THEN 文章页不渲染任何无效评论组件

### Requirement: 评论系统
站点 SHALL 启用 giscus 评论系统（基于仓库 GitHub Discussions），文章页底部 SHALL 渲染评论区；giscus 配置参数（repo/repo-id/category/category-id）SHALL 写入 `blog/_config.icarus.yml`。

#### Scenario: 评论区渲染
- GIVEN giscus 已配置且仓库 Discussions 已开启
- WHEN 访客打开任意文章页
- THEN 文章底部渲染 giscus 评论区（未登录显示 GitHub 登录提示）

#### Scenario: 配置缺失时禁用
- GIVEN giscus 参数未填写完整
- WHEN 构建站点
- THEN 评论区域 SHALL NOT 渲染无效占位（沿用「无效配置必须禁用」约束）
