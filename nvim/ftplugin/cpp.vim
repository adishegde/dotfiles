let g:cmake_command = "cd build && cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .."

command! RegenCompileCommands :exec "!" . g:cmake_command
