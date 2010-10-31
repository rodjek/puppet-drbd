Puppet::Type.newtype(:drbd_net) do
  @doc = "This is used to fine tune DRBD's network properties"

  ensurable do 
    newvalue(:present) do
      provider.create
    end

    newvalue(:absent) do
      provider.destroy
    end

    defaultto :present
  end

  newparam(:resource) do
    desc "The name of the DRBD resource that these properties should apply
      to.  Set this to 'global' if these properties should apply to all DRBD
      resources."
    isnamevar
  end

  newproperty(:sndbuf_size) do
    desc "The size of the TCP socket send buffer.  The default value is 0, 
      i.e. autotune.  You can specify smaller or larger values.  Larger values
      are appropriate for reasonable write throughput with protocol A over 
      high latency networks.  Very high values like 1M may cause problems.  
      Also, values below 32K do not make sense.  Since 8.0.13 resp. 8.2.7, 
      setting the size value to 0 means that the kernel should autotune this."
  end

  newproperty(:timeout) do
    desc "If the parter node fails to send an expected response packet within 
      this many 10ths of a second, the parter node is considered dead and 
      therefore the TCP/IP connection is abandoned.  This must be lower than 
      connect_int and ping_int.  The default value is 60 (=6 seconds), the 
      unit is 0.1 seconds."
    newvalue /\d+/

    validate do |value|
      unless value.to_f > 0
        raise ArgumentError, "timeout must be greater than 0"
      end
    end
  end

  newproperty(:connect_int) do
    desc "In case it is not possible to connect to the remote DRBD device
      immediately, DRBD keeps on trying to connect.  With this option you can
      set the time between two tries.  The default value is 10 seconds, the 
      unit is 1 second."
    newvalue /\d+/

    validate do |value|
      unless value.to_f > 0
        raise ArgumentError, "connect_int must be greater than 0"
      end
    end
  end

  newproperty(:ping_int) do
    desc "If the TCP/IP connection linking a DRBD device pair is idle for
      more than this many seconds, DRBD will generate a keep-alive packet to 
      check if its partner is still alive.  The default is 10 seconds, the 
      unit is 1 second."
    newvalue /\d+/

    validate do |value|
      unless value.to_f > 0
        raise ArgumentError, "ping_int must be greater than 0"
      end
    end
  end

  newproperty(:ping_timeout) do
    desc "The time the peer has to answer to a keep-alive packet.  In case 
      the peer's reply is not received within this time period, it is 
      considered as dead.  The default value is 500ms, the unit is 100ms."
    newvalue /\d+/

    validate do |value|
      unless value.to_f > 0
        raise ArgumentError, "ping_timeout must be greater than 0"
      end
    end
  end

  newproperty(:max_buffers) do
    desc "Maximum number of requests to be allocated by DRBD.  Unit is 
      PAGE_SIZE, which is 4KB on most systems.  The minimum is hard coded to 
      32 (=128KB).  For high-performance installations it might help if you 
      increase that number.  These buffers are used to hold data blocks while
      they are written to disk."
    newvalue /\d+/

    validate do |value|
      unless value.to_i >= 32
        raise ArgumentError, "max_buffers must be at least 32"
      end
    end
  end

  newproperty(:max_epoch_size) do
    desc "The highest number of data blocks between two write barriers.  If
      you set this smaller than 10, you might decrease your performance."
    newvalue /\d+/

    validate do |value|
      unless value.to_i > 0
        raise ArgumentError, "max_epoch_size must be greater than 0"
      end
    end
  end

  newproperty(:ko_count) do
    desc "In case the secondary node fails to complete a single write request
      for this many times the timeout, it is expelled from the cluster (i.e. 
      the primary node goes into StandAlone mode).  The default value is 0, 
      which disables this feature."
    newvalues /\d+/

    validate do |value|
      unless value.to_i > 0
        raise ArgumentError, "ko_count must be greater than 0"
      end
    end
  end

  newproperty(:allow_two_primaries) do
    desc "With this option set, you may assign primary role to both nodes. 
      You should only use this option if you use a shared file system on top
      of DRBD.  At the time of writing the only ones are: OCFS2 and GFS.  If
      you use this option with any other file system, you are going to crash
      your nodes and corrupt your data!"
    newvalues :true, :false
  end

  newproperty(:cram_hmac_alg) do
    desc "You need to specify the HMAC algorithm to enable peer
      authentication at all.  You are strongly encouraged to use peer 
      authentication.  The HMAC algorithm will be used for the challenge 
      response authentication of the peer.  You may specify digest algorithm 
      that is named in /proc/crypto."
  end

  newproperty(:shared_secret) do
    desc "The shared secret used in peer authentication.  May be up to 64 
      characters.  Note that peer authentication is disabled as long as no 
      cram_hmac_alg (see above) is specified."

    validate do |value|
      unless value.length <= 64
        raise ArgumentError, "shared_secret has a maximum length of 64"
      end
    end
  end

  newproperty(:after_sb_0pri) do
    desc "Policy to use when split brain has been detected and the resource 
      is not in the Primary role on any host.  Possible policies are:

      * disconnect
          No automatic resyncronization, simply disconnect.
      * discard_younger_primary
          Auto sync from the node that was primary before the split brain
          situation happened.
      * discard_older_primary
          Auto sync from the node that became primary as second during the
          split-brain situation.
      * discard_zero_changes
          In case one node did not write anything since the split brain
          became evident, sync from the node that wrote something to the node
          that did not write anything.  In case none wrote anything this
          policy uses a random decision to perform a 'resync' of 0 blocks.
          In case both have written something, this policy disconnects the
          nodes.
      * discard_least_changes
          Auto sync from the node that touched more blocks during the split
          brain situation.
      * discard_node_NODENAME
          Auto sync from the named node."

    newvalues :disconnect, :discard_younger_primary, :discard_older_primary,
      :discard_zero_changes, :discard_least_changes, /discard_node_[\d\w\._-]+/
  end

  newproperty(:after_sb_1pri) do
    desc "Policy to use when split brain has been detected and the resource
      is in the Primary role on one host.  Possible policies are:

      * disconnect
          No automatic resyncronization, simply disconnect.
      * consensus
          Discard the version of the secondary if the outcome of the 
          after_sb_0pri algorithm wolud also destroy the current secondary's
          data.  Otherwise disconnect.
      * discard_secondary
          Discard the secondary's version.
      * call_pri_lost_after_sb
          Always honor the outcome of the after_sb_0pri algorithm.  In case it
          decides the current secondary has the right data, it calls the
          pri_lost_after_sb handler on the current primary."
    newvalues :disconnect, :consensus, :discard_secondary, 
      :call_pri_lost_after_sb
  end

  newproperty(:after_sb_2pri) do
    desc "Policy to use when split brain has been detected and the resource
      is in the Primary role on both hosts.  Possible policies are:

      * disconnect
          No automatic resyncronization, simply disconnect.
      * call_pri_lost_after_sb
          Call the 'pri_lost_after_sb' helper program on one of the machines.
          This program is expected to reboot the machine i.e. make it secondary."
    newvalues :disconnect, :call_pri_last_after_sb
  end

  newproperty(:data_integrity_alg) do
    desc "DRBD can ensure the data integrity of the user's data on the network
      by comparing hash values.  Normally this is ensured by the 16 bit 
      checksums in the headers of TCP/IP packets.

      This option can be set to any o the kernel's data digest algorithms.  In
      a typical kernel configuration you should have at least one of md5, sha1,
      and crc32c available.  By default this is not enabled."
  end

  newproperty(:no_tcp_cork) do
    desc "DRBD usually uses the TCP socket option TCP_CORK to hint to the 
      network stack when it can expect more data, and when it should flush out
      what it has in its send queue.  It turned out that there is at least one
      network stack that performs worse when using this hinting method."
    newvalues :true, :false
  end
end
