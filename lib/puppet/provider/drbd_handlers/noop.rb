Puppet::Type(:drbd_handlers).provide(:noop) do
  desc ""

  confine :false => File.exists? "/usr/share/augeas/lenses/drbd.aug"

  def create
  end

  def destroy
  end

  def exists?
    resource[:ensure] == :present ? true : false
  end

  def pri_on_incon_degr
    resource[:pri_on_incon_degr]
  end

  def pri_on_incon_degr=(value)
  end

  def pri_lost_after_sb
    resource[:pri_lost_after_sb]
  end

  def pri_lost_after_sb=(value)
  end

  def pri_lost
    resource[:pri_lost]
  end

  def pri_lost=(value)
  end

  def outdate_peer
    resource[:outdate_peer]
  end

  def outdate_peer=(value)
  end

  def local_io_error
    resource[:local_io_error]
  end

  def local_io_error=(value)
  end

  def split_brain
    resource[:split_brain]
  end

  def split_brain=(value)
  end

  def before_resync_target
    resource[:before_resync_target]
  end

  def before_resync_target=(value)
  end

  def after_resync_target
    resource[:after_resync_target]
  end

  def after_resync_target=(value)
  end
end
