# pueueグループをテーブルとして取得する．
def pueue_group [
] {
  ^pueue group 
  | lines
  | each { |line| 
      $line 
      | parse -r 'Group "(?P<group_name>.+)" \(\d* parallel\): (?P<status>.+)' 
      | get 0
    }
}

# pueueのタスクのstatusを取得． jsonに変換するコマンドを利用している．
def pueue_status [
  --group (-g): string
] {
  if $group != null { # グループ名が与えられた場合
    ^pueue status -j -g $group 
    | from json | get tasks | values 
    | filter {|task| $task.group == $group} # グループでフィルターする．
    | each {|task| 
      {id: $task.id status: $task.status}
    }
  } else { # グループ名が与えられていない場合
    ^pueue status -j
    | from json | get tasks | values 
    | each {|task| 
     {id: $task.id status: $task.status}
    }
  }
}

# リストを意味する文字列に文字列をappendする
def append_string_list [
  item: string
] {
  if $in == "" { # 空白文字列つまり空のリストだった場合
    $item
  } else { # 空白文字列じゃなかった場合
    $in | split row " " | append $item | str join " "
  }  
}


# コマンドランナー用dev(just内で利用する)
def dev_command [] {
  if "vivliostyle" not-in (pueue_group | get group_name) {^pueue group add vivliostyle}
  if (pueue_status -g vivliostyle | get status | any {|status| $status.Done? == null}) {error make { msg: "Other tasks of vivliostyle are still running. Please kill the task."}}
  pueue pause -g vivliostyle
  let vivliostyle_id = (^pueue add -g vivliostyle -p 'npx vivliostyle preview --config vivliostyle.config.js --style style.css --executable-browser "C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"')
  let sass_id = (^pueue add -g vivliostyle -p 'nu --commands "watch style {|| sass style/index.scss style.css}"')
  [$vivliostyle_id $sass_id] | to json | save -f .temp_pueue_ids  # id_listを保存 
  ^pueue parallel 2 -g vivliostyle
  ^pueue start -g vivliostyle
}

# コマンドランナー用dev_finish(just内で利用する)
def dev_finish_command [] {
  if (".temp_pueue_ids" | path exists) {
    let id_list = open ".temp_pueue_ids" | from json # id_listを読み込み
    ^pueue kill -g vivliostyle $id_list
    rm ".temp_pueue_ids"
  }
}