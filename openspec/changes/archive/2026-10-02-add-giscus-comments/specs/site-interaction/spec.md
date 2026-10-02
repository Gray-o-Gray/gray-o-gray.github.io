# site-interaction 变更（delta）

## ADDED Requirements

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
