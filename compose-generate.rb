# coding: utf-8
require "yaml"
require "pp"

# 以下形式の文字列をパースする
# <option value="u1">山田 太郎&nbsp;taro@example.local</option>
# <option value="u2">山田 花子&nbsp;hanako@example.local</option>
# <option value="u3">山田 次郎&nbsp;jiro@example.local</option>
users = File.foreach("./html/emails.html").map do |row|
  row.split(">")[1]
    .split("<").first
    .split("&nbsp;").last
    .split("@").first
end

# 件数が多くコンテナ数が多すぎる場合はここで絞る
limit = 99

users = users[0..limit].map do |user|
  [ user,
    {
      "container_name" => user,
      "image" => "busybox",
      "command" => "sleep 1h"
    }
  ]
end

h = { "version" => "2", "services" =>  Hash[*users.flatten] }
puts h.to_yaml



