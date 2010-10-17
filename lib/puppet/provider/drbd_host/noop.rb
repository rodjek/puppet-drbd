Puppet::Type.type(:drbd_host).provide(:noop) do
  desc "Dummy provider to be used on the Puppet runs before the DRBD " +
       "Augeas lens is installed."

  confine :false => File.exists? "/usr/share/augeas/lenses/drbd.aug"

  def create
  end

  def destroy
  end

  def exists?
    resource[:ensure] == :present ? true : false
  end

  def device
    resource[:device]
  end

  def device=(value)
  end

  def disk
    resource[:disk]
  end

  def disk=(value)
  end

  def address
    resource[:address]
  end

  def address=(value)
  end

  def meta_disk
    resource[:meta_disk]
  end

  def meta_disk=(value)
  end

  def flexible_meta_disk
    resource[:flexible_meta_disk]
  end

  def flexible_meta_disk=(value)
  end
end
