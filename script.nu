# 利用する環境変数のアサーション
if $env.VIVLIOSTYLE_BROUSER_PATH? == null {
  error make {msg: "Environment bariable 'VIVLIOSTYLE_BROUSER_PATH' is not setted." }
}

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
def dev_command [
  pueue_group_name: string,
  temp_file_path: string
] {
  if $pueue_group_name not-in (pueue_group | get group_name) {
    ^pueue group add $pueue_group_name
  }
  if (pueue_status -g $pueue_group_name | get status | any {|status| ($status | describe) == string }) {
    error make { 
      msg: "Other tasks of vivliostyle are still running. Please kill the task."
      }
  }
  pueue pause -g $pueue_group_name
  print $env.VIVLIOSTYLE_BROUSER_PATH
  let vivliostyle_id = (^pueue add -g $pueue_group_name -p "nu -c 'vivliostyle preview --config vivliostyle.config.js --style style.css --executable-browser $env.VIVLIOSTYLE_BROUSER_PATH'")
  let sass_id = (^pueue add -g $pueue_group_name -p "nu -c 'watch style {|| sass style/index.scss style.css}'")
  [$vivliostyle_id $sass_id] | to json | save -f $temp_file_path  # id_listを保存 
  ^pueue parallel 2 -g $pueue_group_name
  ^pueue start -g $pueue_group_name
  print "Starting dev server for this vivliostyle template. Please wait for it."
}

# コマンドランナー用dev_finish(just内で利用する)
def dev_finish_command [
  pueue_group_name: string,
  temp_file_path: string
] {
  if ($temp_file_path| path exists) {
    let id_list = open $temp_file_path| from json # id_listを読み込み
    ^pueue kill -g $pueue_group_name $id_list
    rm $temp_file_path
    sleep 500ms
    ^pueue clean -g $pueue_group_name
    print "Finished dev server."
  }
}