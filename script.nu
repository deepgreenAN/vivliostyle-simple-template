# job waitがまだ存在しないためクロージャーに対してwaitするコマンド
export def wait [
  ...tasks: closure
  --any
] {
  job flush
  let task_ids: list<int> = $tasks | enumerate | each {|elt| 
    job spawn {
      do $elt.item
      $elt.index | job send 0
    }
  }

  if $any {
    job recv | print $"task of ($in)th finished."
    job list | get id | find ...$task_ids | each { |id| 
      job kill $id
      let number = ($task_ids | enumerate | where item == $id | get index | first)
      print $"task of ($number)th killed."
    };
    null
  } else {
    1..($task_ids | length) | each {
      job recv | print $"task of ($in)th finished."
    }
    null
  }
}