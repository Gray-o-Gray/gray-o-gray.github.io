# content-publishing Specification

## Purpose
文章内容的创作与发布流程：Markdown 源文件存放于 `blog/source/_posts/`，通过 hexo draft/publish 工作流写作，push 后自动部署。

## Requirements

### Requirement: 文章目录
文章 SHALL 以 Markdown 形式存放于 `blog/source/_posts/`；站点图片存放于 `blog/source/img/`，文章配图使用 PicGo 上传 GitHub 图床并引用外链 URL。

#### Scenario: 新增文章
- WHEN 在 `_posts/` 下新增 Markdown 文件并 push
- THEN 构建后文章在站点上可见（首页/归档/标签/分类）

### Requirement: 草稿工作流
写作 SHALL 支持 hexo 草稿流：`npx hexo new draft <title>` 创建草稿、`npx hexo s --draft` 本地预览、`npx hexo publish <title>` 发布为正式文章。

#### Scenario: 草稿发布
- WHEN 对某草稿执行 `hexo publish`
- THEN 草稿移动到 `_posts/` 并在下次构建后上线
