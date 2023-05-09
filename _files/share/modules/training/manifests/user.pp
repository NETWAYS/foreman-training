class training::user (
  String $id,
  String $ssh_pub_key,
  Enum[ 'ssh-dss', 'dsa', 'ssh-rsa', 'rsa', 'ecdsa-sha2-nistp256', 'ecdsa-sha2-nistp384', 'ecdsa-sha2-nistp521', 'ssh-ed25519', 'ed25519' ] $ssh_key_type = 'ssh-rsa',
  Boolean $sudo = false
) {
  user { $id:
    ensure     => present,
    managehome => true,
  }

  ssh_authorized_key { $id:
    user => $id,
    type => $ssh_key_type,
    key  => $ssh_pub_key,
  }

  if $sudo {
    file { "/etc/sudoers.d/$id":
      ensure => file,
      mode   => '0400',
      owner  => 'root',
      group  => 'root',
      content => "$id ALL=(ALL) NOPASSWD: ALL",
    }
  }
}

