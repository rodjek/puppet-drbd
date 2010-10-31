Puppet::Type.newtype(:drbd_startup) do
  @doc = "This is used to fine tune DRBD's startup properties."

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

  newproperty(:wfc_timeout) do
    desc "Wait for connection timeout.  The init script blocks the boot
      process until the DRBD resources are connected.  When the cluster
      manager starts later, it does not see a resource with internal split
      brain.  In case you want to limit the wait time, do it here.  Default
      is 0, which means unlimited.  The unit is seconds."
    newvalues /\d+/
  end

  newproperty(:degr_wfc_timeout) do
    desc "Wait for connection timeout, if this node was a degraded cluster.
      In case a degraged cluster (= cluster with only one node left) is 
      rebooted, this timeout is used instead of wfc_timeout, because the peer
      is less likely to show up in time, if it had been dead before.  Value 0
      means unlimited."
    newvalues /\d+/
  end

  newproperty(:outdated_wfc_timeout) do
    desc "Wait for connection timeout, if the peer was outdated.  In case a
      degraded cluster (= cluster with only one node left) with an outdated
      peer disk is rebooted, this timeout value is used instead of 
      wfc_timeout because the peer is not allowed to become primary in the
      meantime.  Value of 0 means unlimited."
    newvalues /\d+/
  end

  newproperty(:wait_after_sb) do
    desc "By setting this option you can make the init script continue to
      wait even if the device pair had a split brain situation and therefore
      refuses to connect."
    newvalues :true, :false
  end

  newproperty(:become_primary_on) do
    desc "Sets on which node the device should be promoted to primary role by
      the init script.  The value may be either a hostname or the keyword 
      'both'.  When this option is not set the devices stay in secondary role
      on both nodes.  Usually one delegates the role assignment to a cluster
      manager (e.g. heartbeat)."
  end
end
