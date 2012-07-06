require 'rake/remote_task'

namespace :sooty do
  
  remote_task :setup do
    run setup_puppet_repo_cmd
    run install_puppet_cmd
  end

  remote_task :apply do
    sh create_puppet_archive_cmd
    rsync '/tmp/puppet.tar.gz', '/tmp'
    run puppet_apply_cmd
  end

  def setup_puppet_repo_cmd
    deb_file = 'puppetlabs-release-stable.deb'
    
    repo_cmd = [
      "wget http://apt.puppetlabs.com/#{deb_file}",
      "sudo dpkg -i #{deb_file}", 
      "rm #{deb_file}"
    ].join(' && ')

    "test -f /etc/apt/sources.list.d/puppetlabs.list || { #{repo_cmd}; }"
  end

  def install_puppet_cmd
    install_cmd = [
      'sudo apt-get update',
      'sudo aptitude install -y puppet'
    ].join(' && ')

    "which puppet || { #{install_cmd}; }"
  end

  def create_puppet_archive_cmd
    cmds = [
      'rm -rf /tmp/puppet',
      'mkdir /tmp/puppet',
      "cp #{puppet_manifest} /tmp/puppet/manifest.pp"
    ]

    if defined? puppet_modules
      cmds += ["cp -r #{puppet_modules} /tmp/puppet/modules"]
    end

    cmds += [
      'cd /tmp',
      'tar cvfz puppet.tar.gz puppet'
    ]

    cmds.join(' && ')
  end

  def puppet_apply_cmd
    cmds = [
      'cd /tmp',
      'tar xvfz puppet.tar.gz',
      'cd puppet'
    ]

    puppet_cmd = 'sudo puppet apply '
    puppet_cmd += '--modulepath=/tmp/puppet/modules ' if defined? puppet_modules
    puppet_cmd += 'manifest.pp'

    cmds += [puppet_cmd]

    cmds.join(' && ')
  end

end
