# AVDICT

AVDICT => AV + Addict 一种优雅的方式创建你自己的AV数据库。

## 使用什么

* Ruby - 程序员好朋友
* Rails - 可靠 && 易用的web框架

## 数据来源

不同于手机用户常用的Javbus，AVDICT的数据来自于Javlibrary。

## 你需要做什么

* 在你的服务器上快速部署 Ruby && Rails 环境
* Clone this rails app
* bundle install

## 如何生成数据库
```ruby
# 查看相关命令
rake --task

rake crawler:genre
rake crawler:actor
rake crawler:label
rake crawler:video
```
