Puppet::Type.newtype(:drbd_disk) do
  @doc = ""

  ensureable do
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
    desc ""
  end

  newproperty(:on_io_error) do
    desc ""
    newvalues :absent, :pass_on, :call_local_io_error, :detach
    defaultto :absent
  end

  newproperty(:size) do
    desc "Manually specify the size of the DRBD resource"
    newvalues /\d+\w+/

    validate do |value|
      unless value.to_f > 0
        raise ArgumentError, "The size of the DRBD resource must be greater than 0"
      end
    end
  end

  newproperty(:fencing) do
    desc ""
    newvalues :dont_care, :resource_only, :resource_and_stonith
  end

  newproperty(:use_bmbv) do
    desc ""
    newvalues :true, :false
  end

  newproperty(:no_disk_flushes) do
    desc ""
    newvalues :true, :false
  end

  newproperty(:no_disk_barrier) do
    desc ""
    newvalues :true, :false
  end

  newproperty(:no_disk_drain) do
    desc ""
    newvalues :true, :false
  end

  newproperty(:no_md_flushes) do
    desc ""
    newvalues :true, :false
  end

  newproperty(:max_bio_bvecs) do
    desc ""
    newvalues /\d+/
  end
end
