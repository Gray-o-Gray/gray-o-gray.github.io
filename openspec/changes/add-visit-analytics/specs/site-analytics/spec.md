# site-analytics 变更（delta）

## ADDED Requirements

### Requirement: 访问统计
站点 SHALL 接入 Google Analytics 4，Measurement ID SHALL 配置于 `blog/_config.icarus.yml`；全站页面 SHALL 注入 gtag 统计脚本。

#### Scenario: 统计脚本注入
- WHEN 渲染任意页面
- THEN HTML head 中包含对应 Measurement ID 的 gtag 脚本

#### Scenario: 未配置时禁用
- GIVEN Measurement ID 未填写
- WHEN 构建站点
- THEN SHALL NOT 注入任何无效统计脚本
