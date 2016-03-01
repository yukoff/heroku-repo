require "tempfile"
require "heroku/command/repo"

# Slug manipulation
class Heroku::Command::Repo::Submodule < Heroku::Command::Repo

  # repo:submodule:remove
  #
  # Deletes the specified submodule from the repo config
  #
  def remove
    run <<EOF
set -e
mkdir -p tmp/repo_tmp/unpack
cd tmp/repo_tmp
curl -o repo.tgz '#{repo_get_url}'
cd unpack
tar -zxf ../repo.tgz
git config --file config --remove-section 'submodule.#{submodule}'
tar -zcf ../repack.tgz .
curl -o /dev/null --upload-file ../repack.tgz '#{repo_put_url}'
exit
EOF
  end

end
