Puppet::Type.type(:drbd_resource).provide(:noop) do
  desc "Noop provider to be used in the Puppet runs before the Augeas lens " +
       "is installed."

  confine :false => File.exists? "/usr/share/augeas/lenses/drbd.aug"

  def create
  end

  def destroy
  end

  def exists?
    resource[:ensure] == :present ? true : false
  end

  def protocol
    resource[:protocol]
  end

  def protocol=(value)
  end
end
