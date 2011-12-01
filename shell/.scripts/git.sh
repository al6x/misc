# Git
function gstatus(){
  # method=$1;
  # if [ "$method" = "all" ]; then
  #   ~/.profile_ext/git.rb status all
  # else
    git status
  # fi  
}

function gpush(){
	git push
}

function gpull(){
	git pull
}

function gcommit(){
  comment=$1;
	git add . && git commit -a -m "$comment" && git push
}





# alias git_ext='~/.scripts/git_ext'                                                                      
                                                                                                        
# alias gstatus='git status'                                                                              
# alias gpush='git push'                                                                                  
# alias gpull='git pull'
# alias gcommit='gadd && git commit -a -m'                                                                


        
# alias gadd='git add .'

# alias gsmstatus="git_ext each_submodule 'git status'"                                                   
# alias gsmpull="git_ext each_submodule 'git pull'"                                                       
# alias gsmadd="git_ext each_submodule 'git add .'"                                                       
# function gsmcommit() { git_ext each_submodule "git commit -a -m '$@'" ;}                                
# alias gsmpush="git_ext each_submodule 'git push'"