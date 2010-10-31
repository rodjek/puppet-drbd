Puppet::Type.newtype(:drbd_handlers) do
  @doc = ""

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
    desc ""

    isnamevar
  end

  newproperty(:pri_on_incon_degr) do
    desc ""
  end

  newproperty(:pri_lost_after_sb) do
    desc ""
  end

  newproperty(:pri_lost) do
    desc ""
  end

  newproperty(:outdate_peer) do
    desc ""
  end

  newproperty(:local_io_error) do
    desc ""
  end

  newproperty(:split_brain) do
    desc ""
  end

  newproperty(:before_resync_target) do
    desc ""
  end

  newproperty(:after_resync_target) do
    desc ""
  end
end
