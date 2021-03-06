function bobthefish_colors -S -d 'Define a custom bobthefish color scheme'

  # optionally include a base color scheme...
  #___bobthefish_colors default

  # then override everything you want! note that these must be defined with `set -x`
  set -x color_initial_segment_exit     000000 ff0000 --bold
  set -x color_initial_segment_su       000000 189303 --bold
  set -x color_initial_segment_jobs     000000 255e87 --bold
  set -x color_initial_segment_private  000000 255e87 --bold
  set -x color_path                     333333 999999 --bold
  set -x color_path_basename            333333 ffffff --bold
  set -x color_path_nowrite             660000 cc9999
  set -x color_path_nowrite_basename    660000 cc9999 --bold
  set -x color_repo                     addc10 0c4801 --bold
  set -x color_repo_work_tree           333333 ffffff --bold
  set -x color_repo_dirty               ce000f ffffff
  set -x color_repo_staged              f6b117 3a2a03
  set -x color_vi_mode_default          999999 333333 --bold
  set -x color_vi_mode_insert           189303 333333 --bold
  set -x color_vi_mode_visual           f6b117 3a2a03 --bold
  set -x color_vagrant                  48b4fb ffffff --bold
  set -x color_username                 3333ff ffff00 --bold
  set -x color_hostname                 3333ff ffffff --bold
  set -x color_screen                   009900 ffffff --bold
  set -x color_rvm                      af0000 cccccc --bold
  set -x color_virtualfish              005faf cccccc --bold
  set -x color_virtualgo                005faf cccccc --bold
  set -x color_desk                     005faf cccccc --bold
  set -x color_nix                      005faf cccccc --bold
end

