# RVM
[[ -s "/Users/alex/.rvm/scripts/rvm" ]] && source "/Users/alex/.rvm/scripts/rvm"

function gemdir(){
	cd $(rvm gemdir); cd gems
}

# Ruby
# export RUBYOPT="-Ku -rrubygems"
# export RUBYOPT="-rrubygems"
# rvm use 1.9.2-head

export RUBYOPT="-rrubygems -I/Users/alex/projects/class_loader/lib -I/Users/alex/projects/cluster_management/lib -I/Users/alex/projects/code_stats/lib -I/Users/alex/projects/rad/lib -I/Users/alex/projects/file_model/lib -I/Users/alex/projects/ext/lib -I/Users/alex/projects/micon/lib -I/Users/alex/projects/mongodb/lib -I/Users/alex/projects/mongodb_model/lib -I/Users/alex/projects/my_cluster/lib -I/Users/alex/projects/ruby_ext/lib -I/Users/alex/projects/saas/lib -I/Users/alex/projects/sbs/lib -I/Users/alex/projects/validatable2/lib -I/Users/alex/projects/vfs/lib -I/Users/alex/projects/vos/lib"

# Rad
function fake_rad(){
  /Users/alex/projects/rad/bin/rad $*
}

# Projects
function bunch(){
  ~/.scripts/bunch.rb $*
}