# VuePress初探

这几天才刚开通博客，说来也有一段心路。其实此前就有此打算，也为此了解过 [wordpress](https://cn.wordpress.org/)、[ghost](https://ghost.org/)、[hexo](https://hexo.io/zh-cn/) 等优秀博客框架，然而一直苦于选择，所以迟迟没有出手。直到近日一位朋友 [晚晴幽草轩轩主](https://jeffjade.com/) 向我推荐了 [VuePress](https://vuepress.vuejs.org/) ，于是上官网一看，发现这货正合我意，虽然没有花俏的主题，但基本功能已能满足博客需要。正如某位大神所说，最重要的不是用什么写，而是写了什么。于是不再纠结，果断开始一探究竟，尝试用它来搭建 [我的博客](https://zhangpingfan.github.io/)。

## VuePress介绍
简单地讲，VuePress 是一个静态网站生成器，它能够将用**Markdown**语法写成的文档结合简单的配置转换成由Vue驱动的单页应用。此外，它还拥有众多优秀特性，让使用者能够更专注于书写文档。

- 为技术文档而优化的 [内置 Markdown 拓展](https://vuepress.vuejs.org/zh/guide/markdown.html)
- [在 Markdown 文件中使用 Vue 组件的能力](https://vuepress.vuejs.org/zh/guide/using-vue.html)
- [Vue 驱动的自定义主题系统](https://vuepress.vuejs.org/zh/guide/custom-themes.html)
- [自动生成 Service Worker](https://vuepress.vuejs.org/zh/config/#serviceworker)
- [Google Analytics 集成](https://vuepress.vuejs.org/zh/config/#ga)
- [基于 Git 的 “最后更新时间”](https://vuepress.vuejs.org/zh/default-theme-config/#最后更新时间)
- [多语言支持](https://vuepress.vuejs.org/zh/guide/i18n.html)
- 默认主题包含：
  - 响应式布局
  - [可选的主页](https://vuepress.vuejs.org/zh/default-theme-config/#首页)
  - [简洁的开箱即用的标题搜索](https://vuepress.vuejs.org/zh/default-theme-config/#内置搜索)
  - [Algolia 搜索](https://vuepress.vuejs.org/zh/default-theme-config/#algolia-搜索)
  - 可自定义的[导航栏](https://vuepress.vuejs.org/zh/default-theme-config/#导航栏) 和[侧边栏](https://vuepress.vuejs.org/zh/default-theme-config/#侧边栏)
  - [自动生成的 GitHub 链接和页面的编辑链接](https://vuepress.vuejs.org/zh/default-theme-config/#git-仓库和编辑链接)

VuePress初衷是为写技术文档服务，但拿来写博客也是绰绰有余，而且尤大也计划在将来更加丰富的支持博客系统。那我们开始吧。

## 开始上手
### 安装环境
``` bash
# 全局安装（请确保你的 Node.js 版本 >= 8）
npm install -g vuepress # 或者：yarn global add vuepress

# 新建一个 markdown 文件
echo '# Hello VuePress!' > README.md

# 开始写作
vuepress dev .
```
这样就可以开始用VuePress写作了，简单吧。

不过这只是开始，打开本地调试地址（[http://localhost:8080/](http://localhost:8080/)）只能看到一个简单的页面，缺乏**菜单导航**、**搜索**等功能，要想有个像样的静态网站，还要另外做一些配置。

### 配置
一开始看官网上手配置可能比较吃力，于是先从github上拉官方项目源码
``` bash
git clone https://github.com/vuejs/vuepress.git
```
我们先跳过vuepress的源码和相关脚本，直接看示例文档部分（即docs目录内容）

其目录结构大致如下：

```
├─ docs
│  ├─ README.md
│  ├─ zh
│  └─ .vuepress
│     └─ config.js
└─ ...
```
配置的核心文件是 **.vuepress/config.js** ，其他则是可自行组织目录结构的文档和静态资源，站内的每一个子文件夹都应当有一个 **README.md** 文件，它会被自动编译为 index.html。官方文档的示例分出了中英文两个版本的 guide 、default-theme-config、config 目录，这里为方便演示会对目录和配置稍做精简。

来看看 config.js 的内容

``` javascript
module.exports = {
  base: String,            // 部署站点的基础路径
  title: String,           // 网站标题
  description: String,     // 网站描述
  dest: String,            // 指定 vuepress build 的输出目录
  locales: Object,         // 多语言支持的语言配置 
  head: Array,             // 注入到当前页面的 HTML <head> 中的标签
  serviceWorker: Boolean,  // 是否自动生成并且注册一个 service worker
  theme: String,           // 主题
  themeConfig: Object      // 主题配置
}
```
那么可以开始根据个人喜好修改配置（ 以下配置基于官方默认主题，如需定制请参考 [自定义主题](https://vuepress.vuejs.org/zh/guide/custom-themes.html) ）:
#### 配置首页
在 locales 选项中配置多语言的基础路径、标题和描述
``` javascript
module.exports = {
  locales: {
    // 键名是该语言所属的子路径
    // 作为特例，默认语言可以使用 '/' 作为其路径。
    '/': {
      lang: 'en-US', // 将会被设置为 <html> 的 lang 属性
      title: 'VuePress',
      description: 'Vue-powered Static Site Generator'
    },
    '/zh/': { /* ... */ }
  }
}
```
在 ./docs/README.md 中加入如下 [Front Matter](https://vuepress.vuejs.org/zh/guide/markdown.html#front-matter)，指定`home: true`即可使用默认主题的 [首页布局](https://vuepress.vuejs.org/zh/default-theme-config/#%E9%A6%96%E9%A1%B5)
``` yaml
---
home: true
heroImage: /hero.png
actionText: Get Started →
actionLink: /guide/
footer: MIT Licensed | Copyright © 2018-present Evan You
---
```
#### 配置导航栏
将nav部分按自己组织的目录结构修改即可
``` javascript
module.exports = {
  locales: { /* ... */ },
  themeConfig: {
    locales: {
      '/': {
        nav: [
          {
            text: 'Guide',
            link: '/guide/',
          },
          {
            text: 'Config Reference',
            link: '/config/'
          },
          {
            text: 'Default Theme Config',
            link: '/default-theme-config/'
          }
        ]
      },
      '/zh/': { /* ... */ }
    }
  }
}
```
#### 修改主题色
创建一个 `.vuepress/override.styl` 文件，配置如下：
``` stylus
$accentColor = #3eaf7c  // 主题色
$textColor = #2c3e50    // 文字颜色
$borderColor = #eaecef  // 边框颜色
$codeBgColor = #282c34  // 代码背景颜色
```
## 部署
- 构建用于部署的静态文件
``` bash
# 跳至docs目录
cd docs
# 构建静态文件
vuepress build .
```
- 在 config.js 中配置的 dest 路径（ 默认为 `.vuepress/dist` ）下将生成静态文件
- 将目录内文件放到线上服务器即可完成部署

如果懒得改配置，又想发布到 [GitHub Pages](https://pages.github.com/)，也可以直接使用 [我的模版](https://github.com/ZhangPingFan/vuepress-template) ，只需按说明稍做修改再加上自己的文章即可轻松部署自己的博客或文档，当然每加一篇文章还是要在 config.js 中加上对应链接。

## Todo
- 集成gittalk评论插件
- 集成Google Analytics