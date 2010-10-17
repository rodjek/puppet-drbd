Puppet::Type.newtype(:drbd_host) do
  @doc = "Describes the necessary configuration parameters for a DRBD " +
         "device of an enclosing resource."

  ensurable do
    newvalue(:present) do
      provider.create
    end

    newvalue(:absent) do
      provider.destroy
    end

    defaultto :present
  end

  newparam(:name) do
    desc "A throwaway value"
    isnamevar
  end

  newparam(:resource) do
    desc "DRBD resource name"
  end

  newparam(:hostname) do
    desc "The hostname of the DRBD host (must match the output of uname -n)"
  end

  newproperty(:device) do
    desc "The minor number of the DRBD device (e.g. 0 for /dev/drbd0)"
  end

  newproperty(:disk) do
    desc "The local block device used to store and retrieve the data."
  end

  newproperty(:address) do
    desc "IPv4 address:port combination for the host"
  end

  newproperty(:meta_disk) do
    desc "If a device is specified, DRBD will allocate a fixed metadata " +
         "area of 128M.  If internal, the metadata area is flexible in size."
  end

  newproperty(:flexible_meta_disk) do
    desc "If a device is specified, DRBD will allocate a metadata area " +
         "roughly proportional to the size of the DRBD device (up to 128M)."
  end

  autorequire(:drbd_resource) do
    self[:resource]
  end

  validate do
    unless @parameters.include?(:meta_disk) or @parameters.include?(:flexible_meta_disk)
      raise Puppet::Error, "You must specify either meta_disk or flexible_meta_disk"
    end

    unless @parameters.include?(:resource)
      raise Puppet::Error, "You must specify a DRBD resource name"
    end

    unless @parameters.include?(:hostname)
      raise Puppet::Error, "You must specify the hostname of the server"
    end
  end
end
