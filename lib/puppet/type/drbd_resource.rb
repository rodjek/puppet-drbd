Puppet::Type.newtype(:drbd_resource) do
  @doc = "Configures a DRBD resource."

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
    desc "The name of the DRBD resource."
    isnamevar
  end

  newproperty(:protocol) do
    desc "The required DRBD protocol to be used on the TCP/IP link."
    
    newvalues /[ABC]/
    defaultto :C
  end
end
